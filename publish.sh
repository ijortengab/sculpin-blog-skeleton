#!/bin/bash

# Common Functions.
red() { echo -ne "\e[91m" >&2; echo -n "$@" >&2; echo -ne "\e[39m" >&2; }
green() { echo -ne "\e[92m" >&2; echo -n "$@" >&2; echo -ne "\e[39m" >&2; }
yellow() { echo -ne "\e[93m" >&2; echo -n "$@" >&2; echo -ne "\e[39m" >&2; }
blue() { echo -ne "\e[94m" >&2; echo -n "$@" >&2; echo -ne "\e[39m" >&2; }
magenta() { echo -ne "\e[95m" >&2; echo -n "$@" >&2; echo -ne "\e[39m" >&2; }
error() { echo -n "$INDENT" >&2; red "$@" >&2; echo >&2; }
success() { echo -n "$INDENT" >&2; green "$@" >&2; echo >&2; }
chapter() { echo -n "$INDENT" >&2; yellow "$@" >&2; echo >&2; }
title() { echo -n "$INDENT" >&2; blue "$@" >&2; echo >&2; }
code() { echo -n "$INDENT" >&2; magenta "$@" >&2; echo >&2; }
x() { echo >&2; exit 1; }
e() { echo -n "$INDENT" >&2; echo "$@" >&2; }
_() { echo -n "$INDENT" >&2; echo -n "$@" >&2; }
_,() { echo -n "$@" >&2; }
_.() { echo >&2; }
__() { echo -n "$INDENT" >&2; echo -n '    ' >&2; [ -n "$1" ] && echo "$@" >&2 || echo -n  >&2; }
____() { echo >&2; [ -n "$delay" ] && sleep "$delay"; }

# Functions.
resolve_relative_path() {
    if [ -d "$1" ];then
        cd "$1" || return 1
        pwd
    elif [ -e "$1" ];then
        if [ ! "${1%/*}" = "$1" ]; then
            cd "${1%/*}" || return 1
        fi
        echo "$(pwd)/${1##*/}"
    else
        return 1
    fi
}

__FILE__=$(resolve_relative_path "$0")
__DIR__=$(dirname "$__FILE__")

exit_trap () {
    ____

    blue '# 'Restore file submodule; _.
    ____

    if [ -f "$__DIR__"/.git/modules/source/_posts/.git ];then
        _; magenta mv' '; yellow .git/modules/source/_posts/.git; _, ' '; blue -t; _, ' '; yellow source/_posts; _, ' '; _.
        mv .git/modules/source/_posts/.git -t source/_posts
    fi
    if [ -f "$__DIR__"/.git/modules/source/_posts/.gitignore ];then
        _; magenta mv; _, ' '; yellow .git/modules/source/_posts/.gitignore; _, ' '; blue -t; _, ' '; yellow source/_posts; _, ' '; _.
        mv .git/modules/source/_posts/.gitignore -t source/_posts
    fi
    if [ -L "$__DIR__"/output_prod/components ];then
        _; magenta rm; _, ' '; yellow output_prod/components; _.
        rm output_prod/components
    fi
}

trap exit_trap EXIT
____

_; magenta __FILE__; _, ='"'; yellow $__FILE__; _, '"'; _.
_; magenta __DIR__; _, ='"'; yellow $__DIR__; _, '"'; _.
____

_; blue '# 'Selamatkan dulu file submodule; _.
____

_; magenta cd' '; yellow "$__DIR__"; _.;
cd "$__DIR__"
if [ -f "$__DIR__"/source/_posts/.git ];then
    _; magenta mv; _, ' '; yellow source/_posts/.git; _, ' '; blue -t; _, ' '; yellow .git/modules/source/_posts/; _.
    mv source/_posts/.git -t .git/modules/source/_posts/
fi

if [ -f "$__DIR__"/source/_posts/.gitignore ];then
    _; magenta mv; _, ' '; yellow source/_posts/.gitignore; _, ' '; blue -t; _, ' '; yellow .git/modules/source/_posts/; _.
    mv source/_posts/.gitignore -t .git/modules/source/_posts/
fi
____

if [ -d "$__DIR__"/vendor/components ];then
    _; blue '# 'Buat symbolic link direktori '`'components'`'; _.
    ____

    _; magenta mkdir; _, ' '; blue -p; _, ' '; yellow output_prod; _.
    mkdir -p output_prod
    _; magenta cd; _, ' '; yellow output_prod; _.
    cd output_prod
    _; magenta ln; _, ' '; blue -sf; _, ' '; yellow ../vendor/components; _.
    ln -sf ../vendor/components
    _; magenta cd; _, ' '; yellow -; _, ' > /dev/null'; _.
    cd - > /dev/null
    ____
fi

if [ -f "$__DIR__"/vendor/bin/sculpin ];then
    _; blue '# 'Sculpin generate; _.
    ____
    _; magenta php; _, ' '; yellow vendor/bin/sculpin; _, ' '; magenta generate; _, ' '; blue --server; _, ' '; blue --watch; _, ' '; blue --env; _, =; yellow prod; _.
    php vendor/bin/sculpin generate --server --watch --env=prod
fi
