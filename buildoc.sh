#!/bin/bash

set -euxo pipefail

DOCKER_IMAGE="${DOCKER_IMAGE:-"lacti/mkdocs-gfm-toc"}"
INPUT_DIR="${1:-""}"
OUTPUT_DIR="${2:-""}"
MKDOCS_PATH="${3:-"${INPUT_DIR}/mkdocs.yml"}"

if [ -z "${INPUT_DIR}" ] || [ -z "${OUTPUT_DIR}" ]; then
  echo "usage: $0 input-dir output-dir [mkdocs.yml]"
  exit 0
fi

if [ -d "${OUTPUT_DIR}" ]; then
  echo "Directory is not empty: ${OUTPUT_DIR}"
  exit 1
fi

if [ ! -f "${MKDOCS_PATH}" ]; then
  echo "File not found: ${MKDOCS_PATH}"
  exit 1
fi

# Prepare temporary directory.
TEMP_DIR="$(mktemp -d)"
mkdir -p "${TEMP_DIR}/docs"
trap 'rm -rf -- "$TEMP_DIR"' EXIT

# Prepare "mkdocs.yml" to build site.
cp "${MKDOCS_PATH}" "${TEMP_DIR}"

cd "${INPUT_DIR}"
  # Copy document related files into temp directory.
  find . \( -name "*.md" -o -name "*.png" -o -name "*.png" \) -exec cp --parents {} "${TEMP_DIR}/docs" \;

  # Build a site using mkdocs.
  docker run -u "${UID}" -v ${TEMP_DIR}:/opt "${DOCKER_IMAGE}" build
cd -

# Copy results.
cp -r "${TEMP_DIR}/site" "${OUTPUT_DIR}"

