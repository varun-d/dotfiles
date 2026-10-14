# nvim_nightly review — October 2026

Reviewed 2026-10-13 against Neovim v0.12.0 (`~/.nvim_nightly`), the config in this folder, the
installed plugins under `~/.local/share/nvim_nightly/site/pack/core/opt`, and the pasted
`:checkhealth` output.

**Verdict:** the config is healthy. No errors in checkhealth, no deprecated API calls, and every
formatter and LSP binary it references is installed. What needs attention is one broken keymap,
a handful of options that are silently ignored, and a plugin set that has not been updated since
April.

## - [x] 1. Fix these (broken or silently doing nothing)

**1.1 — `lua/keybindings.lua:6`**

Problem: `<leader>u` runs `<cmd>[U]pdate Plugins<CR>`, which is not a command. The description
text ended up in the command slot. Pressing it errors.

Fix:

```lua
setkmap("n", "<leader>u", function()
	vim.pack.update()
end, { desc = "[U]pdate Plugins" })
```

- [x] **1.2 — `init.lua:29`**

Problem: `branch = "main"` and `build = ":TSUpdate"` are not `vim.pack` spec fields (only `src`,
`name`, `version`, `data` exist). Both are ignored, so parsers are never rebuilt after a plugin
update.

Fix: drop both keys (`main` is already the default branch) and add the `PackChanged` hook shown
at the end of this section.

- [x] **1.3 — `init.lua:209-214`**

Problem: `stylua = { arg = {...} }` — `arg` is not a conform key, so `--indent-type Spaces` is
never passed. Confirmed: the files here are tab-indented and `stylua --check` passes with
defaults.

Fix: either delete the block (keep tabs) or use `prepend_args`. Better: a `stylua.toml` so the
CLI and editor agree. See 1.4.

- [x] **1.4 — `after/ftplugin/lua.lua`**

Problem: sets `expandtab` + `shiftwidth = 2` + `softtabstop = 4`, but stylua rewrites to tabs on
every save. Editor and formatter disagree.

Fix: pick one.

- For tabs: `vim.bo.expandtab = false` and drop the rest.
- For 2 spaces: add `stylua.toml` with `indent_type = "Spaces"`, `indent_width = 2` and set
  `softtabstop = 2`.

- [x] **1.5 — `init.lua:188`**

Problem: `python = { "ruff", "ruff_format" }` — conform's `ruff` is a deprecated alias for
`ruff_fix`.

Fix: `python = { "ruff_fix", "ruff_format" }` (add `"ruff_organize_imports"` if wanted).

- [x] **1.6 — `init.lua:69`**

Problem: `setkmap("n", "-", ..., { desc = ... }, silent)` — the 5th argument is ignored, so
`silent` is never applied.

Fix: merge into the opts table: `{ desc = "Open parent directory", silent = true }`. The
`local silent` on line 2 is then unused.

- [x] **1.7 — `lua/lsp.lua:23`**

Problem: `jump_to_single_result` was renamed to `jump1` in fzf-lua (still works through a compat
shim).

Fix: `lsp_definitions({ jump1 = true })`

- [x] **1.8 — `lua/lspconfigs.lua:11-16`**

Problem: `root_markers` on `ts_ls` is dead: nvim-lspconfig's `ts_ls` defines `root_dir`, which
takes precedence. `cmd` and `filetypes` also just restate the defaults.

Fix: delete the whole `vim.lsp.config("ts_ls", ...)` block and keep `vim.lsp.enable("ts_ls")`.

`PackChanged` hook for 1.2, replacing `build = ":TSUpdate"` (must be defined before
`vim.pack.add`):

```lua
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind ~= "delete" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})
```

## 2. Updates

- **Neovim 0.12.0 → 0.12.6.** Six patch releases behind. Note that the folder and alias say
  "nightly" but the binary at `~/.nvim_nightly` is a stable 0.12.0 release build.
- **Plugins are pinned to early April 2026.** The lockfile has not moved in about six months.
  Upstream has newer commits for nvim-treesitter, mason.nvim (v2.2.1 → v2.3.1, flagged by
  checkhealth), blink.cmp and nvim-lspconfig; which-key is current. Run `:lua vim.pack.update()`,
  review the diff buffer, `:write` to apply, then commit `nvim-pack-lock.json`.
- After updating nvim-treesitter, run `:TSUpdate` once by hand (until fix 1.2 is in place).
  Several parsers are still ABI 13/14 (gitignore, html, json, toml, tsx, typescript, svelte,
  fish, dockerfile); they work, an update will likely bring them to 15.

- [x] ## 3. Treesitter highlighting is only on for a few filetypes

`vim.treesitter.start()` is called only in `after/ftplugin/javascriptreact.lua` and
`typescriptreact.lua`. Neovim itself starts it for lua, help and query. Every other installed
parser (python, go, rust, typescript, javascript, css, html, json, yaml, bash, markdown, ...) is
installed but unused, and those buffers fall back to regex syntax.

Replace the two ftplugin files with one autocmd in `init.lua`:

```lua
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
	callback = function(ev)
		if pcall(vim.treesitter.start, ev.buf) then
			vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
```

Notes:

- If you do this, the `syntax match` todo highlighting in `after/ftplugin/markdown.lua` stops
  showing, because treesitter turns regex syntax off. Either exclude markdown from the autocmd or
  drop the custom todo highlights.
- `"jsx"` in the install list is a query-only language with no parser (checkhealth lists it
  blank). It is pulled in by `javascript`/`tsx` anyway, so it can be removed from the list.

## 4. LSP setup

