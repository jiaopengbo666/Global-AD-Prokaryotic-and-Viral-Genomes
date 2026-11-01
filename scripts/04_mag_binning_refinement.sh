#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 4. MAG binning and refinement
time metawrap binning \
    -o INITIAL_BINNING \
    -t 30 \
    -a ./ASSEMBLY/final_assembly.fasta \
    --metabat2 \
    --maxbin2 \
    --concoct ./clean_reads/*fastq
time metawrap bin_refinement \
    -o BIN_REFINEMENT \
    -t 20 \
    -A INITIAL_BINNING/metabat2_bins/ \
    -B INITIAL_BINNING/maxbin2_bins/ \
    -C INITIAL_BINNING/concoct_bins/ \
    -c 50 \
    -x 10
