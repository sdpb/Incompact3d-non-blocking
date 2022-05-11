#!/bin/bash

#SBATCH --time=04:00:00
#SBATCH --exclusive
#SBATCH --output=out.%j
#SBATCH --error=err.%j
set -e

dir=ISC-$(date "+%Y-%m-%d_%H-%M-%S")
cd examples
cp -r ISC-base $dir

PPN=${1:-32}

# Loading right environment
module load gcc/8.3.1
module load mvapich2-dpu/2022.02

srun -l hostname -s | awk '{print $2 ":"'"$PPN}" | grep -v bf | sort > hostfile
srun -l hostname -s | awk '{print $2}' | grep bf | sort |uniq > dpufile

NPROC=$((PPN * 8))

# DPU offload
mpirun_rsh -np $NPROC  -hostfile hostfile -dpufile dpufile $EXE
