#!/usr/bin/env bash
# Global anaerobic digestion virome database
# Author: Pengbo Jiao

## 1. Public sequencing data download
prefetch SRR8925731
fasterq-dump --split-3 SRR8925731/SRR8925731.sra
