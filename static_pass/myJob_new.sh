#!/bin/sh
salloc \
--job-name=example_job \
--mail-user=brycehm@umich.edu \
--mail-type=BEGIN,END,FAIL \
--account=engin \
--cpus-per-task=1 \
--nodes=1 \
--gres=gpu:1 \
--time=20:00:00 \
--partition=gpu


# --output=/home/%u/%x-%j.log
#--account=test\
#--mem-per-cpu=500m
#--ntasks-per-node=1 \
#--time=01:00:00 \

