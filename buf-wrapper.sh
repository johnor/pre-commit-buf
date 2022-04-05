#!/bin/bash

set -euo pipefail

readonly VERSION=v1.3.1
readonly LINUX_X86_64_SHA=64d2999541eb1185447a8c49dc2226bf59ebbe511adc5e195927fa48773e7b9c

readonly OS=Linux
readonly ARCH=x86_64

readonly FILENAME=buf-$OS-$ARCH
readonly URL=https://github.com/bufbuild/buf/releases/download/$VERSION/$FILENAME
readonly BINARY_DIR=~/.cache/pre-commit/buf/$OS-$ARCH-$VERSION/
readonly BINARY=$BINARY_DIR/buf

if [[ -x "$BINARY" ]]; then
   exec "$BINARY" "$@"
fi

mkdir -p "$BINARY_DIR"
TMP_BINARY=$(mktemp)

if ! curl --fail --location --retry 5 --retry-connrefused --silent --output "$TMP_BINARY" "$URL"; then
   echo "error: failed to download buf" >&2
   exit 1
fi

if echo "$LINUX_X86_64_SHA  $TMP_BINARY" | shasum --check --status; then
   if [[ ! -x "$BINARY" ]]; then
      mv "$TMP_BINARY" "$BINARY"
      chmod +x "$BINARY"
   fi

   exec "$BINARY" "$@"
else
   echo "error: buf sha mismatch" >&2
   rm -f "$BINARY"
   exit 1
fi
