
start interactive session
interactive -p quanah

# move to admixture directory
cd /lustre/scratch/brameado/Camponotus_Local_Adaptation/04_filter_vcf_admixture

#Rename vcf file 
cat scaffold0001.recode.vcf >bloch_admixture.vcf

# make chromosome map for the vcf
grep -v "#" bloch_admixture.vcf | cut -f 1 | uniq | awk '{print $0"\t"$0}' > bloch_chrom_map.txt

# run vcftools for the combined vcf
vcftools --vcf bloch_admixture.vcf  --plink --chrom-map bloch_chrom_map.txt --out bloch_admixture 

# convert the file with plink
/home/jmanthey/plink --file bloch_admixture --recode12 --out bloch_admixture2 --noweb

# run admixture 
for K in 1 2 3 4 5; do /home/jmanthey/admixture --cv bloch_admixture2.ped $K --haploid="*" | tee log_bloch_admixture_${K}.out; done

# check cv 
grep -h CV log_bloch_admixture_*.out

