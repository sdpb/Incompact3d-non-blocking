#!/bin/bash

#SBATCH --time=04:00:00
#SBATCH --exclusive
#SBATCH --output=out.%j
#SBATCH --error=err.%j
set -e

PPN=${1:-32}

# Loading right environment
module load gcc/8.3.1
module load mvapich2-dpu/2022.02

srun -l hostname -s | awk '{print $2 ":"'"$PPN}" | grep -v bf | sort > hostfile

NPROC=$((PPN * 8))
EXE=/global/home/users/isc_scc03/xcompact-adios2-mvapich/Incompact3d-non-blocking/xcompact3d
# DPU offload
cp input.i3d.$PPN input.i3d
mpirun_rsh -np $NPROC  -hostfile hostfile MV2_USE_DPU=0 $EXE
set +e
rm -rf data/ checkpoint restart-forces statistics/ probes/ out/ restart*
