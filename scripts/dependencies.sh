
  echo "installing skaffold"

  curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
  chmod +x skaffold
  sudo mv skaffold /usr/local/bin

  echo "installing container-structure-test"

  curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64
  chmod +x container-structure-test-linux-amd64
  sudo mv container-structure-test-linux-amd64 /usr/local/bin/container-structure-test
