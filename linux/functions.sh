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