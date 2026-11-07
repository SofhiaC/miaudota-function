#!/usr/bin/env bash
# Constrói e publica a imagem da Function no Docker Hub (login antes: docker login).
set -euo pipefail
cd "$(dirname "$0")"
docker build --platform linux/amd64 -t sofhiachromiec/pjbl-function:v1 .
docker push sofhiachromiec/pjbl-function:v1
echo "Imagem publicada."
