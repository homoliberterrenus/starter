# 💤 LazyVim

Personal [LazyVim](https://github.com/LazyVim/LazyVim) config.

## Initial install

```sh
git clone /path/to/this/repo ~/.config/nvim
```

## Deploying changes

`~/.config/nvim` is a clone of this repo. After committing here, run:

```sh
./apply.zsh
```

It does `cd ~/.config/nvim`, `git fetch`, and `git reset --hard @{u}`, so local changes in `~/.config/nvim` are discarded.

Then restart nvim (plugin spec changes: run `:Lazy sync`).
