#!/usr/bin/env bash
set -euo pipefail

CMD="${1:-}"

IMAGE="ghcr.io/mahros-dev/mahros-dev:latest"

run_container() {
  docker run --rm -it \
    -e MAHROS_ENV=prod \
    "$IMAGE" "$@"
}

case "$CMD" in
  deploy)
    shift
    run_container deploy "$@"
    ;;

  init)
    run_container init
    ;;

  logs)
    run_container logs
    ;;

  version)
    run_container version
    ;;

  *)
    echo "Mahros CLI"
    echo ""
    echo "Usage:"
    echo "  mahrosctl deploy"
    echo "  mahrosctl init"
    echo "  mahrosctl logs"
    echo "  mahrosctl version"
    ;;
esac