bindkey -e

export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.spicetify
export PATH=$PATH:$HOME/.docker/bin
export PATH="/opt/homebrew/opt/mysql-client@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export STARSHIP_CONFIG=$HOME/.config/starship.toml


# Created by Zap installer
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zap-zsh/supercharge"
plug "zap-zsh/exa"
plug "zap-zsh/sudo"
plug "zap-zsh/completions"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "wintermi/zsh-starship"
plug "wintermi/zsh-brew"
plug "wintermi/zsh-rust"
plug "chivalryq/git-alias"
plug "chrishrb/zsh-kubectl"
# plug "zap-zsh/vim"
# plug "Aloxaf/fzf-tab"



################ dev
alias ol='k logs -f -lapp.kubernetes.io/name=echomind-api'
alias ow='watch kubecolor get po -lapp.kubernetes.io/name=echomind-api'
alias vi='nvim'
alias ls='exa' l='exa -lbF --git' la='l -a' ll='exa -lbhHigUmuS --time-style=long-iso --git --color-scale' lla='ll -a' lr='exa -R' lt='exa -T --level=5'
alias lg='lazygit'
alias t='tmux attach -t NEO || tmux new -s NEO'
alias kssh='kitty +kitten ssh'
alias icat='kitty +kitten icat'
alias diff="kitty +kitten diff"
alias bup='brew update && brew upgrade --greedy'
alias k='kubecolor'
compdef kubecolor=kubectl

po(){
  export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891
}
pf(){
  unset http_proxy https_proxy all_proxy
}
killp(){
  lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill -9
}

eval "$(zoxide init zsh)"

