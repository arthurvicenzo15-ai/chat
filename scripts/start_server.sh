#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FX_DIR="$ROOT_DIR/fxserver"

if [[ ! -x "$FX_DIR/run.sh" ]]; then
  echo "[ERRO] fxserver não encontrado. Rode primeiro: bash scripts/setup_server.sh" >&2
  exit 1
fi

cd "$ROOT_DIR"
exec "$FX_DIR/run.sh" +exec server.cfg
