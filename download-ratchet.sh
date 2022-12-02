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
    {'https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_linux_amd64.tar.gz','https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_SHA512SUMS','https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_SHA512SUMS.sig','https://github.com/sethvargo.gpg'}

sha512sum --check ratchet_0.3.1_SHA512SUMS 2>&1 | grep OK

gpg --keyid-format long --keyserver hkp://keyserver.ubuntu.com --recv-keys 0xDA181DFE1B26293F42BBEC139C01CC8AB5D3F179
gpg --keyid-format long --list-keys --with-fingerprint 0xDA181DFE1B26293F42BBEC139C01CC8AB5D3F179

gpg --keyid-format long --verify ratchet_0.3.1_SHA512SUMS.sig ratchet_0.3.1_SHA512SUMS 2>&1 | grep 'Good signature'

tar -xzvf ratchet_0.3.1_linux_amd64.tar.gz ratchet
