#!/bin/bash

set -euo pipefail

# Install dependencies
npm install --prefix /hugo/src/themes/hugo-winston-theme

exec "$@"
