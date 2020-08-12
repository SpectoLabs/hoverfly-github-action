# Based on the example Dockerfile at:
# https://github.com/microsoft/vscode-dev-containers/blob/master/containers/debian/.devcontainer/Dockerfile

# Update the VARIANT arg in devcontainer.json to pick an Debian version: buster (or debian-10), stretch (or debian-9)
ARG VARIANT=buster
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}


ARG GIT_EDITOR_SCRIPT_SOURCE="https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/containers/codespaces-linux/.devcontainer/git-ed.sh"
ARG SHELLCHECK_VERSION="v0.7.1"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# hadolint ignore=DL3008
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
# Install xz-utils to extract tarballs
    && apt-get -y install --no-install-recommends xz-utils \
# Install shellcheck (apt-get doesn't install the latest version needed by VS code, so installing from GitHub release, see:
# https://askubuntu.com/a/1228181)
    && mkdir -p /tmp/shellcheck \
    && wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz" | tar -xJv -C /tmp/shellcheck/ \
    && install -m 755 /tmp/shellcheck/shellcheck-${SHELLCHECK_VERSION}/shellcheck /usr/local/bin/shellcheck \
# Configure VSCode as the default editor for git commits
# Adapted from https://github.com/microsoft/vscode-dev-containers/blob/master/containers/codespaces-linux/.devcontainer/Dockerfile
    && mkdir -p /tmp/git-ed \
    && wget -qO /tmp/git-ed/git-ed.sh ${GIT_EDITOR_SCRIPT_SOURCE} \
    && install -m 755 /tmp/git-ed/git-ed.sh /usr/local/bin/git-ed.sh \
    && git config --global core.editor "/usr/local/bin/git-ed.sh" \
# Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/shellcheck \
    && rm -rf /tmp/git-ed
