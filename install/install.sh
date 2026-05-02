#!/usr/bin/env bash
set -euo pipefail

REPO="mahros-dev/mahros-deploy"
BINARY="mahrosctl"
BRANCH="main"
VERSION="${MAHROS_VERSION:-latest}"
INSTALL_DIR="/usr/local/bin"

ARCH=$(uname -m)
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

echo "[i] Installing Mahros CLI..."

if [[ "$VERSION" == "latest" ]]; then
  VERSION=$(curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/VERSION")
fi

URL="https://raw.githubusercontent.com/$REPO/$BRANCH/cli/main.sh"

echo "[i] Downloading version: $VERSION"

TMP_FILE=$(mktemp)
curl -fsSL "$URL" -o "$TMP_FILE"

# OPTIONAL: signature verification hook (recommended in real setup)
# gpg --verify "$TMP_FILE.sig" "$TMP_FILE"

chmod +x "$TMP_FILE"

sudo mv "$TMP_FILE" "$INSTALL_DIR/$BINARY"

echo "[✓] Installed mahrosctl -> $INSTALL_DIR/$BINARY"
echo "[✓] Version: $VERSION"