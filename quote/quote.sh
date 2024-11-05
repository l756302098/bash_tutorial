#!/bin/bash
echo $date
echo \$date
echo \
echo \\

echo -e 'a\bb'
echo -e 'a\nb'
echo -e 'a\rb'
echo -e 'a\tb'

cp a.txt \
aa.txt
# 等价
cp a.txt aa.txt

echo '*'

echo $USER
echo '$USER'

echo '$(echo foo)'

echo "*"

echo $USER
echo '$USER'
echo "$USER"

echo '$(date)'
echo "$(date)"

echo "`date`"

cat <<< 'hi hello'
# 等价
echo 'hi hello' | cat

md5sum <<< 'hello world'
# 等价
echo 'hello world' | md5sum