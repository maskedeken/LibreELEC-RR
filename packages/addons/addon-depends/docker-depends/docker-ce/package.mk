# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="docker-ce"
PKG_VERSION="19.03.3"
PKG_SHA256="63b0d28608f32573b9c03fa46247c6f959e9c08133ddf30a71276919de0194c0"
PKG_LICENSE="ASL"
PKG_SITE="http://www.docker.com/"
PKG_URL="https://github.com/docker/docker-ce/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain sqlite go:host"
PKG_LONGDESC="Docker: an open source project to pack, ship and run any application as a lightweight container."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  # Set Docker config path to Kodi addon storage
  cd ${PKG_BUILD}
  find -name *.go -exec sed -i "s#/etc/docker#/storage/.kodi/userdata/addon_data/service.system.docker/config#g" \{} \;
}

configure_target() {
  # Setup golang toolchain
  case ${TARGET_ARCH} in
    x86_64)
      export GOARCH=amd64
      ;;
    arm)
      export GOARCH=arm

      case ${TARGET_CPU} in
        arm1176jzf-s)
          export GOARM=6
          ;;
        *)
          export GOARM=7
          ;;
      esac
      ;;
    aarch64)
      export GOARCH=arm64
      ;;
  esac

  export GOOS=linux
  export CGO_ENABLED=1
  export CGO_NO_EMULATION=1
  export CGO_CFLAGS=${CFLAGS}
  export LDFLAGS="-w -linkmode external -extldflags -Wl,--unresolved-symbols=ignore-in-shared-libs -extld $CC"
  export GOLANG=${TOOLCHAIN}/lib/golang/bin/go
  export GOROOT=${TOOLCHAIN}/lib/golang
  export PATH=${PATH}:${GOROOT}/bin

  # Set Docker build opts
  export DOCKER_BUILDTAGS="daemon \
                           autogen \
                           exclude_graphdriver_devicemapper \
                           exclude_graphdriver_aufs \
                           exclude_graphdriver_btrfs \
                           journald"

  # Set Git commit matching the release https://github.com/docker/docker-ce/releases
  export PKG_GIT_COMMIT="a872fc2f86c042e6992e17db6cdd9826c9c4232b"

  # Set Docker commit / version / buildtime
  export GITCOMMIT=${PKG_GIT_COMMIT}
  export VERSION=${PKG_VERSION}
  export BUILDTIME="$(date --utc)"

  export PKG_CLI_FLAGS="-X 'github.com/docker/cli/cli/version.Version=${VERSION}'"
  export PKG_CLI_FLAGS+=" -X 'github.com/docker/cli/cli/version.GitCommit=${GITCOMMIT}'"
  export PKG_CLI_FLAGS+=" -X 'github.com/docker/cli/cli/version.BuildTime=${BUILDTIME}'"

  # Set source file & gopaths vars
  PKG_CLI_COMPONENTS_PATH="${PKG_BUILD}/components/cli"
  PKG_ENGINE_COMPONENTS_PATH="${PKG_BUILD}/components/engine"

  PKG_CLI_GOPATH="${PKG_BUILD}/.gopath_cli"
  PKG_CLI_GOPATH_SRC="${PKG_CLI_GOPATH}/src"
  PKG_ENGINE_GOPATH="${PKG_BUILD}/.gopath_engine/src"
  PKG_ENGINE_GOPATH_SRC="${PKG_ENGINE_GOPATH}/src"
  
  # Generate "version_autogen.go"
  cd ${PKG_ENGINE_COMPONENTS_PATH}
  bash hack/make/.go-autogen
  cd ${PKG_BUILD}

  # Setup cli gopath & src files
  mkdir -p ${PKG_CLI_GOPATH_SRC}
  if [ -d ${PKG_CLI_COMPONENTS_PATH}/vendor ]; then
    mv ${PKG_CLI_COMPONENTS_PATH}/vendor/* ${PKG_CLI_GOPATH_SRC}
  fi

  if [ ! -L ${PKG_CLI_GOPATH_SRC}/github.com/docker/cli ]; then
    ln -fs ${PKG_CLI_COMPONENTS_PATH} ${PKG_CLI_GOPATH_SRC}/github.com/docker/cli
  fi

  # Setup engine gopath & src files
  mkdir -p ${PKG_ENGINE_GOPATH_SRC}
  if [ -d ${PKG_ENGINE_COMPONENTS_PATH}/vendor ]; then
    mv ${PKG_ENGINE_COMPONENTS_PATH}/vendor/* ${PKG_ENGINE_GOPATH_SRC}
  fi

  if [ ! -L ${PKG_ENGINE_GOPATH_SRC}/github.com/docker/docker ]; then
    ln -fs  ${PKG_ENGINE_COMPONENTS_PATH} ${PKG_ENGINE_GOPATH_SRC}/github.com/docker/docker
  fi
}

make_target() {
  # Create bin directory
  mkdir -p bin

  # Build docker cli
  export GOPATH=${PKG_CLI_GOPATH}
  ${GOLANG} build -v -o bin/docker  -a -tags "${DOCKER_BUILDTAGS}" -ldflags "${LDFLAGS} ${PKG_CLI_FLAGS}" ./components/cli/cmd/docker
  # Build docker engine
  export GOPATH=${PKG_ENGINE_GOPATH}
  ${GOLANG} build -v -o bin/dockerd -a -tags "${DOCKER_BUILDTAGS}" -ldflags "${LDFLAGS}" ./components/engine/cmd/dockerd
}

makeinstall_target() {
  :
}
