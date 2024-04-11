#nextflow run BenjaminATaylor/BeesRKool -r main  \
nextflow run main.nf \
    -profile local \
    --samplesheet "input/samplesheet.csv" \
    --countsframe "input/genecounts.tsv" \
    --reflevel "nurse" \
    --outdir "output" \
    -w work
