#!/bin/bash

set -e

if [ ! -d "./dist" ]
then
  mkdir dist
fi


go build -o  ./dist/main ./cmd/sample/main.go
