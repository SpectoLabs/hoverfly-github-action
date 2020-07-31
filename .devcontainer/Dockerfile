# Based on the example Dockerfile at:
# https://github.com/microsoft/vscode-dev-containers/blob/master/containers/debian/.devcontainer/Dockerfile

# Update the VARIANT arg in devcontainer.json to pick an Debian version: buster (or debian-10), stretch (or debian-9)
ARG VARIANT=buster
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

# Configure VSCode as the default editor for git commits
# Adapted from https://github.com/microsoft/vscode-dev-containers/blob/master/containers/codespaces-linux/.devcontainer/Dockerfile
ARG GIT_EDITOR_SCRIPT_SOURCE="https://raw.githubusercontent.com/microsoft/vscode-dev-containers/master/containers/codespaces-linux/.devcontainer/git-ed.sh"
RUN mkdir -p /tmp/git-ed \
    && curl -sSL  ${GIT_EDITOR_SCRIPT_SOURCE} -o /tmp/git-ed/git-ed.sh \
    && install -m 755 /tmp/git-ed/git-ed.sh /usr/local/bin/git-ed.sh \
    && git config --global core.editor "/usr/local/bin/git-ed.sh" \
# Clean up
    && rm -rf /tmp/git-ed
