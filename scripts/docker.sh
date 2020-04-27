

  echo "deploying docker"
  export VERSION
  VERSION="$(git describe --tags --abbrev=0)"
  skaffold build -p prod
