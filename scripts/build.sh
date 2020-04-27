#!/bin/bash

set -e

mkdir dist
go build -o  ./dist/main ./cmd/sample/main.go
