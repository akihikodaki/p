# SPDX-License-Identifier: 0BSD

FROM ubuntu:jammy-20260109

RUN --mount=id=p,target=/var/cache/apt,type=cache \
    --mount=id=p,target=/var/lib/apt/lists,type=cache \
    rm /etc/apt/apt.conf.d/docker-clean && apt-get update && \
    apt-get install -y build-essential git libgpgme-dev libseccomp-dev python3 \
    pkg-config wget
