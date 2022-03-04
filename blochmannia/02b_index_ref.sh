#Move to working directory
cd /lustre/scratch/brameado/Blochmannia_Local_Adaptation

#copy reference genome from Joe's home directory
cp 2_modoc.fasta /lustre/scratch/brameado/Blochmannia_Local_Adaptation

#Use Samtools faidx to index reference genome and create fasta.fai file
samtools faidx 2_modoc.fasta 

#use bwa index to index database sequences in fasta format
bwa index 2_modoc.fasta

#use picard CreateSequenceDictionary to create a sequence dictionary for the reference sequences
java -jar /home/jmanthey/picard.jar CreateSequenceDictionary R=2_modoc.fasta O=2_modoc.dict
