#!/bin/bash
#
# builds the mkdocs image and runs it to provide a local preview of the docs

if [[ "$1" == "-stop" ]]; then
  sudo docker kill hugo
  exit 0
fi

sudo rm -r src/public/*
sudo docker build -t hugo .
sudo docker run --rm --name hugo -p 1313:1313 -v ${PWD}:/hugo hugo server -D --bind=0.0.0.0
./pagefind --site "src/public" --verbose

echo "Local hugo preview available at http://127.0.0.1:1313"
echo "Use 'STRG+C' to stop the preview"