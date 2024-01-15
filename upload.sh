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
____

_; magenta __FILE__; _, ='"'; yellow $__FILE__; _, '"'; _.
_; magenta __DIR__; _, ='"'; yellow $__DIR__; _, '"'; _.
____

_; magenta cd; _, ' '; yellow "$__DIR__"; _.;
cd "$__DIR__"

if [ -d ./output_prod/ ];then
    _; magenta rsync; _, ' '; blue '-avr'; _, ' '; _, '"';yellow ./output_prod/; _, '"'; _, ' '; _, '"';yellow s:/var/www/ijortengab.my.id/web/; _, '"'; _.
    rsync -avr "./output_prod/" "s:/var/www/ijortengab.my.id/web/"
fi
if [ -d ./vendor/components/ ];then
    _; magenta rsync; _, ' '; blue '-avr'; _, ' '; _, '"';yellow ./vendor/components/; _, '"'; _, ' '; _, '"';yellow s:/var/www/ijortengab.my.id/web/components/; _, '"'; _.
    rsync -avr "./vendor/components/" "s:/var/www/ijortengab.my.id/web/components/"
fi
