#!/usr/bin/env bash
#
# Bootstrapping script for my dotfiles install.
# The purpose of this script is to hand off to Haskell.
# Importantly, this script shouldn't touch the $HOME directory.

# Constants.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly GHC_VERSION='8.6.3'
readonly TOOL_DIR="${SCRIPT_DIR}/.tools"
readonly GHCUP_SCRIPT="${TOOL_DIR}/ghcup"
readonly GHCUP_INSTALL_BASE_PREFIX="${TOOL_DIR}"
readonly CABAL_DIR="${TOOL_DIR}/.cabal"
readonly CABAL_CONFIG="${TOOL_DIR}/cabal-config"

export CABAL_CONFIG
export GHCUP_INSTALL_BASE_PREFIX

# Create a directory for tooling.
mkdir -p "${TOOL_DIR}"

# Build the xz tools.
if [ ! -f "${TOOL_DIR}/bin/xz" ]; then
    echo "${TOOL_DIR}/bin/xz not found: downloading and building..."
    curl -L https://tukaani.org/xz/xz-5.2.4.tar.bz2 > "${TOOL_DIR}/xz.tar.bz2"
    pushd "${TOOL_DIR}" > /dev/null
        mkdir xz
        tar -C xz --strip-components=1 -xf xz.tar.bz2
        rm xz.tar.bz2
        cd xz
        ./configure --prefix="${TOOL_DIR}"
        make -j 5
        make install
    popd
    rm -rf xz
fi

# Fetch the ghcup script.
if [ ! -f "${GHCUP_SCRIPT}" ]; then
    echo "${GHCUP_SCRIPT} not found: downloading..."
    curl https://raw.githubusercontent.com/haskell/ghcup/master/ghcup > "${GHCUP_SCRIPT}"
    chmod +x "${GHCUP_SCRIPT}"
fi

# Install GHC.
export PATH="${TOOL_DIR}/bin:${TOOL_DIR}/.ghcup/bin:${PATH}"
if [ ! -f "${TOOL_DIR}/.ghcup/bin/ghc" ]; then
    echo "ghc was not installed: installing it..."
    "${GHCUP_SCRIPT}" install "${GHC_VERSION}"
    "${GHCUP_SCRIPT}" set "${GHC_VERSION}"
    "${GHCUP_SCRIPT}" install-cabal
fi

# Write the Cabal config file.
/bin/cat <<EOF >${CABAL_CONFIG}
repository hackage.haskell.org
  url: http://hackage.haskell.org/
remote-repo-cache: ${CABAL_DIR}/packages
world-file: ${CABAL_DIR}/world
extra-prog-path: ${CABAL_DIR}/bin
symlink-bindir: ${CABAL_DIR}/bin
build-summary: ${CABAL_DIR}/logs/build.log
store-dir: ${CABAL_DIR}/store
logs-dir: ${CABAL_DIR}/logs
jobs: \$ncpus
EOF

# Update cabal package index.
if [ ! -d "${CABAL_DIR}/packages/hackage.haskell.org" ]; then
    cabal v2-update
fi

# Hand-off to Haskell.
"${SCRIPT_DIR}"/update.hs
