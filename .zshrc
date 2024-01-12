zstyle ':znap:*' repos-dir ~/.znap
[[ -f ~/.znap/znap.zsh ]] || git clone https://github.com/marlonrichert/zsh-snap.git --depth=1 ~/.znap
source ~/.znap/znap.zsh

bindkey -e

# export CC=gcc-13
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
# export CC=gcc-12
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.spicetify
export PATH=$PATH:$HOME/.docker/bin
export PATH="/opt/homebrew/opt/mysql-client@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH=/Users/neo/bin:$PATH
export GOPROXY=goproxy.cn,direct

export KUBECONFIG=~/.kube/config:~/.kube/config-new:~/.kube/config-istio:~/.kube/config-dev:~/.kube/config-prod

[[ -f ~/.cargo/env ]] && source ~/.cargo/env


setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

znap source zap-zsh/supercharge
znap source zap-zsh/sudo
znap source zap-zsh/completions
znap source wintermi/zsh-brew
znap source wintermi/zsh-rust

ZSH_AUTOSUGGEST_STRATEGY=( history )
znap source zsh-users/zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
znap source zsh-users/zsh-syntax-highlighting

znap source chivalryq/git-alias
znap source MichaelAquilina/zsh-you-should-use
znap source conda-incubator/conda-zsh-completion

znap fpath _kubectl 'kubectl completion zsh'
znap fpath _helm 'helm completion zsh'

# znap eval _brew "/opt/homebrew/bin/brew shellenv"
znap eval _zoxide 'zoxide init zsh'
znap eval _starship 'starship init zsh --print-full-init'
znap eval _autin "atuin init zsh"


znap prompt

alias vi='nvim'
alias ls='eza'
alias l='eza -lbF --git'
alias la='l -a'
alias ll='eza -lbhHigUmuS --time-style=long-iso --git --color-scale'
alias lla='ll -a'
alias lr='eza -R'
alias lt='eza -T --level=5'
alias lta='eza -T --level=5 -a'
alias lg='lazygit'
alias t='tmux attach || tmux new -s NEO'
alias kssh='kitty +kitten ssh'
alias icat='kitty +kitten icat'
alias diff="kitty +kitten diff"
alias bup='brew update && brew upgrade --greedy'

alias k='kubectl'
alias i='istioctl'
alias kubectl="kubecolor"

compdef kubecolor=kubectl

gitt () {
  # param validation
  if [[ ! `git log -n 1 $@ | head -n 1` ]] ;then
    return
  fi

  # filter by file string
  local filter
  # param existed, git log for file if existed
  if [ -n $@ ] && [ -f $@ ]; then
    filter="-- $@"
  fi

  # git command
  local gitlog=( git log --graph --color=always --abbrev=7 --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr' $@)

  # fzf command
  local fzf=(
    fzf
    --ansi --no-sort --reverse --tiebreak=index
    --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}"
    --bind "ctrl-d:preview-down,ctrl-u:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
   --preview-window=right:60%
  )

  # piping them
  $gitlog | $fzf
}

killp(){
  lsof -t -i:$1 | xargs kill -9
}


po(){
  export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891
}
pf(){
  unset http_proxy https_proxy all_proxy
}


alias bashly='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'

