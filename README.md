# Global Catalogue of Prokaryotic and Viral Genomes from Anaerobic Digestion

Core command modules for code presentation. Original analysis by Pengbo Jiao.
Original thresholds are retained with example paths and packaging fixes.
These are individual method demonstrations, not a one-command workflow.

| Script | Original script lines |
| --- | --- |
| `01_public_data_download.sh` | 4-5 |
| `02_read_quality_control.sh` | 7-16 |
| `03_metagenome_assembly.sh` | 18-20 |
| `04_mag_binning_refinement.sh` | 22-24 |
| `05_viral_sequence_identification.sh` | 26-66 |
| `06_votu_clustering_quality.sh` | 68-74 |
| `07_viral_abundance.sh` | 86-132 |
| `08_custom_host_database.sh` | 156-195 |
| `09_viral_host_prediction.sh` | 135-154; 196-214 |
| `10_mag_phylogeny.sh` | 216-241 |
| `11_functional_arg_annotation.sh` | 245-270 |
| `12_auxiliary_metabolic_genes.sh` | 272-286 |

Review example paths, inputs and existing tool environments before running individual sections on Linux.
See [使用说明.md](使用说明.md) for dependencies, packaging changes and missing steps.
