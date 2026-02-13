#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FX_DIR="$ROOT_DIR/fxserver"
TMP_DIR="$ROOT_DIR/.tmp"

if [[ ! -f "$ROOT_DIR/.env" ]]; then
  echo "[ERRO] Arquivo .env não encontrado. Copie .env.example para .env e configure." >&2
  exit 1
fi

# shellcheck disable=SC1091
source "$ROOT_DIR/.env"

mkdir -p "$FX_DIR" "$TMP_DIR"

echo "[INFO] Baixando página de artifacts..."
ARTIFACT_PAGE="$(curl -fsSL "$FXSERVER_ARTIFACT_URL")"
ARTIFACT_PATH="$(echo "$ARTIFACT_PAGE" | sed -n 's/.*href="\([^\"]*fx.tar.xz\)".*/\1/p' | head -n 1)"

if [[ -z "$ARTIFACT_PATH" ]]; then
  echo "[ERRO] Não foi possível localizar fx.tar.xz em $FXSERVER_ARTIFACT_URL" >&2
  echo "[DICA] Entre na URL manualmente e copie um build específico."
  exit 1
fi

if [[ "$ARTIFACT_PATH" =~ ^https?:// ]]; then
  ARTIFACT_URL="$ARTIFACT_PATH"
else
  ARTIFACT_URL="${FXSERVER_ARTIFACT_URL%/}/${ARTIFACT_PATH#/}"
fi

echo "[INFO] Baixando artifact: $ARTIFACT_URL"
curl -fL "$ARTIFACT_URL" -o "$TMP_DIR/fx.tar.xz"

echo "[INFO] Extraindo artifact para $FX_DIR"
tar -xf "$TMP_DIR/fx.tar.xz" -C "$FX_DIR"

echo "[INFO] Setup concluído."
echo "[PRÓXIMO] Configure server.cfg com sua key e DB, depois rode: bash scripts/start_server.sh"
