#!/bin/bash

source ./scripts/cluster_clean.sh

cluster_clean

if [ -d "./dist" ]
then
  rm -r ./dist
fi



