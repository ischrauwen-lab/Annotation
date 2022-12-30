# Annotation

Note: if the following error appears: \
`Error occurred during initialization of VM` \
`Could not reserve enough space for 50331648KB object heap` 

reduce memory by adding --mem=10 OR --mem=8 to the analysis_commands.txt or initial command \
change time: --time 72:00:00 to initial command \
start from step already finished when cut-off early (make sure to use the same script as previously) add: "-s build" to analysis_commands txt file

## examples 

### Run annotation only

#### BGI BATCH9
NAME.vcf.gz

sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb submit_csg \
    --cmd_file analysis_commands_BGI_Batch9_ANN.txt 

#### analysis_commands_BGI_Batch9_ANN.txt
sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb annovar \
--container-option /mnt/mfs/statgen/containers/gatk4-annovar.sif \
--vcf-prefix /mnt/mfs/statgen/isabelle/BGI_BATCH9_BGISEQ_extra/combine/result_variation/combine \
--keep "splic|exonic" --humandb /mnt/mfs/statgen/isabelle/REF/humandb \
--x-ref /mnt/mfs/statgen/isabelle/REF/humandb/mart_export_2021_LOFtools.txt

### Run joint calling

#### SA2 batch
sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb submit_csg \
    --cmd_file analysis_commands_SA2.txt 
    
#### analysis_commands_SA2.txt 
sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb call \
--container-option /mnt/mfs/statgen/containers/gatk4-annovar.sif \
--vcf-prefix /mnt/mfs/statgen/isabelle/African_BAM/African_VCF_files/SA2/Merged/SA2 \
--samples /mnt/mfs/statgen/isabelle/African_BAM/African_VCF_files/SA2/SA2.txt \
--samples-dir /mnt/mfs/statgen/isabelle/African_BAM/African_VCF_files/SA2/SA2/ \
--ref-genome /mnt/mfs/statgen/isabelle/REF/refs/Homo_sapiens.GRCh37.75.dna_sm.primary_assembly.fa

### Full EXAMPLE
sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb call \
--container-option /mnt/mfs/statgen/containers/gatk4-annovar.sif \
--vcf-prefix output/minimal_example \
--samples /mnt/mfs/statgen/data_private/gatk_joint_call_example/20200820_sample_manifest.txt \
--samples-dir /mnt/mfs/statgen/data_private/gatk_joint_call_example/ \
--ref-genome /mnt/mfs/statgen/isabelle/REF/refs/Homo_sapiens.GRCh37.75.dna_sm.primary_assembly.fa

sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb filter \
--container-option /mnt/mfs/statgen/containers/gatk4-annovar.sif \
--vcf-prefix output/minimal_example

sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb annovar \
--container-option /mnt/mfs/statgen/containers/gatk4-annovar.sif \
--vcf-prefix output/minimal_example.snp_indel.filter.PASS \
--keep "splic|exonic" \
--humandb /mnt/mfs/statgen/isabelle/REF/humandb \
--x-ref /mnt/mfs/statgen/isabelle/REF/humandb/mart_export_2019_LOFtools3.txt

### To skip step 2 (filter) -> Output name of RAW file is vcf-prefix name

sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb call \
--container-option /mnt/mfs/statgen/containers/gatk4-annovar.sif \
--vcf-prefix output/minimal_example \
--samples /mnt/mfs/statgen/data_private/gatk_joint_call_example/20200820_sample_manifest.txt \
--samples-dir /mnt/mfs/statgen/data_private/gatk_joint_call_example/ \
--ref-genome /mnt/mfs/statgen/isabelle/REF/refs/Homo_sapiens.GRCh37.75.dna_sm.primary_assembly.fa

sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb annovar \
--container-option /mnt/mfs/statgen/containers/gatk4-annovar.sif \
--vcf-prefix output/minimal_example --keep "splic|exonic" \
--humandb /mnt/mfs/statgen/isabelle/REF/humandb \
--x-ref /mnt/mfs/statgen/isabelle/REF/humandb/mart_export_2019_LOFtools3.txt

### Update memory

sos run ~/gatk_joint_calling/gatk_joint_calling.ipynb submit_csg --cmd_file analysis_commands_CDgenomic_batch1_051622.txt --mem 64

###example analysis_commands.txt with new pipeline
module load Singularity
module load VCFTOOLS/0.1.17
module load PLINK/1.9.10
module load TABIX/1.6
sos run ~/bioworkflows/variant-calling/gatk_joint_calling.ipynb call \
    --container-option /mnt/vast/hpc/csg/containers/gatk4-annovar.sif \
    --vcf-prefix /mnt/vast/hpc/csg/Thashi/Wave4_AFRbatch3_2/AFRBatch3_2_Joint_calling/Wave4_AfrBatch3_2 \
    --samples /mnt/vast/hpc/csg/Thashi/Wave4_AFRbatch3_2/AFRBatch3_2/Samples_Wave4_AFRbatch3_2.txt \
    --samples-dir /mnt/vast/hpc/csg/Thashi/Wave4_AFRbatch3_2/AFRBatch3_2/ \
    --ref-genome /mnt/vast/hpc/csg/isabelle/REF/refs/resources_broad_hg38_v0_Homo_sapiens_assembly38.fasta \
    --cwd /mnt/vast/hpc/csg/Thashi/Wave4_AFRbatch3_2/AFRBatch3_2_Joint_calling/ \
    --vcf-filter basic

sos run ~/bioworkflows/variant-calling/gatk_joint_calling.ipynb basic_filter \
    --container-option /mnt/vast/hpc/csg/containers/gatk4-annovar.sif \
    --vcf-prefix /mnt/vast/hpc/csg/Thashi/Wave4_AFRbatch3_2/AFRBatch3_2_Joint_calling/Wave4_AfrBatch3_2 \
    --ref-genome /mnt/vast/hpc/csg/isabelle/REF/refs/resources_broad_hg38_v0_Homo_sapiens_assembly38.fasta \
    --cwd /mnt/vast/hpc/csg/Thashi/Wave4_AFRbatch3_2/AFRBatch3_2_Joint_calling/ \
    --vcf-filter basic

sos run ~/bioworkflows/variant-calling/gatk_joint_calling.ipynb vcf_qc \
    --container-option /mnt/vast/hpc/csg/containers/gatk4-annovar.sif \
    --vcf-prefix /mnt/vast/hpc/csg/Thashi/Wave4_AFRbatch3_2/AFRBatch3_2_Joint_calling/Wave4_AfrBatch3_2 \
    --cwd /mnt/vast/hpc/csg/Thashi/Wave4_AFRbatch3_2/AFRBatch3_2_Joint_calling/ \
    --vcf-filter basic
