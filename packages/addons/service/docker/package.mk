# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="docker"
PKG_VERSION="19.03.3"
PKG_REV="130"
PKG_ARCH="any"
PKG_LICENSE="ASL"
PKG_SITE="http://www.docker.com/"
PKG_DEPENDS_TARGET="containerd docker-ce libnetwork runc tini"
PKG_SECTION="service/system"
PKG_SHORTDESC="Docker is an open-source engine that automates the deployment of any application as a lightweight, portable, self-sufficient container that will run virtually anywhere."
PKG_LONGDESC="Docker containers can encapsulate any payload, and will run consistently on and between virtually any server. The same container that a developer builds and tests on a laptop will run at scale, in production*, on VMs, bare-metal servers, OpenStack clusters, public instances, or combinations of the above."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Docker"
PKG_ADDON_TYPE="xbmc.service"

makeinstall_target() {
 :
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    # containerd
    cp -P $(get_build_dir containerd)/bin/containerd ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/containerd
    cp -P $(get_build_dir containerd)/bin/containerd-shim ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/containerd-shim

    # docker-ce
    cp -P $(get_build_dir docker-ce)/bin/docker ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/docker
    cp -P $(get_build_dir docker-ce)/bin/dockerd ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/dockerd

    # libnetwork
    cp -P $(get_build_dir libnetwork)/bin/docker-proxy ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/docker-proxy

    # runc
    cp -P $(get_build_dir runc)/bin/runc ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/runc

    # tini
    cp -P $(get_build_dir tini)/.${TARGET_NAME}/tini-static ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/docker-init
}
