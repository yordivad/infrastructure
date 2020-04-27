#!/bin/bash

 helm install sample --dry-run --debug helm/sample/ > ./dist/sample.yml
