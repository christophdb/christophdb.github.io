#!/bin/bash

set -euo pipefail

#HUGO_BACKEND_URL="https://forms.seatable.com"
#SEATABLE_INTERNAL_API_URL="https://get.seatable.com"

docker compose run --rm \
    -e HUGO_ENVIRONMENT=production \
    hugo bash -c "npm run --prefix /hugo/src/themes/hugo-winston-theme build && hugo --enableGitInfo --source /hugo/src --printPathWarnings --panicOnWarning && npm run --prefix /hugo/src/themes/hugo-winston-theme pagefind:watch"
