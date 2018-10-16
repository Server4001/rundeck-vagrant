#!/usr/bin/env bash

vault_bin_path='/usr/bin/vault'

if [ ! -f /usr/bin/man ]; then
  yum install -y man man-pages
fi
if [ ! -f /usr/bin/unzip ]; then
  yum install -y unzip
fi

if [ ! -f "${vault_bin_path}" ]; then
  wget -q https://releases.hashicorp.com/vault/0.11.3/vault_0.11.3_linux_amd64.zip
  unzip vault_0.11.3_linux_amd64.zip
  rm vault_0.11.3_linux_amd64.zip
  mv ./vault /usr/bin/vault
fi

