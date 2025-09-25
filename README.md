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

### TODO

- [x] Update to latest NeoVim
- [x] Simplify LSP config, start with Lua Lsp
- [ ] python, typescript, go, rust lsp
- [ ] autoformat on save
- [ ] mini.pick if needed
- [ ] fzf-lua
- [ ] blink cmp
- [ ] Add OpenCode support
- [ ] Do I need this? https://github.com/nvim-lua/plenary.nvim
