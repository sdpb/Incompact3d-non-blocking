#!/bin/bash -l

for i in 4, 8, 16, 32
do
	sbatch -p thor -N 16 --constraint="[thor-bf*8&thor*8]" -J portedDPU_ISC_input sbatchDPU.sh $i
done
