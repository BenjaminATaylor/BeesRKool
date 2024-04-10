nextflow run BenjaminATaylor/BeesRKool -r main  \
    --samplesheet "input/samplesheet.csv" \
    --countsframe "input/genecounts.tsv" \
    --reflevel "nurse" \
    --outdir "output" \
    -w work