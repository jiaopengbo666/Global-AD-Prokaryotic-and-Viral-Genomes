#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 6. vOTU clustering and quality assessment
mkdir -p cd-hit
time cd-hit-est \
    -i genomad_out/All_AD_viral_contigs_5K_summary/All_AD_viral_contigs_5K_virus.fna \
    -o ./cd-hit/vOTU.fasta \
    -M 0 \
    -T 120 \
    -c 0.95 \
    -aS 0.85 \
    -d 0
time checkv end_to_end "cd-hit/vOTU.fasta" checkV \
    -t 100 \
    -d "/Database/checkv-db-v1.5/"
cat "checkV/proviruses.fna" "checkV/viruses.fna" > vOTU_final_version.fna
# Rename vOTUs with the external vOTU_rename.py helper.
# Downstream input: vOTU_final_version.renamed.fna.
