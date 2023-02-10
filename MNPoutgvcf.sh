#!/bin/bash
#MNPout_GVCF

cd ~/Desktop/CD_genomics/Batch1
for F in *.gvcf ; do   bcftools view --exclude-types mnps ${F} -o ~/Desktop/CD_genomics/Batch1_MNPout/${F}.gvcf  ; done
