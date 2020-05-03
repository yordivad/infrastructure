#!/bin/bash

# Install Ansible and use `ansible-pull` to run the playbook for this instance.

# Some sane options.
set -e # Exit on first error.
set -x # Print expanded commands to stdout.

function setup() {
  declare -r url=$1 playbook=$2
  sudo apt update
  sudo apt -y install apache2
  sudo apt -y install python3-pip
  export LC_ALL=C
  pip3 install ansible
  sudo apt -y autoremove
}

setup "" ""
