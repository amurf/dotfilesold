# 2tLyAbHursRSe3nNPPEu
# QXmcr9UYQXLw

# qr^CXC8B%rtK3#-
export BASH_SILENCE_DEPRECATION_WARNING=1

envvar_contains() {
  local pathsep=${PATHSEP:-:}
  eval "echo \$$1" | egrep -q "(^|$pathsep)$2($pathsep|\$)";
}

strip_envvar() {
  [ $# -gt 1 ] || return;

  local pathsep=${PATHSEP:-:}
  local haystack=$1
  local needle=$2
  echo $haystack | sed -e "s%^${needle}\$%%" \
    | sed -e "s%^${needle}${pathsep}%%" \
    | sed -e "s%${pathsep}${needle}\$%%" \
    | sed -e "s%${pathsep}${needle}${pathsep}%${pathsep}%"
}


prepend_envvar_here() { prepend_envvar $1 $(pwd); }


prepend_envvar() {
  local envvar=$1
  local pathsep=${PATHSEP:-:}
  eval "local envval=\$(strip_envvar \$$envvar $2)"
  if test -z $envval; then
    eval "export $envvar=\"$2\""
  else
    eval "export $envvar=\"$2$pathsep$envval\""
  fi
  #eval "echo \$envvar=\$$envvar"
}
prepend_envvar_at() {
  cd $2 || return
  prepend_envvar_here $1
  cd - >> /dev/null
}

perlat() { for i in $@; do PATHSEP=: prepend_envvar_at PERL5LIB $i; done; }
source ~/.git-completion.sh
source "$HOME/.sdkman/bin/sdkman-init.sh"


set -o vi
bind '"jj":vi-movement-mode'


export GITPERLLIB="/usr/local/opt/git/share/perl5:$(echo /usr/local/opt/subversion/lib/perl5/site_perl/*/darwin-thread-multi-2level):$(echo /usr/local/Cellar/git/*/share/perl5/)"

export ANDROID_HOME=/usr/local/opt/android-sdk
export LANG="en_US.UTF-8"
export PERL_BADLANG="0"
export PAGER=less
export EDITOR=/usr/bin/vim
export PATH=/usr/local/opt/ruby/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:$PATH
export PERL5LIB=/usr/local/lib/perl5

export PERL_LOCAL_LIB_ROOT="$HOME/perl5"
export PERL_MB_OPT="--install_base $PERL_LOCAL_LIB_ROOT"
export PERL_MM_OPT="INSTALL_BASE=$PERL_LOCAL_LIB_ROOT"
perlat "$PERL_LOCAL_LIB_ROOT/lib/perl5" "$PERL_LOCAL_LIB_ROOT/lib/perl5/$ARCH"

# :/Library/Developer/CommandLineTools/usr/bin:$PATH
export SBT_OPTS=-XX:MaxPermSize=256M
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
export PS1='\[\e[\033[01;34m\]\u@\h:\[\e[38;5;222m\]\W\[\e[\033[38;5;211m\]$( __git_ps1 )\[\e[\033[00m\]\n$ '

alias fig=docker-compose
alias ack=ag
alias create-perl-backend='docker run -it --rm -v "$PWD:$PWD" -w "$PWD" amurf/create-perl-backend'
alias jspm='docker run -it --rm -v "$PWD:$PWD" -w "$PWD" amurf/jspm jspm'
alias surge='docker run -it --rm -v "$PWD:$PWD" -w "$PWD" amurf/surge surge'
alias node-run='docker run -it --rm -p 8080:8080 -v "$PWD:/node-run" amurf/node-run'

alias mix='docker run -it --rm  -v "$PWD:$PWD" -w "$PWD" elixir:alpine mix'
alias rustc='docker run -it --rm  -v "$PWD:/source" jimmycuadra/rust rustc'
alias cargo='docker run -it --rm  -v "$PWD:/source" jimmycuadra/rust cargo'

alias docker-clean='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias fzf='fzf --no-mouse'


# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Ash Mode Enabled
alias vim='echo Use vf or vo instead, fuzzyfinderers'
alias vi='echo Use vf or vo instead, fuzzyfinderers'
alias ireallyneedvim="/usr/bin/vim"
alias vimnotes='ireallyneedvim ~/.vimnotes'
alias bashrc="ireallyneedvim ~/.bashrc"
alias docker-restart="osascript -e 'quit app \"Docker\"' && open -a Docker"
alias start-vnc="sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -restart -agent -privs -all"

alias http="docker run --rm -v $PWD:/usr/share/nginx/html:ro -p 8000:80 -d nginx:alpine"

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

vf() {
  if [ ! -z "$1" ]; then
    fileToOpen=$( fzf -q "$*" )
    vim-if-defined $fileToOpen
  else
    fileToOpen=$( fzf )
    vim-if-defined $fileToOpen
  fi
}

vo() {
  fileToOpen=$( fzf -select-1 -f "$*" )
  vim-if-defined $fileToOpen
}

vim-if-defined() {
  [[ ! -z "$1" ]] && /usr/bin/vim $1
}

spawn-postgres() {
  docker run --name $1 -e POSTGRES_PASSWORD=password -d postgres
}

link-to-postgres() {
docker run -ti --link $1:postgres \
  -e 'PGPORT=5432' \
  -e 'PGPASSWORD=password' \
  -e 'PGDATABASE=postgres' \
  -e 'PGUSER=postgres' \
  -e 'PGHOST=postgres' \
  -v "$PWD:/home/svizra" docker.sdlocal.net/svizra/testing
}

to-json() { perl -MJSON -e 'print encode_json({@ARGV})' "$@"; }

include () {
  [[ -f "$1" ]] && source "$1"
}

go-lang() {
docker run --rm -it -v "$PWD:/run/src" amurf/$1-interactive
}

ddigest() {
  docker inspect --format "{{index (.RepoDigests) 0}}" $1
}

docker-perl6() {
docker run -it rakudo-star /bin/bash
}

webval-start() {
docker run -it webval /bin/bash
}

ws-tools() {
docker run --rm -it -v "$PWD:/survey" -e "PERL5LIB=/websurvey/lib" docker.sdlocal.net/websurvey/tools:testing
}

docker-ssh() {
fig exec $1 /bin/bash
}

env-file() {
export $(cat $1 | grep -v ^# | xargs)
}

export DM=svizra

dm() {
  docker-machine "$@" $DM
}

dmup() {
  if ! dm status 2> /dev/null >/dev/null; then
    dm create -d virtualbox
  fi
  dm start
  eval $( dm env )
}

dmport() {
  for port in "$@"; do
    echo "Mapping port $port ..."
    for proto in tcp udp; do
      VBoxManage controlvm $DM natpf1 \
        "$proto-port-$port,$proto,,$port,,$port"
    done
  done

  VBoxManage showvminfo --machinereadable $DM \
    | grep '^Forwarding.*-port-'
}

map2boot2docker() {
  port=$1;
  boot2docker ssh -f -L \*:$port:localhost:$port -N;
}

in-stratperl() {
docker run -ti -w "/tmp" -v "$PWD:/tmp" docker.sdlocal.net/devel/stratperlbase bash
}

maildev-stratperl() {
docker run -ti -v "$PWD:/home/svizra" --link 'maildev:maildev' docker.sdlocal.net/svizra/testing
}

fetchcuse() { curl -s http://developerexcuses.com/ | perl -ne '/center.*nofollow.*?>(.*?)<\/a>/ and print "$1\n"'; }

ngoecp() {
  cp $1.yaml ~/src/development/mhc-wa/ngoe/$1-outlet/sessions/
}

uuid() { perl -MSD::RandomToken -E "for ( 1 .. ( '$@' || 10 ) ) { say SD::RandomToken->new }"; }

tt22() { perl -MTemplate -E 'Template->new->process(\*DATA, require $ARGV[0])' "$@" ; }
tt() { perl -MTemplate -E "Template->new->process(\'$@', undef, \$out); say $out"; }
tmouse() { for i in resize-pane select-pane select-window; do tmux set mouse-$i $1; done; }

alias profile='source ~/.bashrc'

export PKG_CONFIG_PATH=~/src/game/protocol_buffers/
export HISTIGNORE="&:[bf]g:exit"
export PERL_CPANM_OPT="--sudo"

### Functions ###

yamlxsdump() {
  perl -MData::Dumper::Concise -MYAML::XS -e \
    'print qq("$_" =>\n), Dumper(YAML::XS::LoadFile($_)) for @ARGV' $@
}

yamldump() {
  perl -MData::Dumper::Concise -MYAML -e \
    'print qq("$_" =>\n), Dumper(YAML::LoadFile($_)) for @ARGV' $@
}


### functions ###
yaml2csv() { perl -MYAML::XS -MText::CSV::Slurp -0e 'print Text::CSV::Slurp->new->create(input => Load(<>))'; }

leak() { perl -ple 'print STDERR'; }

### Aliases ###
alias love="/Applications/love.app/Contents/MacOS/love"

alias RM='rm -rf'
alias vi='vim'


alias ssh="ssh -A"
alias tmux_websurvey='tmuxinator start websurvey-setup'
alias footytips='ssh ashpe@173.231.53.150'
alias homepc='ssh ashpe@203.132.88.127'
alias ll='ls -l -G'
alias ls='ls -G'
alias la='ls -la -G'
alias RM='rm -rf'
alias perlsw='perl -Mstrict -Mwarnings'
alias perldd='perl -MData::Dumper'
alias perlxxx='perl -MXXX'
alias GETf='GET -UseS'
alias POSTf='POST -UseS'
alias HEADf='HEAD -UseS'
alias i=clear
alias scpresume="rsync --partial --progress --rsh=ssh"
alias v='vim'
alias vi='vim'
alias im='vim'
alias :e='vim'

alias ..='cd ..'
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias ..6='cd ../../../../../../..'
alias ..7='cd ../../../../../../../..'
alias ..8='cd ../../../../../../../../..'
alias ..9='cd ../../../../../../../../../..'

alias gst='git status'
alias gbr='git branch'
alias gd='git diff'
alias gdp='gd | vim -'
alias gdc='git diff --cached'
alias gdcp='gdc | vim -'
alias ga='git add'
alias gau='git add -u'
alias gco='git checkout'
alias gci='git commit -v'
alias gcim='git commit -v -m'
alias gcia='git commit -v -a'
alias gciam='git commit -v -a -m'
alias gl='git log'
alias glol='git log --pretty=oneline'
alias glop='git log -p -1'
alias guppy='gup && gpu'
alias sup='git stash && gup && git stash pop'
alias suppy='git stash && gup && gpu && git stash pop'
alias gls='git ls-files --exclude-standard'
alias gcp='git cherry-pick -x'
alias grh='git reset --hard HEAD'
alias gundo='git reset HEAD^'
alias gsr='git svn rebase'
alias gsdc='git svn dcommit'
alias git-merge-stash='git cherry-pick -n -m1 -Xtheirs stash'
