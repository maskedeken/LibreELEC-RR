# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mesa"
PKG_VERSION="19.2.0-rc3"
PKG_SHA256="9d5e7ba697946501cd1d9d35b7efe6a2b09911ca6c8a5776ed6e5e7c3024b7da"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="https://github.com/mesa3d/mesa/archive/mesa-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat libdrm Mako:host"
PKG_LONGDESC="The Mesa 3D Graphics Library, is an open source software implementation of OpenGL, Vulkan, and other graphics API specifications."
PKG_TOOLCHAIN="meson"

if listcontains "${GRAPHIC_DRIVERS}" "(lima|panfrost)"; then
  PKG_VERSION="c9bebae2877e55cdcd94f9f9f3f6805238caeb28" # master-19.3
  PKG_SHA256="edccc9d9e06a161a38c361651275c136b3dc9475bd37f11c68d148ba0e782941"
  PKG_URL="https://gitlab.freedesktop.org/mesa/mesa/-/archive/$PKG_VERSION/mesa-$PKG_VERSION.tar.gz"
fi

get_graphicdrivers

PKG_MESON_OPTS_TARGET="-D dri-drivers=${DRI_DRIVERS// /,} \
                       -D gallium-drivers=${GALLIUM_DRIVERS// /,} \
                       -D gallium-extra-hud=false \
                       -D gallium-xvmc=false \
                       -D gallium-omx=disabled \
                       -D gallium-nine=false \
                       -D gallium-opencl=disabled \
                       -D shader-cache=true \
                       -D shared-glapi=true \
                       -D opengl=true \
                       -D gbm=true \
                       -D egl=true \
                       -D valgrind=false \
                       -D libunwind=false \
                       -D lmsensors=false \
                       -D build-tests=false \
                       -D selinux=false \
                       -D osmesa=none"

if [ "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" xorgproto libXext libXdamage libXfixes libXxf86vm libxcb libX11 libxshmfence libXrandr libglvnd"
  export X11_INCLUDES=
  PKG_MESON_OPTS_TARGET+=" -D platforms=x11,drm -D dri3=true -D glx=dri -D glvnd=true"
elif [ "${DISPLAYSERVER}" = "weston" ]; then
  PKG_DEPENDS_TARGET+=" wayland wayland-protocols"
  PKG_MESON_OPTS_TARGET+=" -D platforms=wayland,drm -D dri3=false -D glx=disabled"
else
  PKG_MESON_OPTS_TARGET+=" -D platforms=drm -D dri3=false -D glx=disabled"
fi

if [ "${LLVM_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" elfutils llvm"
  export LLVM_CONFIG="${SYSROOT_PREFIX}/usr/bin/llvm-config-host"
  PKG_MESON_OPTS_TARGET+=" -D llvm=true"
else
  PKG_MESON_OPTS_TARGET+=" -D llvm=false"
fi

if [ "${VDPAU_SUPPORT}" = "yes" -a "${DISPLAYSERVER}" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" libvdpau"
  PKG_MESON_OPTS_TARGET+=" -D gallium-vdpau=true"
else
  PKG_MESON_OPTS_TARGET+=" -D gallium-vdpau=false"
fi

if [ "${VAAPI_SUPPORT}" = "yes" ] && listcontains "${GRAPHIC_DRIVERS}" "(r600|radeonsi)"; then
  PKG_DEPENDS_TARGET+=" libva"
  PKG_MESON_OPTS_TARGET+=" -D gallium-va=true"
else
  PKG_MESON_OPTS_TARGET+=" -D gallium-va=false"
fi

if listcontains "${GRAPHIC_DRIVERS}" "vmware"; then
  PKG_MESON_OPTS_TARGET+=" -D gallium-xa=true"
else
  PKG_MESON_OPTS_TARGET+=" -D gallium-xa=false"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_MESON_OPTS_TARGET+=" -D gles1=true -D gles2=true"
else
  PKG_MESON_OPTS_TARGET+=" -D gles1=false -D gles2=false"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" vulkan-loader"
  PKG_MESON_OPTS_TARGET+=" -D vulkan-drivers=amd,intel"
else
  PKG_MESON_OPTS_TARGET+=" -D vulkan-drivers="
fi
