#!/bin/bash

editor=''
post_path=''
jekyll_containter_name=''

open_file() {
    "$editor" "$1"
}

if docker ps --filter "name=$jekyll_containter_name" --format '{{.Names}}' | grep -q "$jekyll_containter_name"; then
  case "$1" in
  -e)
    docker exec -d $jekyll_containter_name bundle exec jekyll post "$2"
    echo -n "opening file in $post_path ..."
    sleep 5

    sanitized_filename=$(echo "$2" | tr ' ' '-')

    file_path=$(find "$post_path" -type f -iname "*$sanitized_filename*")
    if [ -n "$file_path" ]; then
      open_file "$file_path"
    else
      echo "Error: File $sanitized_filename not found in '$post_path'."
      exit 1
    fi
    ;;

  *)
    docker exec -d $jekyll_containter_name bundle exec jekyll post "$1"
    ;;
  esac
else
  echo "Error: Docker container '$jekyll_containter_name' is not running."
  exit 1
fi
