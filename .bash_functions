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

# Show the response headers for a given url
function http_headers {
  curl -I -L "$@"
}

# Show the timing details for a given url
function http_debug {
  curl "$@" -o /dev/null -s -w "dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer}\n"
}

# Check the compression for a given url
function http_compression {
  local accept_encoding="accept-encoding: gzip, deflate, br"
  curl -w 'Size (uncompressed) = %{size_download}\n' -o /dev/null -s "$1"
  curl -H "$accept_encoding" -w 'Size (compressed) =   %{size_download}\n' -o /dev/null -s "$1"
  curl -I -H "$accept_encoding" -s "$1" | grep -i "content-encoding"
}
