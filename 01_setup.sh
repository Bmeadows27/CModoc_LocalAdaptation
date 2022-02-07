# Working directory
/lustre/scratch/brameado_Camponotus_Local_Adaptation

# Directories
mkdir 00_fastq
mkdir 01_cleaned
mkdir 01_mtDNA
mkdir 01_bam_files
mkdir 02_vcf
mkdir 03_vcf
mkdir 04_filter_vcf_admixture
mkdir 05_filter_vcf_heterozygosity
mkdir 06_filter_vcf_GEA
mkdir 07_LEA
mkdir 08_BayeScEnv
mkdir 10_align_script
mkdir 12_filter_scripts
mkdir 13_coverage_map

#Transfer raw fastq files to 00_fastq
#Create rename_files.txt file, popmap, and mtDNA files and add them to working directory

#To rename files
while read -r name1 name2; do
	mv $name1 $name2
done < rename_samples.txt

#Copy reference genome to working directory
cd /lustre/scratch/brameado/Camponotus_Local_Adaptation
cp /home/jmanthey/denovo_genomes/camp_sp_genome_filtered.fasta.fai .

























