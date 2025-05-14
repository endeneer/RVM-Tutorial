#!/bin/bash
set -e

DIR_PREFIX="$(realpath "$(dirname $(readlink -f "$0"))")"
export ARCH=x86_64
export PATH=/usr/local/bin:$DIR_PREFIX/x86_64-linux-musl-cross/bin:$PATH

echo "Build Guest OS"
# git submodule init && git submodule update
cd guest/nimbos/kernel
make user
make GUEST=on
cd -

echo "Build Guest BIOS"
cd guest/bios
make
cd -

echo "Build and Run Hypervisor"
cd hypervisor
# make run LOG=trace MODE=debug
make run MODE=release
