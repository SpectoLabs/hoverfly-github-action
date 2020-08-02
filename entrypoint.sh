#!/bin/sh

export RUNNER_GITHUB_WORKSPACE_PATH=$1
export RUNNER_HOVERFLY_INSTALL_PATH=$RUNNER_GITHUB_WORKSPACE_PATH/bin
export CONTAINER_HOVERFLY_INSTALL_PATH=$GITHUB_WORKSPACE/bin
export HOVERFLY_PLATFORM=linux_amd64
export HOVERFLY_VERSION=$INPUT_VERSION
export HOVERFLY_BUNDLE=hoverfly_bundle_$HOVERFLY_PLATFORM
export HOVERFLY_DOWNLOAD_URL=https://github.com/SpectoLabs/hoverfly/releases/download/

mkdir -p "$CONTAINER_HOVERFLY_INSTALL_PATH"
mkdir -p /tmp/hoverfly
cd /tmp/hoverfly || exit

wget "$HOVERFLY_DOWNLOAD_URL$HOVERFLY_VERSION/$HOVERFLY_BUNDLE.zip"
unzip $HOVERFLY_BUNDLE.zip
install -m 755 hoverfly "$CONTAINER_HOVERFLY_INSTALL_PATH"
install -m 755 hoverctl "$CONTAINER_HOVERFLY_INSTALL_PATH"

cd /tmp || exit
rm -rf /tmp/hoverfly

echo "Installed hoverfly and hoverctl"

"$CONTAINER_HOVERFLY_INSTALL_PATH/hoverfly" -version
"$CONTAINER_HOVERFLY_INSTALL_PATH/hoverctl" version

echo "::add-path::$RUNNER_HOVERFLY_INSTALL_PATH"
