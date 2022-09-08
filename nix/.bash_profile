case $- in
    *i*) ;;
      *) return;;
esac

export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoreboth
export HISTIGNORE="&:ls:ll:history:[bf]g:exit"

shopt -s checkwinsize
shopt -s autocd
shopt -s cdspell

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.arkade/bin:$PATH";

# ###########################################################################################
# A L I A S E S
# ###########################################################################################

alias pva="source ./venv/bin/activate"
alias ll='ls -lhAF'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias tm="tmux attach || tmux new"
alias we="explorer.exe"
alias ch="/mnt/c/Users/$USER"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ###########################################################################################
# E X P O R T S
# ###########################################################################################

# Make vim the default editor.
export EDITOR='vim';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# like above those files will get sourced but aren't included in the repo
for file in ~/.{secrets,extras}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;


# ###########################################################################################
# P R O M P T n S h e l l
# ###########################################################################################

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [[ -f ~/.local/bin/starship ]]; then
  eval "$(starship init bash)"
fi


# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

if command -v kubectl &> /dev/null
then
    source <(kubectl completion bash)
fi

# ###########################################################################################
# S S H A G E N T
# ###########################################################################################

ssh-add -l &>/dev/null
if [ "$?" == 2 ]; then
  test -r ~/.ssh-agent && \
    eval "$(<~/.ssh-agent)" >/dev/null

  ssh-add -l &>/dev/null
  if [ "$?" == 2 ]; then
    (umask 066; ssh-agent > ~/.ssh-agent)
    eval "$(<~/.ssh-agent)" >/dev/null
    ssh-add
  fi
fi
