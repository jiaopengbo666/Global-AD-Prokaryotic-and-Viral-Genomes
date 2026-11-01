#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 11. ORF prediction, functional annotation and ARG alignment
mkdir -p prodigal eggnog
prodigal -i vOTU_final_version.renamed.fna \
  -p meta -g 11 \
  -a prodigal/GADV_genes.faa \
  -d prodigal/GADV_genes.ffn \
  -f gff -o prodigal/GADV_genes.gff \
  2> prodigal/GADV_prodigal.log
emapper.py \
  -i prodigal/GADV_genes.faa \
  -o GADV_eggnog \
  -m diamond \
  --cpu 30 \
  --data_dir /Database/eggNOG \
  --output_dir eggnog/ \
  > eggnog/GADV_eggnog.log 2>&1
time blastp -task blastp \
  -db /Database/SARG3.2.1-S/SARG3.2.1-S \
  -query "prodigal/GADV_genes.faa" \
  -evalue 1e-5 \
  -num_threads 70 \
  -max_target_seqs 5 \
  -out ./viral_ARG.txt \
  -outfmt "6 qseqid sseqid pident qcovhsp mismatch gapopen qstart qend sstart send evalue bitscore"
# BLASTp outputs alignment hits; downstream ARG filtering is not supplied.
