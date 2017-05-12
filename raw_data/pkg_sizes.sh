#!/bin/bash

image=${1:?must provide a path to a 'coreos_production_image.bin' file}

# Must be run in the container-linux sdk chroot
. "$(dirname "$0")/common.sh" || exit 1
restart_in_chroot_if_needed "$@"

# In case this is out of date
./build_packages

mkdir -p size_mnt

./build_library/disk_util mount "${image}" ./size_mnt

equery-amd64-usr l "*" > all_pkgs

# Lazyness, this is once-off anyways
read -p "Please remove wrong 'Searching' lines from 'all_pkgs'"

sudo ROOT=/build/amd64-usr python ./util/sizes.py | sort -n > pkg_sizes

