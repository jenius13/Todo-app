#!/usr/bin/env bash
set -euo pipefail

# Railpack fallback start script — change into the actual project folder
cd test

# Install dependencies (prefer lockfile for reproducible installs)
if [ -f package-lock.json ] || [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

# Build and start
npm run build
npm start
