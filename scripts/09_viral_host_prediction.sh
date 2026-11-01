#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 9. Viral host prediction with iPHoP
viral_fasta="vOTU_final_version.renamed.fna"
standard_db="/Database/iPHoP/Jun_2025_pub_rw"
custom_db="AD_custom_host_db"
## 9.1 Standard database prediction
iphop predict --fa_file "$viral_fasta" --db_dir "$standard_db" \
  --out_dir standard_prediction -t 100 --min_score 75
## 9.2 Input splitting
iphop split --input_file "$viral_fasta" --split_dir custom_db_batch --n_seq 17181
## 9.3 Custom database batch prediction
mkdir -p custom_prediction
for fasta in custom_db_batch/*.fna; do
    batch=$(basename "$fasta" .fna)
    env PYTHONUNBUFFERED=1 iphop predict \
      --fa_file "$fasta" --db_dir "$custom_db" \
      --out_dir "custom_prediction/$batch" -t 100 --min_score 75 \
      > "custom_prediction/$batch.log" 2>&1
done
