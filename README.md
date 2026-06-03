# Dotfiles

Personal terminal and editor configuration for macOS and Linux.

This repository is managed with [GNU Stow](https://www.gnu.org/software/stow/). The tracked files are laid out exactly like they should appear under `$HOME`, so running Stow from the repository root creates the right symlinks automatically.

## What is included

- `.zshrc`: Oh My Zsh, Powerlevel10k, syntax highlighting, autosuggestions, module support, and machine-specific PATH entries.
- `.bashrc`: Bash defaults for Linux-style environments, completion, module support, Linuxbrew, opencode, and Bun.
- `.tmux.conf`: tmux with true color, mouse mode, vi copy mode, one-based panes/windows, current-directory splits, and a reload binding.
- `.config/nvim`: a Kickstart-based Neovim configuration using Neovim's built-in `vim.pack` plugin manager.

## Install

### 1. Install base tools

macOS:

```sh
xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git stow tmux neovim ripgrep make zsh-autosuggestions zsh-syntax-highlighting
```

Ubuntu or Debian:

```sh
sudo apt update
sudo apt install git stow tmux neovim ripgrep make zsh python3-pip
```

Arch Linux:

```sh
sudo pacman -S git stow tmux neovim ripgrep make zsh python-pip
```

Install a Nerd Font if you want icons in Neovim and Powerlevel10k to render correctly.

### 2. Install Zsh extras

Install Oh My Zsh:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install Powerlevel10k:

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -sfn ~/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k
```

Install the Oh My Zsh plugins used by `.zshrc`:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

Linux users can make Zsh the default shell after it is installed:

```sh
chsh -s "$(which zsh)"
```

### 3. Clone and link

Back up files that Stow will replace:

```sh
mv ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
mv ~/.bashrc ~/.bashrc.backup 2>/dev/null || true
mv ~/.tmux.conf ~/.tmux.conf.backup 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
```

Clone the repo and create symlinks into `$HOME`:

```sh
git clone https://github.com/Le-Xuan-Thang/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --target="$HOME" .
```

Refresh symlinks after changing or adding files:

```sh
cd ~/dotfiles
stow --restow --target="$HOME" .
```

Remove symlinks created by this repo:

```sh
cd ~/dotfiles
stow --delete --target="$HOME" .
```

## Machine-specific notes

Review `.zshrc` and `.bashrc` before using this repo on a new machine. Some entries intentionally point to local installations or host-specific paths, including:

```sh
/opt/homebrew
$HOME/.antigravity
$HOME/.opencode
/home/linuxbrew/.linuxbrew
```

Remove or update paths that do not exist on the target machine. Prefer `$HOME` for user-local paths instead of hardcoded usernames. The Homebrew paths are split between Apple Silicon macOS and Linuxbrew setups.

After linking, start a fresh shell:

```sh
exec zsh
```

Run the Powerlevel10k prompt wizard if needed:

```sh
p10k configure
```

## tmux

The tmux configuration uses the current shell from `$SHELL`, enables true color, and keeps new splits in the current pane's directory.

Useful bindings:

- Prefix: `C-b`
- Reload config: `C-b r`
- Horizontal split: `C-b |`
- Vertical split: `C-b -`

Mouse mode is enabled, copy mode uses vi keys, windows and panes start at `1`, and windows are renumbered automatically.

## Neovim

The Neovim setup is based on Kickstart and uses `vim.pack`, so there is no `lazy-lock.json` or external plugin manager bootstrap.

Main features:

- Leader key: `<Space>`
- Relative line numbers, persistent undo, smart search, system clipboard, visible whitespace, and split-friendly defaults.
- `tokyonight-night`, `mini.statusline`, `which-key`, `gitsigns`, `todo-comments`, `mini.ai`, and `mini.surround`.
- Telescope for files, buffers, grep, help, commands, diagnostics, and LSP pickers.
- Mason-managed Lua tooling with native LSP setup for `lua_ls`.
- `blink.cmp` completion with LuaSnip snippets.
- Treesitter parser installation and auto-attach.
- Neo-tree enabled with `\` reveal and `<leader>e` toggle.
- Autopairs enabled.

Start Neovim once to install plugins:

```sh
nvim
```

Inside Neovim, useful maintenance commands are:

```vim
:lua vim.pack.update()
:Mason
:checkhealth
```

Common keymaps:

- `<leader>sf`: find files, including hidden files
- `<leader>sg`: live grep
- `<leader>sw`: search current word
- `<leader>sd`: search diagnostics
- `<leader><leader>`: switch buffers
- `<leader>/`: fuzzy search the current buffer
- `<leader>sn`: search Neovim config files
- `<leader>f`: format the current buffer or selection
- `grd`, `grr`, `gri`, `grt`: LSP definition, references, implementation, and type definition
- `grn`: LSP rename
- `gra`: LSP code action
- `<leader>th`: toggle LSP inlay hints when supported

Optional Kickstart example modules for debugging, linting, indent guides, and extra gitsigns mappings are present under `.config/nvim/lua/kickstart/plugins/`. Enable them from `.config/nvim/init.lua` when needed.

## Repository workflow

Use Git normally after editing files:

```sh
git status
git diff
git add .
git commit -m "update dotfiles"
```

The `.stow-local-ignore` file keeps repository-only files such as `.git` and `README.md` from being linked into `$HOME`.
