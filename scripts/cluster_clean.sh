#!/bin/bash

function cluster_clean() {

  kubectl config use-context dev_cluster -n roygi
  kubectl delete secret docker.github
  helm delete sample

  kubectl config use-context prod_cluster -n roygi
  kubectl delete secret docker.github
  helm delete sample

}

