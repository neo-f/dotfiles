zstyle ':znap:*' repos-dir ~/.znap
[[ -f ~/.znap/znap.zsh ]] || git clone https://github.com/marlonrichert/zsh-snap.git --depth=1 ~/.znap
source ~/.znap/znap.zsh

bindkey -e

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
# export CC=gcc-12
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.spicetify
export PATH=$PATH:$HOME/.docker/bin
export PATH="/opt/homebrew/opt/mysql-client@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
[[ -f ~/.cargo/env ]] && source ~/.cargo/env


setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

znap source zap-zsh/supercharge
znap source zap-zsh/exa
znap source zap-zsh/sudo
# znap source zap-zsh/fzf
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
znap fpath _kind 'kind completion zsh'
znap fpath _helm 'helm completion zsh'

znap eval _brew "/opt/homebrew/bin/brew shellenv"
znap eval _zoxide 'zoxide init zsh'
znap eval _starship 'starship init zsh --print-full-init'
znap prompt

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
  lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill -9
}


################ dev
alias ol='k logs -f -lapp.kubernetes.io/name=echomind-api'
alias ow='watch kubecolor get po -lapp.kubernetes.io/name=echomind-api'

po(){
  export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891
}
pf(){
  unset http_proxy https_proxy all_proxy
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

