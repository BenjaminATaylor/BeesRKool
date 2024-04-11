process DESEQ_BASIC{
  
  label 'mid_job'
  publishDir "$params.outdir"

  input: 
  tuple path(samplesheet), path(countsframe) 

  output:
  path "deseq_table.csv", emit: table
  path "deseq_degs.txt", emit: degs

  script:
  """
  #!/usr/bin/env Rscript
  library("tidyverse", quietly = TRUE)
  library("DESeq2", quietly = TRUE)

  samplesheet = read.csv("$samplesheet")
  countsframe.clean = read.csv("$countsframe", row.names = 1)

  #generate model
  dds = DESeqDataSetFromMatrix(countData = countsframe.clean,
                               colData = samplesheet,
                               design = as.formula(~phenotype))
  # Run the default analysis for DESeq2
  dds.deg = DESeq(dds, fitType = "parametric", betaPrior = FALSE)
  write.csv(data.frame(results(dds.deg)),row.names=TRUE, file = "deseq_table.csv")
  
  # get list of degs
  DEGs = row.names(subset(data.frame(results(dds.deg)), padj<0.05 & abs(log2FoldChange) > 1))
  write(DEGs, file = "deseq_degs.txt")
  
  """
}