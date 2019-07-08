#!/usr/bin/env bash

# Create a new directory and enter it
function mkd {
  mkdir -p "$@" && cd "$_" || return 1;
}

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
  echo "python -m SimpleHTTPServer $port"
  sleep 1 && open "http://localhost:${port}/" &
  python -m SimpleHTTPServer "$port"
}

# Show the response headers for a given url
function http_headers {
  if [ -n "$1" ]; then
    curl "$1" -I -L
  else
    echo "Usage: http_headers <url>"
  fi
}

# Show the timing details for a given url
function http_debug {
  if [ -n "$1" ]; then
    local format="dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer}\n"
    curl "$1" -o /dev/null -s -w "$format"
  else
    echo "Usage: http_debug <url>"
  fi
}

# Check the compression for a given url
function http_compression {
  if [ -n "$1" ]; then
    local accept_encoding="accept-encoding: gzip, deflate, br"
    curl "$1" -o /dev/null -s -w "Size (uncompressed) = %{size_download}\n"
    curl "$1" -o /dev/null -s -H "$accept_encoding" -w "Size (compressed) =   %{size_download}\n"
    curl "$1" -s -I -H "$accept_encoding" | grep -i "content-encoding"
  else
    echo "Usage: http_compression <url>"
  fi
}

# Pull down and log changes, optionally specifying the branch
function pull {
  local branch="${1:-$(git rev-parse --abbrev-ref HEAD)}"

  if [ -d ./.git ]; then
    echo "git pull origin $branch"
    git pull origin "$branch"

    if [ "$(git rev-list --count ORIG_HEAD..HEAD)" -gt 0 ]; then
      echo "git log ORIG_HEAD..HEAD"
      git log ORIG_HEAD..HEAD --oneline
    fi
  else
    echo "Not a git directory"
  fi
}

# Push up changes, optionally specifying the branch or `f` for force pushing
function push {
  local branch="${1:-$(git rev-parse --abbrev-ref HEAD)}"

  if [[ -d ./.git ]]; then
    if [[ "$1" == "f" ]]; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        echo "git push origin ${branch}:${branch} --force-with-lease"
        git push origin "${branch}:${branch}" --force-with-lease
    else
      echo "git push origin ${branch}:${branch}"
      git push origin "${branch}:${branch}"
    fi
  else
    echo "Not a git directory"
  fi
}
