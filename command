nextflow run main.nf \
    --samplesheet "input/samplesheet.csv" \
    --countsframe "input/genecounts.tsv" \
    --reflevel "nurse" \
    --outdir "output" \
    -w work