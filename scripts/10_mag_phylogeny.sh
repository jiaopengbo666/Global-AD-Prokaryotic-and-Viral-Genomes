#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 10. MAG-only phylogenetic trees for host visualization
time env GTDBTK_DATA_PATH=/Database/gtdbtk-release226/release226 \
  gtdbtk identify \
  --genome_dir dereplicated_genomes/ \
  --extension fa \
  --out_dir tree_markers_full \
  --cpus 40
time env GTDBTK_DATA_PATH=/Database/gtdbtk-release226/release226 \
  gtdbtk align \
  --identify_dir tree_markers_full \
  --out_dir tree_markers_full \
  --skip_gtdb_refs \
  --cpus 40
time env GTDBTK_DATA_PATH=/Database/gtdbtk-release226/release226 \
  gtdbtk infer \
  --msa_file tree_markers_full/align/gtdbtk.bac120.user_msa.fasta.gz \
  --out_dir tree_bacteria_full \
  --prefix AD_bacteria_full \
  --cpus 40
time env GTDBTK_DATA_PATH=/Database/gtdbtk-release226/release226 \
  gtdbtk infer \
  --msa_file tree_markers_full/align/gtdbtk.ar53.user_msa.fasta.gz \
  --out_dir tree_archaea_full \
  --prefix AD_archaea_full \
  --cpus 40
