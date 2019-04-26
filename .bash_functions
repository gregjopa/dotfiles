#!/usr/bin/env bash

# Change working directory to project root
function pr {
  local dir="$PWD"

  until [[ -z "$dir" ]]; do
    if [ -d ./.git ]; then
      break
    else
      cd ..
    fi
    dir="${dir%/*}"
  done
}

# Start an HTTP server from a directory, optionally specifying the port
function server {
  local port="${1:-8000}"
  sleep 1 && open "http://localhost:${port}/" &
  python -m SimpleHTTPServer "$port"
}

# Show the HTTP response headers for a given url
http_headers () {
  curl -I -L "$@"
}

# Show the HTTP response timing details for a given url
http_debug () {
  curl "$@" -o /dev/null -s -w "dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer}\n"
}
