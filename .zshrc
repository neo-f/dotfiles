bindkey -e

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export CC=gcc-12
export PATH=$PATH:$HOME/go/bin
[[ -f ~/.cargo/env ]] && source ~/.cargo/env


export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh.his
# export TERM=xterm

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

zstyle ':znap:*' repos-dir ~/.znap
[[ -f ~/.znap/znap.zsh ]] || git clone https://github.com/marlonrichert/zsh-snap.git --depth=1 ~/.znap
source ~/.znap/znap.zsh

# oh-my-zsh
znap source ohmyzsh/ohmyzsh lib/completion
znap source ohmyzsh/ohmyzsh plugins/{git,extract}

znap source esc/conda-zsh-completion

znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source djui/alias-tips

znap compdef _rustup 'rustup completions zsh'
znap compdef _cargo  'rustup completions zsh cargo'

znap eval kubectl_ 'kubectl completion zsh'
znap eval brew_ "/opt/homebrew/bin/brew shellenv"
znap eval zoxide_ 'zoxide init zsh'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

znap eval starship 'starship init zsh --print-full-init'

alias vi='nvim'
alias ls='exa' l='exa -lbF --git' la='l -a' ll='exa -lbhHigUmuS --time-style=long-iso --git --color-scale' lla='ll -a' lr='exa -R' lt='exa -T --level=5'
alias lg='lazygit'
alias t='tmux attach -t NEO || tmux new -s NEO'
alias kssh='kitty +kitten ssh'
alias icat='kitty +kitten icat'
alias diff="kitty +kitten diff"
alias bup='brew update && brew upgrade --greedy'

alias k='kubectl'
alias kubectl="kubecolor"

kga(){
  kubecolor get po -o wide -lrdm_app=voc-${1}
}


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
  lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill
}

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi


export PATH="$PATH:$HOME/.spicetify"
export PATH="/opt/homebrew/opt/mysql-client@5.7/bin:$PATH"


################ dev
alias cl='kubectl logs -f -lrdm_app=voc-cp-service'
alias cw='watch kubectl get po -lrdm_app=voc-cp-service'
po(){
  export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
}
pf(){
  unset http_proxy https_proxy all_proxy
}
