#!/bin/bash
#
# builds the local christophdb.github.io (hugo) page

if [[ "$1" == "-stop" ]]; then
  sudo docker kill christophdb.github.io
  exit 0
fi

sudo rm -r src/public/*
sudo docker build -t christophdb.github.io .
sudo docker run --rm --name christophdb.github.io -p 1313:1313 -v ${PWD}:/hugo hugo server -D --bind=0.0.0.0
./pagefind --site "src/public" --verbose

echo "Local christophdb.github.io preview available at http://127.0.0.1:1313"
echo "Use 'STRG+C' to stop the preview"