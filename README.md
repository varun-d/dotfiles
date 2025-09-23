# Personal Mac Dotfiles

## Tmux Config

I use a simple tmux config.

#### Use CAPSLOCK as Ctrl

#### Remap bindings for easy prefix, CAPSLOCK + a

```
# Remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix
```

#### [c]reate new window, switch to [n]ext or [p]revious or by [#]

```
prefix + c #e.g., CAPSLOCK + a, followed by 'c'
prefix + <#> #Switch to numbered window
prefix + n #Switch to next window
prefix + p #Switch to previous window
prefix + l #Switch to last used window
```

### Tmux Create / Attach / Detatch sessions

I use my Rust cli tool to create sessions based on folder name with preset windows.

For example, `0: server, 1: nvim, 2: term, 3: git, 4: ai`

#### [D]etatch session and attach-session

```bash
# From within a tmux session, prefix + d #Detatch session

tmux attach-session -t $SESSION_NAME
tmux attach-session # Connect with last session
```

![Simple tmux setup](tmux.png)

## NeoVim Config

TODO: Update to latest NeoVim

### TODO: Add the following plugins slowly and check for issues

Oil File Explorer to quickly create, delete files of any type!
https://github.com/nvim-lua/plenary.nvim?tab=readme-ov-file

## Completions

https://github.com/hrsh7th/nvim-cmp
https://github.com/Saghen/blink.cmp
