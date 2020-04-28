#!/bin/bash

if [ ! -d "./dist" ]
then
  mkdir dist
fi

helm install sample --dry-run --debug helm/sample/ > ./dist/sample.yml