#!/usr/bin/env bash
# Reproducible build with the TeX Live version of the original submission (Overleaf, Sep 2022 = TeX Live 2022).
# Requires podman (or docker: export ENGINE=docker). Output: build/main.pdf
# openout_any=a: the old latexmk runs bibtex from /src, which must then write its .bbl/.blg to /out
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2022-historic
mkdir -p build
"$ENGINE" run --rm -e openout_any=a -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" -w /src "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -outdir=/out main.tex
