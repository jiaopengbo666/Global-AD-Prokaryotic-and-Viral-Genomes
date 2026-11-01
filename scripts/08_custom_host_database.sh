#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 8. Custom iPHoP host database construction
# Prepare bacteria.batch.tsv and archaea.batch.tsv with the original MAG IDs.
# Use GTDB-Tk 2.6.1 / R226, then the iPHoP environment.
# Activate the corresponding existing tool environment for this section.
env GTDBTK_DATA_PATH=/Database/gtdbtk-release226/release226 \
  gtdbtk de_novo_wf \
  --batchfile bacteria.batch.tsv \
  --bacteria \
  --outgroup_taxon p__Patescibacteriota \
  --out_dir bacteria_de_novo \
  --cpus 16 \
  > bacteria_de_novo.log 2>&1

env GTDBTK_DATA_PATH=/Database/gtdbtk-release226/release226 \
  gtdbtk de_novo_wf \
  --batchfile archaea.batch.tsv \
  --archaea \
  --outgroup_taxon p__Altiarchaeota \
  --out_dir archaea_de_novo \
  --cpus 16 \
  > archaea_de_novo.log 2>&1

mkdir -p GTDB_R226_for_iphop/infer

cp bacteria_de_novo/infer/gtdbtk.bac120.decorated.tree \
      bacteria_de_novo/infer/gtdbtk.bac120.decorated.tree-taxonomy \
      archaea_de_novo/infer/gtdbtk.ar53.decorated.tree \
      archaea_de_novo/infer/gtdbtk.ar53.decorated.tree-taxonomy \
      GTDB_R226_for_iphop/infer/
iphop add_to_db \
  --fna_dir dereplicated_genomes/ \
  --gtdb_dir GTDB_R226_for_iphop/ \
  --db_dir /Database/iPHoP/Jun_2025_pub_rw/ \
  --out_dir AD_custom_host_db/ \
  -t 100 \
  > AD_custom_host_db.log 2>&1
