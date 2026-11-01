#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 7. Viral abundance estimation
# Quantify metagenomic samples only; viromes contribute to identification.
sample="SampleA"
BT2_INDEX="bowtie2_index/AD_vOTU_db"
r1="clean_reads/${sample}_clean_1.fastq"
r2="clean_reads/${sample}_clean_2.fastq"
sam="mapping/${sample}.sam"
bam="mapping/${sample}.sorted.bam"
output="abundance/${sample}_abundance.txt"
BOWTIE2_THREADS=40
SAMTOOLS_THREADS=20
COVERM_THREADS=20
mkdir -p bowtie2_index mapping abundance
## 7.1 Bowtie2 index construction
time bowtie2-build ./vOTU_final_version.renamed.fna "$BT2_INDEX"
## 7.2 Read mapping, BAM sorting and abundance estimation
time bowtie2 \
        -x "$BT2_INDEX" \
        -1 "$r1" \
        -2 "$r2" \
        -S "$sam" \
        -p "$BOWTIE2_THREADS" \
        --sensitive
time samtools view \
        -F 4 \
        -bS "$sam" \
        --threads "$SAMTOOLS_THREADS" \
    | samtools sort \
        --threads "$SAMTOOLS_THREADS" \
        -o "$bam" \
        -
# Activate the corresponding existing tool environment for this section.
time coverm contig \
        --methods count rpkm \
        --bam-files "$bam" \
        --min-read-percent-identity 95 \
        --min-read-aligned-percent 75 \
        -t "$COVERM_THREADS" \
        > "$output"
# Repeat for all samples. Check sample IDs against metadata before merging.
# Final matrix merging uses the external check.py helper.
