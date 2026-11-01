#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 12. Auxiliary metabolic gene analysis
# VIBRANT predicts its own ORFs independently of module 11.
time VIBRANT_run.py \
    -i "vOTU_final_version.renamed.fna" \
    -t 60 \
    -d "/Database/VIBRANT/databases/" \
    -m "/Database/VIBRANT/files/" \
    -folder VIBRANT_AMG
## 12.1 VirSorter2 preparation for DRAM-v
time virsorter run --prep-for-dramv -w 0.VS2 \
  -i vOTU_final_version.renamed.fna -j 50 all

## 12.2 DRAM-v annotation and distillation
# Use the existing DRAM-1.5.0 environment for these commands.
time DRAM-v.py annotate \
  -i 0.VS2/for-dramv/final-viral-combined-for-dramv.fa \
  -v 0.VS2/for-dramv/viral-affi-contigs-for-dramv.tab \
  -o DRAMv-annotate --threads 100
time DRAM-v.py distill -i DRAMv-annotate/annotations.tsv \
  -o DRAMv-distill --remove_transposons --remove_fs
