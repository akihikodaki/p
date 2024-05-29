# SPDX-License-Identifier: 0BSD

FROM ubuntu:jammy-20240427

RUN --mount=id=p,target=/var/cache/apt,type=cache \
    --mount=id=p,target=/var/lib/apt/lists,type=cache \
    rm /etc/apt/apt.conf.d/docker-clean && apt-get update && \
    apt-get install -y automake build-essential git libfuse3-dev libgpgme-dev \
    libseccomp-dev pkg-config python3 wget
