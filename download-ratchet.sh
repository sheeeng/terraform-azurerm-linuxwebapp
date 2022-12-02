#!/usr/bin/env bash

SCRIPT_DIRECTORY=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s inherit_errexit # If set, command substitution inherits the value of the errexit option, instead of unsetting it in the subshell environment. This option is enabled when POSIX mode is enabled.

# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -o errexit  #Same as -e.
set -o errtrace # Same as -E.
set -o nounset  # Same as -u.
set -o xtrace   # Same as -x.
set -o pipefail # If set, the return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully. This option is disabled by default.
# set -eEuxo pipefail

mkdir --parents --verbose ${SCRIPT_DIRECTORY}/ratchet_files \
    && cd $_

declare -a urlArray=(
    'https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_linux_amd64.tar.gz'
    'https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_SHA512SUMS'
    'https://github.com/sethvargo/ratchet/releases/download/v0.3.1/ratchet_0.3.1_SHA512SUMS.sig'
    'https://github.com/sethvargo.gpg'
)

for url in ${urlArray[@]}; do
    curl \
        --fail \
        --location \
        --remote-name \
        --remote-name-all \
        --remote-time \
        --request GET \
        --show-error \
        --silent \
        "${url}"
done

grep ratchet_0.3.1_linux_amd64.tar.gz ratchet_0.3.1_SHA512SUMS | sha512sum --check -
echo "Check" ${PIPESTATUS[@]}

# gpg --batch --delete-key --yes 0xDA181DFE1B26293F42BBEC139C01CC8AB5D3F179
gpg --keyid-format long --keyserver hkp://keyserver.ubuntu.com --recv-keys 0xDA181DFE1B26293F42BBEC139C01CC8AB5D3F179
echo "Retrieve" ${PIPESTATUS[@]}

gpg --keyid-format long --list-keys --with-fingerprint 0xDA181DFE1B26293F42BBEC139C01CC8AB5D3F179
echo "Fingerprint" ${PIPESTATUS[@]}

# https://stackoverflow.com/questions/23228209/piping-shasum-to-grep-but-grep-returning-all-lines-of-piped-input-even-ones-th/23228588#23228588
gpg --keyid-format long --verify ratchet_0.3.1_SHA512SUMS.sig ratchet_0.3.1_SHA512SUMS 2>&1 | grep 'Good signature'
echo "Verify" ${PIPESTATUS[@]}

tar -xzvf ratchet_0.3.1_linux_amd64.tar.gz ratchet
echo "Extract" ${PIPESTATUS[@]}

cd ${SCRIPT_DIRECTORY}
