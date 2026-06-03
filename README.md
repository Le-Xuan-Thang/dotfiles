# Dotfiles

Personal macOS and Linux configuration for:

- Zsh with Oh My Zsh and Powerlevel10k
- Tmux with zsh, true color, vi copy mode, mouse support, and sensible pane defaults
- Neovim with `lazy.nvim`, LSP support, formatting, Telescope, Treesitter, and Python debugging

The files are managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Fresh install

### 1. Install command-line tools

#### macOS

Install Apple's command-line tools:

```sh
xcode-select --install
```

Install [Homebrew](https://brew.sh/):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```sh
brew install git stow tmux neovim ripgrep zsh-autosuggestions zsh-syntax-highlighting
```

#### Ubuntu or Debian

```sh
sudo apt update
sudo apt install git stow tmux neovim ripgrep zsh python3-pip
```

#### Arch Linux

```sh
sudo pacman -S git stow tmux neovim ripgrep zsh python-pip
```

`ripgrep` is used by Telescope's live grep feature.

Optional: install a [Nerd Font](https://www.nerdfonts.com/) for the best Neovim icon support.

### 2. Install Oh My Zsh and Powerlevel10k

Install [Oh My Zsh](https://ohmyz.sh/):

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Clone [Powerlevel10k](https://github.com/romkatv/powerlevel10k):

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -sfn ~/powerlevel10k ~/.oh-my-zsh/custom/themes/powerlevel10k
```

Install the Oh My Zsh plugins referenced by `.zshrc`:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

### 3. Clone and link the dotfiles

Back up existing config files before linking:

```sh
mv ~/.zshrc ~/.zshrc.backup 2>/dev/null || true
mv ~/.tmux.conf ~/.tmux.conf.backup 2>/dev/null || true
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
```

Clone this repository and use Stow to create symlinks in `$HOME`:

```sh
git clone https://github.com/Le-Xuan-Thang/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow --target="$HOME" .
```

Stow links `.tmux.conf` from this repository to `~/.tmux.conf`, which keeps the tmux setup compatible with older and newer tmux versions.

### 4. Review machine-specific Zsh settings

Before starting a new shell, review the bottom of `~/.zshrc`. It currently contains paths specific to the original machine, including:

```sh
/Users/lexuanthang
/opt/homebrew
~/.local/bin/env
```

Remove or update any paths that do not exist on the new machine. The `/opt/homebrew` paths assume an Apple Silicon Mac and must be removed or replaced on Linux.

On Linux, set Zsh as the default shell if needed:

```sh
chsh -s "$(which zsh)"
```

Start a new shell:

```sh
exec zsh
```

Configure the prompt if Powerlevel10k asks, or run:

```sh
p10k configure
```

## Neovim setup

Start Neovim:

```sh
nvim
```

On the first launch, Neovim automatically clones `lazy.nvim` and installs the configured plugins. Mason installs the configured Lua and Python language servers. Python debugging uses `debugpy`.

Install the configured formatters and Python debugger:

macOS:

```sh
brew install stylua
python3 -m pip install black debugpy
```

Arch Linux:

```sh
sudo pacman -S stylua python-black python-debugpy
```

Ubuntu and Debian users can install `black` and `debugpy` with `pip`. Install `stylua` using a package source available for your distribution.

```sh
python3 -m pip install --user black debugpy
```

Run `:Lazy`, `:Mason`, or `:checkhealth` inside Neovim to inspect the installation.

## Update symlinks

After adding files to this repository, refresh the links with:

```sh
cd ~/dotfiles
stow --restow --target="$HOME" .
```
