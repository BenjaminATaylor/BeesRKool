#!/usr/bin/env nextflow

// Modules to include
include { CLEANINPUTS } from './modules/cleaninputs.nf'
include { QUALITYCONTROL } from './modules/qualitycontrol.nf'
include { DESEQ_BASIC } from './modules/deseq_basic.nf'
include { HIPYTHON } from './modules/hipython.nf'


// Validate inputs
if (params.samplesheet) { ch_samplesheet = file(params.samplesheet) } else { exit 1, 'Input samplesheet not specified!' }
if (params.countsframe) { ch_countsframe = file(params.countsframe) } else { exit 1, 'Input count frame not specified!' }
if (params.reflevel) { ch_reflevel = params.reflevel } else { exit 1, 'Reference level not specified!' }

println("Sample sheet: " + ch_samplesheet)
println("Counts matrix: " + ch_countsframe)
println("Reference level: " + ch_reflevel)

workflow {
  // Initial data cleanup
  CLEANINPUTS(ch_samplesheet, ch_countsframe, ch_reflevel)
  
  // Generate some QC plots
  QUALITYCONTROL(CLEANINPUTS.out)

  //Basic DESeq2 analysis
  DESEQ_BASIC(CLEANINPUTS.out)  
  
  //Report DESeq2 DEG information to stdout (using Python, just to demonstrate)
  HIPYTHON(DESEQ_BASIC.out.degs) | view
  
}
