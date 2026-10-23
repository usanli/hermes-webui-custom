FROM ghcr.io/nesquena/hermes-webui:latest@sha256:d0bbb1c5371b1f4b0a28e4cffa5f403780eb81601b66a6d6843f6fc338f08523
USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends git openssh-client curl ca-certificates \
 && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends gh \
 && rm -rf /var/lib/apt/lists/*
RUN git config --system credential.helper '!gh auth git-credential' \
 && git config --system safe.directory '*'
# USER root burada bilerek kalıyor: temel imajın entrypoint'i root başlayıp sonra hermeswebui kullanıcısına düşüyor.