- [x] - **Servers are enabled in three places.** `lspconfigs.lua` enables ts_ls, tailwindcss, csskit;
      `after/ftplugin/{go,lua,python}.lua` enable gopls, lua_ls, ty. That is why checkhealth shows
      only three "Enabled Configurations". It works, but `vim.lsp.enable()` is already lazy per
      filetype, so the ftplugin indirection buys nothing and re-runs on every buffer. Move all six
      into `lspconfigs.lua`: `vim.lsp.enable({ "ts_ls", "tailwindcss", "csskit", "gopls", "lua_ls", "ty" })`
      and keep the gopls `settings` block next to it.
- [x] - **Nothing installs the tools on a new machine.** `ty`, `csskit`, `tailwindcss-language-server`,
      `typescript-language-server`, `stylua` and `prettier` exist only in Mason's bin directory, and
      there is no ensure-installed step. Add a small loop over `require("mason-registry")` in
      `init.lua`, or at least list the packages in the README.
- [x] - **`vim.lsp.config["*"] = { capabilities = ... }`** (`init.lua:135`) is redundant on 0.11+;
      blink.cmp registers its capabilities itself. Safe to delete.
- **lua_ls has no Neovim awareness.** No `.luarc.json` and no `settings.Lua`, so editing this
  config gives "undefined global `vim`" diagnostics. Add `folke/lazydev.nvim`, or a `.luarc.json`
  with `"workspace.library": ["$VIMRUNTIME"]` and `"runtime.version": "LuaJIT"`.
- [x] - **csskit** has no nvim-lspconfig entry, so your block is the whole config. It has no
      `root_markers`, which is fine (single-file mode). It is still an alpha project; `cssls`
      (`vscode-css-language-server`) is the stable alternative if it misbehaves.
- **Gaps, optional:** no server for `html`, `json` or `yaml`, and `tailwindcss` skips
  `javascript`/`typescript`/`svelte`/`vue` although parsers for all of them are installed.
- [x] - The header comment in `lua/lsp.lua:1` says `lua/lspux.lua`.

## 5. Keymaps and options cleanup

`lua/keybindings.lua`

- [x] - Lines 40 and 44 define the same `x` mapping twice.
- [x] - Lines 51-52 define `<leader>c` twice. The second overrides the first in normal mode, and in
      visual mode `"+yy<ESC>` only works by accident (`"+y` yanks, the second `y` is cancelled by
      `<ESC>`). Use one `n` mapping with `"+yy` and one `x` mapping with `"+y`.
- [x] - Line 36 comment says "jk kj" but only `jk` is mapped.
- [x] - Line 9: `:update<CR> :source<CR>` echoes in the command line; `<cmd>update<bar>source<CR>` is
      quieter.
- Most mappings have no `desc`, so which-key shows raw commands for them.

`init.lua`

- which-key groups `<leader>d` "[D]ebug" (only holds `dq`, a diagnostic list) and `<leader>t`
  "[T]oggle" (holds nothing) are misleading. Rename or remove.
- `<leader>sq` is described as "Search [Q]uickfix" but opens document diagnostics.
- `vim.opt.termguicolors = true` (line 222) is auto-detected since 0.10; removable.
- `format_on_save.timeout_ms = 500` is tight for a cold prettier start on a large file; 1000-2000
  avoids intermittent "formatter timed out".
- The prettier `prepend_args` impose `--no-semi --single-quote --no-bracket-spacing` on every
  project without its own prettier config. Intentional presumably; just be aware when touching
  other people's repos.

`lua/options.lua`

- `require("vim._core.ui2").enable(...)` is a private, experimental module that has already been
  renamed once upstream. Wrap it in `pcall` so a Neovim upgrade cannot break startup.
- Comment says "leave 8 rows", value is `scrolloff = 10`.
- `splitright` is set but not `splitbelow`.

`after/ftplugin/markdown.lua`

- The `Syntax` autocmd has no augroup, so a new copy is registered for every markdown buffer
  opened. Give it a group with `clear = true`, or move the highlight to `after/syntax/markdown.vim`.
- `vim.wo.wrap = true` sticks to the window after you switch buffers. Use `vim.wo[0][0].wrap = true`.

## 6. Checkhealth warnings: what to do with each

**blink.cmp — "providers may show up as disabled"**

Informational. Ignore.

**fzf_lua — `viu` / `chafa` / `ueberzugpp` not found**

Only needed for image previews in the picker. `brew install chafa` if wanted, otherwise ignore.

**mason — v2.2.1, latest v2.3.1**

Fixed by the plugin update in section 2.

**mason — wget, luarocks, composer, php, java, javac, julia missing**

Ignore. Only needed to install packages written in those languages; curl covers downloads.

**vim.health — Nvim 0.12.6 available**

Update (section 2).

**vim.provider — node, perl, python3, ruby providers missing**

You use no remote plugins. Disable them to silence the warnings (snippet below).

**which-key — `nvim-web-devicons` not installed**

Ignore, or add `require("mini.icons").mock_nvim_web_devicons()` after `mini.icons` setup.

**which-key — overlapping keymaps (`gc`/`gcc`, `sf`/`sfl`...)**

Expected from mini.surround and built-in commenting. Ignore. Note mini.surround takes over `s`,
and with `timeoutlen = 300` the `sa`/`sd`/`sr` chords must be typed quickly.

**vim.lsp — "file watching disabled on all clients"**

Reported because no client was active when checkhealth ran. Ignore.

```lua
-- options.lua
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
```

## 7. Suggested order

1. Fix `<leader>u` (1.1), then use it to update plugins and commit the lockfile.
2. Upgrade Neovim to 0.12.6.
3. Add the `PackChanged` hook and the treesitter `FileType` autocmd.
4. Resolve the stylua tabs-vs-spaces conflict and the `ruff` rename.
5. Consolidate LSP enables and add lua_ls workspace settings.
6. Cleanup items from section 5 and the provider snippet.
