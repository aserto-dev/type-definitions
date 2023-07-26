#!/bin/bash
set -e

# bump the samve versio number as the pb repo
PB_VERSION=$(echo ${PROTO_REF} | sed 's/^refs\/tags\/v//')
VERSION=$(npm version ${PB_VERSION} --no-git-tag-version)
echo $VERSION
