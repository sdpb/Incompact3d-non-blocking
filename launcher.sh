#!/bin/bash

for PPN in  32
do
    cd examples
    dir=ISC_PPN${PPN}_$(date "+%Y-%m-%d_%H-%M-%S")
    cp -r ISC-base $dir
    cd $dir

    sbatch -p thor -N 16 --constraint="[thor-bf*8&thor*8]" -J portedDPU_ISC_input_PPN${PPN} ../../sbatchDPU.sh ${PPN}
done
