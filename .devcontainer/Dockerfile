# Based on the example Dockerfile at:
# https://github.com/microsoft/vscode-dev-containers/blob/master/containers/debian/.devcontainer/Dockerfile

# Update the VARIANT arg in devcontainer.json to override the Debian version below
ARG VARIANT=buster
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}


ARG SHELLCHECK_VERSION="v0.7.1"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
# Install xz-utils to extract tarballs
    && apt-get -y install --no-install-recommends xz-utils=5.2.4-1 \
# Install shellcheck (apt-get doesn't install the latest version needed by VS code, so installing from GitHub release, see:
# https://askubuntu.com/a/1228181)
    && mkdir -p /tmp/shellcheck \
    && wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz" | tar -xJv -C /tmp/shellcheck/ \
    && install -m 755 /tmp/shellcheck/shellcheck-${SHELLCHECK_VERSION}/shellcheck /usr/local/bin/shellcheck \
# Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/shellcheck \
