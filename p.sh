#!/bin/sh
# SPDX-License-Identifier: 0BSD

set -e
podman build --network host -t p .
podman run --network host --rm --security-opt label=disable -v.:/p -w/p p make "$@"
