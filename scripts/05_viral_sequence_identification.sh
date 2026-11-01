#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 5. Viral sequence identification
# Example project; repeat identification for each BioProject/subgroup.
project="ProjectA"
# Use the same project-prefixed contig IDs for both identification tools.
contigs="${project}_contigs.fasta"
mkdir -p VS_out VB_out
## 5.1 VirSorter2
time virsorter run \
    -w "VS_out/$project" \
    -i "$contigs" \
    --min-length 5000 \
    --rm-tmpdir \
    --verbose \
    -j 10 all \
    -d /Database/virsorter2/
## 5.2 VIBRANT
time VIBRANT_run.py \
    -i "$contigs" \
    -t 40 \
    -l 5000 \
    -folder "VB_out/$project" \
    -d "/Database/VIBRANT/databases/" \
    -m "/Database/VIBRANT/files/"
## 5.3 Result integration across projects
# Run after all projects are ready. Verify ID parsing for the actual contig names.
mkdir -p ViralContigs
for project in VS_out/* ; do
    pro=$(basename "$project");
    echo $pro;
    mkdir -p ViralContigs/$pro;
    tmp_dir=ViralContigs/$pro;
    cp VS_out/${pro}/final-viral-score.tsv ${tmp_dir};
    cp VS_out/${pro}/final-viral-combined.fa ${tmp_dir};
    cp VB_out/${pro}/VIBRANT_${pro}_contigs/VIBRANT_phages_${pro}_contigs/${pro}_contigs.phages_combined.txt ${tmp_dir}; done


for project in ViralContigs/* ; do
   pro=$(basename "$project")
   echo $pro
   (
   cd "ViralContigs/${pro}" || exit 1
   mkdir -p ./tmp
   awk '{if ($4>=0.9) print $1}' ./final-viral-score.tsv > ./tmp/score0.9_name.txt
   awk '{if ($4>=0.7 && $7>=1) print $1}' ./final-viral-score.tsv > ./tmp/score0.7_hallmark1_name.txt
cat ./tmp/score0.9_name.txt ./tmp/score0.7_hallmark1_name.txt > ./tmp/VS2_viral_contig_name.txt
   sort -n ./tmp/VS2_viral_contig_name.txt | uniq > ./tmp/VS2_viral_contig_uniqname.txt
   cut -f1 -d"|" ./tmp/VS2_viral_contig_uniqname.txt > ./tmp/VS2_phage_uniqname.txt
   awk '{if ($4>=0.5) print $1}' ./final-viral-score.tsv > ./tmp/score0.5_name.txt
   cut -f1 -d"|" ./tmp/score0.5_name.txt > ./tmp/score0.5_ID.txt
   cut -f1-7 -d"_" ./${pro}_contigs.phages_combined.txt > ./tmp/VB_ID.txt  # Use -f1-8 for subgroup IDs.
   cat ./tmp/score0.5_ID.txt ./tmp/VB_ID.txt | sort | uniq -d > ./tmp/VS2_VB_viral_contig_name.txt
   cat ./tmp/VS2_phage_uniqname.txt ./tmp/VS2_VB_viral_contig_name.txt | sort -n | uniq > ./tmp/phage_name.txt
   grep -f ./tmp/phage_name.txt ./final-viral-combined.fa > ./tmp/phage.txt
   sed -i 's/>//' ./tmp/phage.txt
   seqkit grep \
       -f ./tmp/phage.txt ./final-viral-combined.fa \
       -j 50 \
       -o ./viral.contigs.fasta
) || exit 1
done
cat ViralContigs/*/viral.contigs.fasta > All_AD_viral_contigs.fasta
## 5.4 Minimum sequence length filtering
time seqkit seq \
    -m 5000 All_AD_viral_contigs.fasta \
    > All_AD_viral_contigs_5K.fasta
## 5.5 Additional screening with geNomad
time genomad end-to-end \
    --cleanup \
    --splits 8 All_AD_viral_contigs_5K.fasta ./genomad_out "/Database/genomad_db/" \
    -t 100
