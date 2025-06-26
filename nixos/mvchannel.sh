#!/usr/bin/env bash

set -e

sudo nix-channel --remove nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --update nixos

echo "Done."
