#!/bin/bash
echo hello world

ls -l | awk 'BEGIN {sum=0} {sum=sum+$5} END {print sum}'

ls -l | awk '{for (i=1;i<3;i++) {getline};print NR,$0}'