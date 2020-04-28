#!/bin/bash

set -e


ENVIRONMENT="dev"
DEBUG=false

deploy() {

  case $ENVIRONMENT in
  dev) deploy_dev ;;
  sta) deploy_stag ;;
  pro) deploy_pro ;;
  esac

}


deploy_dev()
{
  echo "deploying on development"
   export VERSION
   VERSION="$(git describe --tags --dirty)"
    if [ $DEBUG == "true" ]
    then
      skaffold debug --port-forward -p dev
    else
      skaffold run -p dev
    fi
}

deploy_pro()
{
  echo "deploying on production"
  export VERSION
  VERSION="$(git describe --tags --abbrev=0)"
  skaffold run -p prod -n roygi
}

deploy_stag() {
  echo "deploying on staging"
  export VERSION
  VERSION="$(git describe --tags --abbrev=0)"
  skaffold run -p stag -n roygi
}

 while [ -n "$1" ]; do
    case $1 in
      -e|--env)
        ENVIRONMENT=$2
      ;;
      -d|--debug)
        DEBUG=$2
      ;;
    esac
    shift
  done

deploy

