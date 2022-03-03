#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=coverage
#SBATCH --partition quanah
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G

module load intel samtools

samtools depth -a B001_final.bam B002_final.bam B007_final.bam B015_final.bam B017_final.bam B019_final.bam B036_final.bam B037_final.bam \
B041_final.bam B044_final.bam B045_final.bam B047_final.bam B055_final.bam B057_final.bam B060_final.bam B061_final.bam B074_final.bam \
B081_final.bam B090_final.bam B097_final.bam B104_final.bam B107_final.bam B109_final.bam \
B111_final.bam B112_final.bam B119_final.bam B120_final.bam B122_final.bam B126_final.bam B193_final.bam \
B200_final.bam B202_final.bam B203_final.bam B225_final.bam B233_final.bam B235_final.bam B236_final.bam \
B237_final.bam B242_final.bam B246_final.bam B254_final.bam B255_final.bam >  blochmannia_coverage.txt


# break up the depth files into single column files for each individual (locations dropped)

while read -r name1 number1; do
        number2=$((number1 + 2));
  cut blochmannia_coverage.txt -f $number2 > ${name1}_depth.txt;
done < modoc_popmap.txt
