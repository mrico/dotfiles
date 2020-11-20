
# SSH tunnel for a remote mongo instance
function mongo_tunnel() {
  local remote=$1
  local port=27017
  ssh -nNT -L $port:localhost:$port $remote
}
