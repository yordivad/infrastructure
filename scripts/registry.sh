

add_registry() {
  kubectl create secret  docker-registry docker.github  \
    --docker-server "https://docker.pkg.github.com" \
    --docker-username roygi \
    --docker-email admin@mlambda.net \
    --docker-password="$GIT_TOKEN"
}