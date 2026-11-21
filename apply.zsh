#!/usr/bin/env zsh
set -euo pipefail

cd ~/.config/nvim
git fetch
git reset --hard '@{u}'
