#!/usr/bin/env bash
set -euo pipefail

#############################################
# Mahros CLI - Shared Library
#############################################

MAHROS_IMAGE_DEFAULT="ghcr.io/mahros-dev/mahros-dev"

#############################################
# Logging
#############################################

log_info() {
  echo "[info] $*"
}

log_warn() {
  echo "[warn] $*" >&2
}

log_error() {
  echo "[error] $*" >&2
}

#############################################
# Config resolution
#############################################

get_version() {
  # Priority:
  # 1. MAHROS_VERSION env
  # 2. local VERSION file
  # 3. fallback "latest"

  if [[ -n "${MAHROS_VERSION:-}" ]]; then
    echo "$MAHROS_VERSION"
    return
  fi

  if [[ -f "./VERSION" ]]; then
    cat ./VERSION
    return
  fi

  echo "latest"
}

get_image() {
  local version
  version=$(get_version)

  echo "${MAHROS_IMAGE:-$MAHROS_IMAGE_DEFAULT}:${version}"
}

#############################################
# Docker execution wrapper
#############################################

run_container() {
  local cmd="$1"
  shift

  local image
  image=$(get_image)

  if ! command -v docker >/dev/null 2>&1; then
    log_error "Docker is not installed"
    exit 1
  fi

  log_info "Running: $image $cmd $*"

  docker run --rm -it \
    -e MAHROS_ENV="${MAHROS_ENV:-prod}" \
    "$image" "$cmd" "$@"
}

#############################################
# Safety helpers (future-ready)
#############################################

require_non_empty() {
  local value="$1"
  local name="$2"

  if [[ -z "$value" ]]; then
    log_error "Missing required value: $name"
    exit 1
  fi
}

#############################################
# Future extension hooks
#############################################

# Placeholder for future auth system
get_token() {
  # later: fetch from ~/.mahros/token or vault
  echo "${MAHROS_TOKEN:-}"
}