#!/bin/bash

open_file() {
  if [ -z "$EDITOR" ]; then
    if command -v vim >/dev/null; then
      /usr/bin/vim "$1"
    else
      echo "No editor set in the EDITOR environment variable and Vim not found."
      exit 1
    fi
  else
    if ! command -v "$EDITOR" >/dev/null; then
      echo "Editor '$EDITOR' not found or not executable."
      exit 1
    fi

    "$EDITOR" "$2"
  fi
}

if docker ps --filter "name=jekyll" --format '{{.Names}}' | grep -q "jekyll"; then
  case "$1" in
  -e)
    docker exec -d jekyll bundle exec jekyll post "$2"
    echo -n "opening file..."
    sleep 5

    sanitized_filename=$(echo "$2" | tr ' ' '-')

    file_path=$(find "$HOME/docker/jekyll/jekyll-site/volume/_posts" -type f -iname "*$sanitized_filename*")
    if [ -n "$file_path" ]; then
      open_file "$file_path"
    else
      echo "Error: File $sanitized_filename not found in '~/docker/jekyll/jekyll-site/volume/_posts'."
      exit 1
    fi
    ;;

  *)
    docker exec -d jekyll bundle exec jekyll post "$1"
    ;;
  esac
else
  echo "Error: Docker container 'jekyll' is not running."
  exit 1
fi
