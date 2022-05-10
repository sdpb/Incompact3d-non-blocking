#!/bin/bash
PPN="${1:-32}"

rm hostfile dpufile

srun -l hostname -s | awk '{print $2 ":"'"$PPN}" | grep -v bf | sort > hostfile
srun -l hostname -s | awk '{print $2}' | grep bf | sort |uniq > dpufile
