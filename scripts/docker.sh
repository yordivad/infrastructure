

  echo "deploying docker"

  export VERSION
  VERSION="$(git describe --tags --abbrev=0 --always $(git rev-list --tags --max-count=1))"
  skaffold build -p prod
