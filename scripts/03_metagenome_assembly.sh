#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 3. Metagenome co-assembly
# Pool samples within one BioProject or subgroup.
mkdir -p all_reads
cat clean_reads/*_1.fastq > all_reads/all_reads_1.fastq
cat clean_reads/*_2.fastq > all_reads/all_reads_2.fastq
time metawrap assembly \
    -1 ./all_reads/all_reads_1.fastq \
    -2 ./all_reads/all_reads_2.fastq \
    -m 800 \
    -t 40 \
    -o ASSEMBLY
