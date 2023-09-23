# executes a command inside a docker container with "web" or "www" in it's name
de() {
command="${@?missing command}"
containerId=$(docker ps | awk '$2 ~ "(web|www)"{print $1}')

if [ -n "$containerId" ] && [ -n "$command" ]; then
    docker exec -u root $containerId $command
else
    echo "no web container running or command not available"
fi
}

# same thing as de() but with -it flag
dei() {
command="${@?missing command}"
containerId=$(docker ps | awk '$2 ~ "(web|www)"{print $1}')

if [ -n "$containerId" ] && [ -n "$command" ]; then
    docker exec -it -u root $containerId $command
else
    echo "no web container running or command not available"
fi
}

# activates a python virtual env
# https://github.com/LunarVim/LunarVim/issues/1357#issuecomment-906758577
useenv() {
  local OLD_PATH=$PWD
  local VENV_DIR=${1:-'.venv'} #default venv name
  local FOUND

  while [ -z "$FOUND" ] ; do
    if ls ${VENV_DIR}/bin/activate 2>/dev/null >/dev/null ; then
      source ${VENV_DIR}/bin/activate
      FOUND='FOUND'
      break
    fi

    if [ "/home/$USER" == "$PWD" ] || [ '/' == "$PWD" ] ; then
      break
    fi

    cd ..
  done

  if [ -z "$FOUND" ] ;then
    echo "venv not found"
  else
    VERSION=`python3 --version 2>&1`
    printf 'Using %s\n' "$VERSION"
    echo found on $PWD
  fi

  cd $OLD_PATH
}
