#!/bin/bash
env
printenv

echo $HOME
echo $HOST
echo $LANG
echo $PATH
echo $USER
echo $UID
echo $TERM

myvar="hello world"

a=z
b="a string"
c="a string and $b"
d="\t\ta string\n"
e=$(ls -l a.txt)
f=$((5 * 7))

foo=1
foo=2
echo $foo

foo=1;bar=2
echo $foo
echo $fff

echo The total is $100.00
echo The total is \$100.00

echo $foo
echo ${foo}

myvar=USER
echo ${!myvar}

a="1 2    3"
echo $a
echo "$a"

unset foo
echo $foo

foo=1
foo=''
echo $foo

NAME=foo
export NAME
# 等价
export NAME=foo


export NAME=foo
# 新建子Shell
bash
# 读取
echo $NAME
# 修改
NAME=li
# 退出子Shell
exit
# 读取
echo $NAME

echo $?
ls doe
echo $?

echo $$
LOGFILE=/tmp/output_log.$$

grep dictionary /usr/share/dict/words
echo $_

chrome &
echo $!

echo $0
echo $-
echo $#
echo $@

${varname:-word}
echo ${count:-0}

${varname:=word}
echo ${count:=0}

${varname:+word}
echo ${count:+0}
echo ${count:+1}

${varname:?message}
echo ${var:?1}

${varname:?message}
filename=${1:?"filename missing."}

declare -i val1=1 val2=2
declare -i result
result=val1*val2
echo $result

val3=1;val4=3
declare -i result
result=val3*val4
echo $result

declare -x foo
foo=hello
#进入子bash
bash
echo $foo
#等价
export foo

declare -r bar=1
bar=2
echo $?
unset bar
echo $?

declare -x foo
foo=hello
#进入子bash
bash
echo $foo
#等价
export foo

declare -u foo
foo=upper
echo $foo

declare -l bar
bar=LOWER
echo $bar

bar=LOWER
declare -p bar

declare -f

declare -F

readonly fp=1
fp=3
echo $?

let f=1+2
echo ${f}

let "d = 1 + 4"
echo ${d}

let "v1 = 1" "v2 = 2 + 1"
echo $v1,$v2