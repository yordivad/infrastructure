#!/bin/bash

 while [ -n "$1" ]; do
    case $1 in
      -l|--local)
        kubectl config use-context minikube
      ;;
      -p|--prod)
        kubectl config use-context --namespace=roygi prod_cluster
      ;;
    esac
    shift
  done

