export PKGCONFIG_PATH="/usr/local/lib/pkgconfig:/opt/local/lib/pkgconfig"
export PATH=/opt/local/bin:/usr/local/mysql/bin/:$PATH:/usr/local/src/jruby-1.3.1/bin/:/opt/local/sbin/
export SVN_EDITOR="vim"
export MANPATH=/opt/local/man:$MANPATH
# number of lines kept in history
export HISTSIZE=10000
# number of lines saved in the history after logout
export SAVEHIST=10000
# location of history
export HISTFILE=~/.zhistory
# history options
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_allow_clobber
setopt hist_reduce_blanks
setopt share_history

#setopt auto_list list_ambiguous

setopt list_types

# directory options
setopt auto_cd
setopt auto_pushd

# lscolors
#export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jpg=01;35:*.png=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:"

export CLICOLOR=1
#export LSCOLORS=DxGxcxdxCxegedabagacad
export LSCOLORS=DxGxcxdxCxegedabagacad

# console colors
autoload -U colors && colors
alias ls="ls -F"

# completion
autoload -U compinit && compinit
# colorize completion
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=$color[cyan]=$color[red]"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# prevent CVS and SVN from being completed
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
# ignore completion functions
zstyle ':completion:*:functions' ignored-patterns '_*'
# ignore what's already selected on line
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
# hosts completion for some commands
#local knownhosts
#knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} ) 
#zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts
compctl -k hosts ftp lftp ncftp ssh w3m lynx links elinks nc telnet rlogin host
compctl -k hosts -P '@' finger

# manpage comletion
man_glob () {
  local a
  read -cA a
  if [[ $a[2] = -s ]] then
  reply=( ${^manpath}/man$a[3]/$1*$2(N:t:r) )
  else
  reply=( ${^manpath}/man*/$1*$2(N:t:r) )
  fi
}

compctl -K man_glob -x 'C[-1,-P]' -m - 'R[-*l*,;]' -g '*.(man|[0-9nlpo](|[a-z]))' + -g '*(-/)' -- man
# fuzzy matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# remove trailing slash in directory names, useful for ln
zstyle ':completion:*' squeeze-slashes true

# named directories
for i in $HOME/Work/ruby/ror/*; do
  project=`basename $i`;
  hash -d $project="$i"
done


# global aliases
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g B="&|"
alias -g HL="--help"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias spi='sudo port install'
alias ep="vi ~/.zshrc; source ~/.zshrc"
alias sup='svn up --ignore-externals'
alias sdif='svn di | mate'
alias aemacs='open /Applications/Aquamacs\ Emacs.app'
alias tailf='tail -f'
alias psax='ps ax'
alias pp='pwd | pbcopy'

# ruby/rails alias
alias sso='script/server'
alias ss='script/rails server'
alias ssob='script/server -p 3001'
alias sgo='script/generate'
alias sg='script/rails g'
alias sd='script/rails destroy'
alias sco='script/console'
alias sc='script/rails console'
alias rdm='rake db:migrate db:test:clone'
alias gi='gem install'
alias setupdbs="cp config/database.yml.sample config/database.yml;rake db:create;rake db:create RAILS_ENV=test;rake db:migrate"
alias clrlogs=':> log/*.log && :> log/*.output'

# emacs
alias ctaggen='ctags -e `find (app|spec|lib|config)/**/*.rb`'

# rabbitmq alias
alias rabq='sudo rabbitmqctl list_queues name durable messages messages_ready messages_unacknowledged messages_uncommitted'
alias rabe='sudo rabbitmqctl list_exchanges name type durable'
alias rabc='sudo rabbitmqctl list_connections user peer_address peer_port node address port timeout state'
alias rabb='sudo rabbitmqctl list_bindings'
alias rabstart='sudo rabbitmq-server -detached'
alias rabstop='sudo rabbitmqctl stop'
alias rabreset='sudo rabbitmqctl stop_app && sudo rabbitmqctl reset && sudo rabbitmqctl start_app'

export slice=prgmr
alias slice='ssh prgmr'

# ensures that deleting word on /path/to/file deletes only 'file', this removes the '/' from $WORDCHARS
export WORDCHARS="${WORDCHARS:s#/#}"
export WORDCHARS="${WORDCHARS:s#.#}"
export CUCUMBER_COLORS=pending_param=magenta:failed_param=magenta:passed_param=magenta:skipped_param=magenta
export RSPEC=true

# rvm configuration
[[ -s /Users/niranjan/.rvm/scripts/rvm ]] && source /Users/niranjan/.rvm/scripts/rvm 
rvm default

parse_git_branch() {
 	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function title () {
  unset PROMPT_COMMAND # more on this later
  echo -ne "\e]0;$1\a"
}

function precmd {
  title `pwd`
  PS1="%{$fg[yellow]%}%~%{$fg[green]%}$(parse_git_branch)%{$reset_color%}$ "	
  RPS1="%{$fg[yellow]%}$(~/.rvm/bin/rvm-prompt)%{$reset_color%}"
}


# Usage:
# title 'my title'

typeset -U fpath
autoload -U _git

#EC2 Configuration
export EC2_HOME=~/.ec2
export AWS_RDS_HOME=~/.rds
export PATH=$PATH:$EC2_HOME/bin:$AWS_RDS_HOME/bin
export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

#Android SDK Configuration
export PATH=$PATH:~/.android_sdk/tools
