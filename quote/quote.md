# 引号与转义

## 转义（\）
某些字符在Bash里面有特殊的含义（比如$、&、*）。
``` shell
echo $date
echo \$date
echo \
echo \\
```
反斜杠出了用于转义，还可以表示一些不可打印的字符。
- \b :退格
- \n :换行
- \r :回车
- \t :制表符
如果想要在命令行使用这些不可打印的字符，可以把他们放在引号里面，然后用echo
命令的-e参数。
``` shell
echo -e 'a\bb'
echo -e 'a\nb'
echo -e 'a\rb'
echo -e 'a\tb'
```
除此之外还用做换行符

``` shell
cp a.txt \
aa.txt
# 等价
cp a.txt aa.txt
```

## 单引号（’’）
Bash 允许字符串放在单引号或双引号之中加以引用。
单引号用户保留字符的字面含义，各种特殊字符在单引号里面都会变成普通字符。
``` shell
echo '*'

echo $USER
echo '$USER'

echo '$(echo foo)'
```
## 双引号（“”）
双引号比单引号宽松，大部分字符字符在双引号里面都会失去特殊含义，变成普通字符。
但是有三个特殊的字符除外：美元符号（$）、反引号（`）、反斜杠（\）。
这三个字符在双引号中依旧有特殊含义，会被Bash自动扩展。
``` shell
echo "*"

echo $USER
echo '$USER'
echo "$USER"

echo '$(date)'
echo "$(date)"

echo "`date`"
```
## Here文档（<<）
Here 文档是一种输入多行字符串的方法，使用三个小于号（<<<），格式如下：
``` shell
<< token
text
token
```
## Here字符串（<<<）
Here文档还有一个变体叫做Here字符串，使用三个小于号（<<<）
``` shell
cat <<< 'hi hello'
# 等价
echo 'hi hello' | cat

md5sum <<< 'hello world'
# 等价
echo 'hello world' | md5sum
```