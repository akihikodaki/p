# SPDX-License-Identifier: 0BSD

export DESTDIR = $(abspath var)

%: fuse-overlayfs/% podman/%
	@

install: fuse-overlayfs/install podman/install var/usr/local/bin/conmon var/usr/local/libexec/podman/netavark

fuse-overlayfs/%: fuse-overlayfs/Makefile phony
	$(MAKE) -C fuse-overlayfs $*

fuse-overlayfs/Makefile: fuse-overlayfs/configure
	cd fuse-overlayfs && ./configure

fuse-overlayfs/configure: fuse-overlayfs/autogen.sh
	cd fuse-overlayfs && ./autogen.sh

fuse-overlayfs/autogen.sh:
	@

podman/%: var/go/bin/go phony
	PATH="$$PATH:$$PWD/var/go/bin" $(MAKE) -C podman $*

var/go: var/go1.22.3.linux-amd64.tar.gz
	tar xC var -f $<

var/go1.22.3.linux-amd64.tar.gz: | var/
	wget -O $@ https://go.dev/dl/go1.22.3.linux-amd64.tar.gz

var/usr/local/bin/conmon: | var/usr/local/bin/
	wget -O $@ https://github.com/containers/conmon/releases/download/v2.1.12/conmon.amd64
	chmod a+x $@

var/usr/local/libexec/podman/netavark: var/netavark.gz | var/usr/local/libexec/podman/
	zcat $< > $@
	chmod a+x $@

var/netavark.gz: | var/
	wget -O $@ https://github.com/containers/netavark/releases/download/v1.10.3/netavark.gz

%/:
	mkdir -p $@

phony:

.PHONY: phony
