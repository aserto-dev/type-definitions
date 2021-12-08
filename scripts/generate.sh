#!/bin/bash
source downloaded/commit_hash.sh

for REQUIRED_ENV in "USERNAME" "READ_WRITE_TOKEN" "COMMIT_HASH"
do
    if [[ -z "${!REQUIRED_ENV}" ]]; then
    echo "$REQUIRED_ENV must be set"
    FAIL=1
    fi
done

if [[ -n "${FAIL}" ]]; then
    exit $FAIL
fi

if [[ $1 == "--fetch-specs" ]]; then
  echo "Removing existing specs in downloaded/specs/\n"
  rm ./downloaded/specs/*
fi

for SERVICE in "tenant" "authorizer" "registry" "decision_logs"
do
    OUTPUT_PATH=./downloaded/specs/${SERVICE}.openapi.json

    if [[ $1 == "--fetch-specs" ]]; then
        TARGET=https://api.github.com/repos/aserto-dev/openapi-grpc/contents/publish/${SERVICE}/openapi.json?ref=${COMMIT_HASH}
        echo "CURLing $TARGET to $OUTPUT_PATH"
        curl \
            --create-dirs -o "${OUTPUT_PATH}" -u "${USERNAME}:${READ_WRITE_TOKEN}" \
            -H "Accept: application/vnd.github.v3.raw" \
            "${TARGET}"
    fi
    
    yarn openapi-typescript ${OUTPUT_PATH} --output ./generated/${SERVICE}.ts
done
