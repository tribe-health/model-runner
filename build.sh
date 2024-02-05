#!/bin/bash

docker buildx create --use

docker buildx build --push \
--platform linux/amd64,linux/arm64 \
--tag tribehealth/model-runner:v0.0.1 .