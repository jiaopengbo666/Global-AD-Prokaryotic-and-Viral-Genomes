# Global Catalogue of Prokaryotic and Viral Genomes from Anaerobic Digestion

Analysis scripts for anaerobic digestion metagenomes, covering prokaryotic genome recovery, viral identification, abundance estimation, host prediction, and functional annotation.

**Author:** Pengbo Jiao

**Publication status:** The manuscript is in preparation and has not yet been published.

## Analysis modules

| Module | Analysis | Main tools |
|---|---|---|
| 01 | Public sequencing data download | SRA Toolkit |
| 02 | Read quality control | Trimmomatic |
| 03 | Metagenome co-assembly | metaWRAP |
| 04 | MAG binning and refinement | metaWRAP |
| 05 | Viral sequence identification | VirSorter2, VIBRANT, geNomad |
| 06 | vOTU clustering and quality assessment | CD-HIT-EST, CheckV |
| 07 | Viral abundance estimation | Bowtie2, SAMtools, CoverM |
| 08 | Custom viral host database construction | GTDB-Tk, iPHoP |
| 09 | Viral host prediction | iPHoP |
| 10 | MAG phylogenetic analysis | GTDB-Tk |
| 11 | ORF prediction, functional annotation, and ARG alignment | Prodigal, eggNOG-mapper, BLASTp |
| 12 | Auxiliary metabolic gene analysis | VIBRANT, DRAM-v |

## Usage

Scripts are available in the `scripts/` directory. Configure input files, database paths, and thread counts, then activate the appropriate software environment and run the required module on Linux:

```bash
bash scripts/02_read_quality_control.sh
```
