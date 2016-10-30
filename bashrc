source ~/.git-completion.sh
alias fig=docker-compose
export PERL_BADLANG="0"
export PAGER=less
export PATH=~/.cabal/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/Users/ash/bin:/sbin:/usr/X11/bin:/usr/local/share/npm/lib/node_modules/uglify-js/bin:~/.npm/less/1.3.3/package/bin:$(brew --prefix ruby)/bin:$PATH
export EDITOR=/usr/bin/vim

PS1='\[\033[1;31m\]\u@\h\[\033[1;31m\]:\[\033[00m\]\W\[\033[38;5;55m\]$(__git_ps1 " [%s] ")\[\033[1;31m\]\$ \[\033[00m\] '


spawn-postgres() {
    docker run --network=arthritisbjmds_bjmds --name $1 -e POSTGRES_PASSWORD=password -d postgres
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
    docker run -ti -v "$PWD:/home/svizra" docker.sdlocal.net/svizra/testing
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
perlat() { for i in $@; do PATHSEP=: prepend_envvar_at PERL5LIB $i; done; }

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
alias http="plackup -MPlack::App::Directory -e 'Plack::App::Directory->new({ root => \$ENV{PWD} })->to_app;'"
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


source ~/.uselect-rc
source ~/perl5/perlbrew/etc/bashrc
