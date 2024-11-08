#!/usr/bin/env bash
echo "全部参数：" $@
echo "命令行参数数量：" $#
echo '$0 = ' $0
echo '$1 = ' $1
echo '$2 = ' $2
echo '$3 = ' $3

for i in "$@";do
    echo $i
done

# echo "一共输入了$#个参数"
# while [ "$1" != "" ]; do
#     echo "剩下 $# 个参数"
#     echo "参数:$1"
#     shift
# done

# while getopts 'lha:' OPTION;do
#     case "$OPTION" in
#         l)
#         echo "linuxconfig"
#         ;;
#         h)
#         echo "h stands for h"
#         ;;
#         a)
#         avalue="$OPTARG"
#         echo "the value provided is $OPTARG"
#         ;;
#         ?)
#         echo "script usage: $(basename $0) [-l] [-h] [-a somevalue]" >&2
#         exit 1
#         ;;
#     esac
# done
# shift "$(($OPTIND - 1))"

# if [ $(id -u) != "0" ]; then
#     echo "根用户才能执行当前脚本"
#     exit 1
# fi

# cd /home/li/works/caffer
# if [ "$?" == "0" ];then
#     rm *
# else
#     echo "无法切换目录！" 1>&2
#     exit 1
# fi

cd /home/li/works/caffer && rm *

cd /home/li/works/caffer || exit 1


# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# alias echo='echo It says: '
# alias egrep='egrep --color=auto'
# alias fgrep='fgrep --color=auto'
# alias grep='grep --color=auto'
# alias l='ls -CF'
# alias la='ls -A'
# alias ll='ls -alF'
# alias ls='ls --color=auto'