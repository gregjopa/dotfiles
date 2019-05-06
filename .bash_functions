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
