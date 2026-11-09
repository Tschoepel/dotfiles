# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.config/composer/vendor/bin:$PATH"

# Bun
export PATH="$HOME/.bun/bin:$PATH"

# .NET
export DOTNET_ROOT=/usr/share/dotnet
export PATH="$PATH:$DOTNET_ROOT"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Machine-wide secrets from the keys vault (installed by z0x.org/i.sh)
if [ -f "$HOME/.env" ]; then
  set -a
  . "$HOME/.env"
  set +a
fi

# User configuration
export EDITOR=nano
export ARCHFLAGS="-arch $(uname -m)"

# Aliases
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias c='clear'
alias cd='z'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level1 --icons=always'
alias cat='bat'
alias grep='grep --color=auto'

# zoxide (smart cd)
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.spin/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source "$HOME/.antigen/antigen.zsh"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle archlinux
antigen bundle sudo
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma-continuum/fast-syntax-highlighting

# Tell Antigen that you're done.
antigen apply

# Shell history (needs to load after the antigen bundles).
eval "$(atuin init zsh)"

eval "$(starship init zsh)"