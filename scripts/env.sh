export machine

function get_env() {
  server="$(uname -s)"
  case "${server}" in
      Linux*)     machine="Linux";;
      Darwin*)    machine="Mac";;
      CYGWIN*)    machine="Cygwin";;
      MINGW*)     machine="MinGw";;
      *)          machine="UNKNOWN:${server}"
  esac
}