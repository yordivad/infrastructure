#!/bin/bash

source ./scripts/registry.sh
source ./scripts/env.sh

set -e

set_minikube() {
  minikube start --driver=docker
  kubectl config use-context minikube
  add_registry
}

set_develop() {
  get_env
  export FILE
  FILE="./config/dev.config.yaml"
  cp $FILE ./dist/dev.config


  if [ $machine == "Mac" ];
  then
    sed -i '' -e "s/{{KEY}}/${DEV_KEY}/g" dist/dev.config
    sed -i '' -e "s/{{TKN}}/${DEV_TKN}/g" dist/dev.config
    sed -i '' -e "s/{{USR}}/${DEV_USR}/g" dist/dev.config
  else
    sed -i  -e "s/{{KEY}}/${DEV_KEY}/g" dist/dev.config
    sed -i  -e "s/{{TKN}}/${DEV_TKN}/g" dist/dev.config
    sed -i  -e "s/{{USR}}/${DEV_USR}/g" dist/dev.config
  fi

  kubectl config use-context dev_cluster -n roygi
  add_registry || true

}


set_production() {
 get_env
  export FILE
  FILE="./config/prod.config.yaml"
  cp $FILE ./dist/prod.config

  if [ $machine == "Mac" ];
  then
    sed -i '' -e "s/{{KEY}}/${PROD_KEY}/g" dist/prod.config
    sed -i '' -e "s/{{TKN}}/${PROD_TKN}/g" dist/prod.config
    sed -i '' -e "s/{{USR}}/${PROD_USR}/g" dist/prod.config
  else
    sed -i  -e "s/{{KEY}}/${PROD_KEY}/g" dist/prod.config
    sed -i  -e "s/{{TKN}}/${PROD_TKN}/g" dist/prod.config
    sed -i  -e "s/{{USR}}/${PROD_USR}/g" dist/prod.config
  fi

  kubectl config use-context prod_cluster
  add_registry || true

}


if [ ! -d "./dist" ]
then
  mkdir dist
fi


 while [ -n "$1" ]; do
    case $1 in

      -l|--local)
         set_minikube
      ;;

      -d|--dev)
        set_develop
      ;;

      -p|--prod)
         set_production
      ;;
    esac
    shift
  done


