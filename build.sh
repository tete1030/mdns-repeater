#!/bin/bash

build_tag=tete1030/mdns-repeater

echo TAG: "${build_tag:?}"

set -e

docker buildx build --push --progress plain --platform linux/amd64 --tag ${build_tag} .
