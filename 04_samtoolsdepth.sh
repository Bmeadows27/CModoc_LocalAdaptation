#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=coverage
#SBATCH --partition quanah
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G

samtools depth -a C001_final.bam C002_final.bam C007_final.bam C015_final.bam C017_final.bam C019_final.bam C036_final.bam C037_final.bam \
C041_final.bam C044_final.bam C045_final.bam C047_final.bam C055_final.bam C057_final.bam C060_final.bam C061_final.bam C074H_final.bam \
C081_final.bam C090_final.bam C097_final.bam C104_final.bam C107_final.bam C109_final.bam \
C111_final.bam C112_final.bam C119_final.bam C120_final.bam C122_final.bam C126_final.bam C193_final.bam \
C200_final.bam C202_final.bam C203_final.bam C225_final.bam C233_final.bam C235_final.bam C236_final.bam \
C237_final.bam C242_final.bam C246_final.bam C254_final.bam C255_final.bam >  cmodoc_coverage.txt


# break up the depth files into single column files for each individual (locations dropped)

while read -r name1 number1; do
        number2=$((number1 + 2));
  cut cmodoc_coverage.txt -f $number2 > ${name1}_depth.txt;
done < modoc_popmap.txt
