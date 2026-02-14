# SPDX-License-Identifier: 0BSD

export DESTDIR = $(abspath var)

.PHONY: install podman/install

install: podman/install var/usr/local/bin/conmon var/usr/local/bin/fuse-overlayfs var/usr/local/libexec/podman/netavark

podman/install: var/go/bin/go
	PATH="$$PATH:$$PWD/var/go/bin" $(MAKE) -C podman
	PATH="$$PATH:$$PWD/var/go/bin" $(MAKE) -C podman install

var/go/bin/go: var/go1.26.0.linux-amd64.tar.gz
	tar xC var -f $<

var/go1.26.0.linux-amd64.tar.gz: | var/
	wget -O $@ https://go.dev/dl/$(notdir $@)

var/usr/local/bin/conmon: | var/usr/local/bin/
	wget -O $@ https://github.com/containers/conmon/releases/download/v2.1.13/conmon.amd64
	chmod +x $@

var/usr/local/bin/fuse-overlayfs: | var/usr/local/bin/
	wget -O $@ https://github.com/containers/fuse-overlayfs/releases/download/v1.16/fuse-overlayfs-x86_64
	chmod +x $@

var/usr/local/libexec/podman/netavark: var/netavark.gz | var/usr/local/libexec/podman/
	zcat $< > $@
	chmod +x $@

var/netavark.gz: | var/
	wget -O $@ https://github.com/containers/netavark/releases/download/v1.17.2/netavark.gz

%/:
	mkdir -p $@
