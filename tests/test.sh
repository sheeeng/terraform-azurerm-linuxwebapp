#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

curl \
    --fail \
    --location \
    --remote-name \
    --remote-name-all \
    --remote-time \
    --request GET \
    --show-error \
    --silent \
    {'https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_linux_amd64.tar.gz','https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_SHA512SUMS','https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_SHA512SUMS.sig'}
