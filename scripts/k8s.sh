export VAGRANT_DOTFILE_PATH=./vagrant/k8s/master/Vagrantfiles/.vagrant
export VAGRANT_VAGRANTFILE=./vagrant/k8s/master/Vagrantfiles
  touch ./vagrant/k8s/config/master_join.sh
  chmod +0664 ./vagrant/k8s/config/master_join.sh
  vagrant up

function set_master() {

  echo "done"
}

function ssh_master() {
  @echo "setting ssh with master"
  export VAGRANT_DOTFILE_PATH=./vagrant/k8s/node/Vagrantfiles/.vagrant
  export VAGRANT_VAGRANTFILE=./vagrant/k8s/node/Vagrantfiles
  vagrant ssh c172a25
}


function set_nodes() {
  export VAGRANT_VAGRANTFILE=./vagrant/k8s/master/Vagrantfile
  vagrant up
}

function set_both() {
  set_master
  set_nodes
}

while [ -n "$1" ]; do
  case $1 in
  -m | --master)
    if [ "$2" == "" ]; then
      set_master
    else
      case $2 in
        --ssh)
          ssh_master
        ;;
      esac
    fi

    ;;
  -n | --node)
    set_nodes
    ;;
  -b | --both)
    set_both
    ;;
  esac
  shift
done
