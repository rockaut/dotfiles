#!/usr/bin/env bash

sudo apt update && sudo apt install -y \
         python3-pip python3-venv \
         sshpass \
         ncdu tree mc \
         jq \
         wget gnupg software-properties-common curl

python3 -m pip install --upgrade pip wheel

GITUI_VERSION=$(curl --silent https://github.com/extrawurst/gitui/releases/latest | tr -d '"' | sed 's/^.*tag\///g' | sed 's/>.*$//g' | sed 's/^v//')
wget https://github.com/extrawurst/gitui/releases/download/v${GITUI_VERSION}/gitui-linux-musl.tar.gz -O- | sudo tar -zxf - -C ~/.local/bin

YQ_VERSION=$(curl --silent https://github.com/mikefarah/yq/releases/latest | tr -d '"' | sed 's/^.*tag\///g' | sed 's/>.*$//g' | sed 's/^v//')
wget https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64 -O ~/.local/bin/yq && chmod +x ~/.local/bin/yq

curl -sLS https://get.arkade.dev | sudo sh

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
