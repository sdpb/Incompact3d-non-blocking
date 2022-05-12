#!/bin/bash
set -e

examples_dir=`realpath examples`
scDPU=`realpath sbatchDPU.sh`
scNODPU=`realpath sbatchNODPU.sh`

for PPN in 32 16 8 4
do
    dir=/global/scratch/users/isc_scc03/ISC_DPU_NODES_09a16_PPN${PPN}_$(date "+%Y-%m-%d_%H-%M-%S")
    cp -r $examples_dir/ISC-base $dir
    cd $dir
    sbatch -p thor -N 16 --nodelist=thor[009-016],thor-bf[09-16] -J portedDPU_ISC_input_PPN${PPN} $scDPU ${PPN}

    dir=/global/scratch/users/isc_scc03/ISC_NODPU_PPN${PPN}_$(date "+%Y-%m-%d_%H-%M-%S")
    cp -r $examples_dir/ISC-base $dir
    cd $dir
    sbatch -p thor -N 8 --constraint="thor*8" -J portedNODPU_ISC_input_PPN${PPN} $scNODPU ${PPN}
    ../../sbatchDPU.sh ${PPN}
    cd ../..
done
