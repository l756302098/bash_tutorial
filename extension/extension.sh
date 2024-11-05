#!/bin/bash
set -o noglob
set -f

set +o noglob
set +f

echo ~
cd ~/workspaces/
echo ~li
echo ~user

ls ???.log
ls ???.*

ls [ab].txt
ls [cd].txt
ls [a-c].txt
ls [!1-3].txt

#匹配所有大写字母开头的文件
echo [[:upper:]]*
#匹配所有数字开头的文件
echo [[:digit:]]*
#匹配所有非数字开头的文件
echo [![:digit:]]*

echo {1,2,3}
echo d{a,,b,c,d,e}
echo Frone-{A,B,C}-Back
ls {a,b,c}.txt

echo {1,2}
echo {1, 2}
echo a.log{,.bak}
echo a.log{.bak,}
echo {j{p,pe}g,png}

echo /bin/{cat,b*}
# 等价
echo /bin/cat;echo /bin/b*

echo [ab].txt
echo {a,b}.txt

echo {a..z}
echo {1..9}

echo {z..a}
echo {9..1}

echo {201..209}-{01..09}
echo {a..c}{1..9}

echo {01..5}
echo {001..9}
echo {0..9..2}

echo $SHELL
echo ${SHELL}
echo ${!S*}

echo date
echo $(date)

echo $((2+2))