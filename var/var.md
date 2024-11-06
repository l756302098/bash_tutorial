# Bash变量
Bash变量分为环境变量和自定义变量两类。

## 介绍
### 环境变量
环境变量是Bash环境自带的变量，进入Shell时已经定义好可以直接使用，他们通常时系统自定义好的，也可以由用户从父Shell传入子Shell。  
env和printenv命令可以显示所有的环境变量。
``` shell
env
printenv
```
下面是一些常用的环境变量。
- BASHPID：Bash进程的ID。
- BASHOPTS：当前Shell的参数，可以用shopt命令修改。
- EDITOR：默认的文本编辑器。
- HOME：当前用户的主目录。
- HOST：当前主机的名称。
- LANG：字符集及语言编码。
- PATH：由冒号分开的目录列表，当输入可执行程序后，会搜索这个目录列表。
- USER：当前用户的用户名。
- UID：当前用户的ID。
- TERM：终端类型名。
``` shell
echo $HOME
echo $HOST
echo $LANG
echo $PATH
echo $USER
echo $UID
echo $TERM
```
### 自定义变量
自定义变量是用户当前Shell里面自定义的变量，仅在当前Shell可用，
一旦退出当前Shell变量就不存在了。
set 命令可以显示所有变量以及所有Bash函数。
``` shell
set
```
## 创建变量
用户创建变量时，变量名必须遵守下面的规则。
- 字母、数字和下划线字符组成。
- 第一个字符必须是一个字符或一个下划线，不能是数字。
- 不允许出现空格和标点符号。
变量声明的语法如下。
``` shell
varialbe=value
```
上面的命令中，等号左边是变量名，右边是变量。注意，等号两边不能有空格。
如果变量的值包含空格，则必须将值放到引号中。
``` shell
myvar="hello world"
```
Bash没有数据类型的概念，所有的变量都是字符串。
下面是一些自定义变量的例子。
``` shell
a=z
b="a string"
c="a string and $b"
d="\t\ta string\n"
e=$(ls -l a.txt)
f=$((5 * 7))
```
变量可以重复赋值，后面的赋值会覆盖前面的赋值。
``` shell
foo=1
foo=2
echo $foo
```
如果同一行定义多个变量，必须使用分号（；）分隔。
``` shell
foo=1;bar=2
```
## 读取变量
读取变量的时候直接在变量前加上$就可以了。
``` shell
echo $foo
echo $fff
```
如果变量不存在，Bash不会报错而是输出空字符。
由于$在Bash中有特殊含义，把它当做美元符号使用时一定要小心使用。
``` shell
echo The total is $100.00
echo The total is \$100.00
```
读取变量的时候，也可以使用花括号{}，比如$foo 写成${foo}。
``` shell
echo $foo
echo ${foo}
```
如果变量的值本身也是变量，可以使用${!varname}的语法，读取最终的值。
``` shell
myvar=USER
echo ${!myvar}
```
如果变量包含连续的空格（制表符或换行符），最好放在双引号中。
``` shell
a="1 2    3"
echo $a
echo "$a"
```
## 删除变量
unset 命令用来删除一个变量

``` shell
unset foo
echo $foo
```
因为Bash中不存在的变量一律为空字符，所以unset即使删除了变量，还是可以读取变量。
所以，删除一个变量也可以将这个变量设置成空字符。
``` shell
foo=1
foo=''
echo $foo
```
## 输出变量，export
用户创建的变量金科用于当前Shell，子Shell读取不到父Shell定义的变量。
为了把变量传递给子Shell，需要使用export命令。这样输出的变量，对于子Shell来说
就是环境变量。
``` shell
NAME=foo
export NAME
# 等价
export NAME=foo
```
子SHell如果修改集成的变量，不会影响父Shell。

``` shell
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
```
## 特殊变量
Bash提供了一些特殊的变量，这些变量的值由Shell提供，用户不能进行复制。
### $?
$?为上一个命令的退出码，用来判断上一个命令是否执行成功。返回值是0表示上一个
命令执行成功，否则表示上一个命令失败。  
``` shell
echo $?
ls doe
echo $?
```
### $$
表示当前Shell的进程ID。  
这个变量可以用来命令临时文件。  
``` shell
echo $$
LOGFILE=/tmp/output_log.$$
```
### $_
表示上一个命令的最后一个参数
``` shell
grep dictionary /usr/share/dict/words
echo $_
```
### $!
表示为最近一个后台执行的异步命令的进程ID。
``` shell
chrome &
echo $!
```
### $0
表示当前Shell的名称。
``` shell
echo $0
```
### $-
表示当前Shell的启动参数。
``` shell
echo $-
```
### $#
表示当前Shell的参数数量。
``` shell
echo $#
```
### $@
表示当前Shell的参数值。
``` shell
echo $@
```
## 变量的默认值
Bash提供了四种特殊语法，跟变量的默认值有关，目的是保证变量不为空。
``` shell
${varname:-word}
echo ${count:-0}
```
上面语法的含义是，如果变量varname存在且不为空则返回它的值，否则返回word。  
它的目的是返回一个默认值。
=
``` shell
${varname:=word}
echo ${count:=0}
```
上面语法的含义是，如果变量varname存在且不为空则返回它的值，否则将它设为word并返回word。  
它的目的是设置一个默认值。
``` shell
${varname:+word}
echo ${count:+0}
echo ${count:+1}
```
上面语法的含义是，如果变量varname存在且不为空则返回它的值，否则返回空值。  
它的目的是测试变量是否存在，比如${count:+1}表示变量count存在时返回1，否则返回空值。
``` shell
${varname:?message}
echo ${var:?1}
```
上面语法的含义是，如果变量varname存在且不为空则返回它的值，否则打印bash: varname: message，
并且中断Shell的执行。  
它的目的是防止变量未定义，比如${count:?"undefined!"}表示变量count未定义就中断执行，并且返回bash: count: undefined!

上面四种语法如果在脚本中使用，变量名的部分可以用数字1到9表示脚本的参数。 
``` shell 
${varname:?message}
filename=${1:?"filename missing."}
```
上面的代码表示1表示脚本的第一个参数，如果该参数不存在，就退出脚本并报错。
## declare 命令
declare命令可以声明一些特殊类型的变量，为变量设置一些限制，比如声明只读类型的变量和整数类型的变量。
它的语法形式如下:
``` shell 
declare OPTION VARIABLE=value
```
declare命令的主要参数（OPTION）如下:
- -a :声明数组变量。
- -f :声明所有函数定义。
- -F :声明所有函数名。
- -i :声明整数变量。
- -l :声明变量为小写字母。
- -p :声明变量信息。
- -r :声明只读变量。
- -u :声明变量为大写字母。
- -x :该变量输出为环境变量。

declare 命令如果用在函数中，声明的变量只在函数内部有效，等同于local命令。  
不带任何参数是，declare命令输出当前环境的所有变量，包括函数在内，等同于不带内核参数的set命令。
### -i 参数
-i 参数声明整数变量以后，可以直接进行整数运算。
``` shell 
declare -i val1=1 val2=2
declare -i result
result=val1*val2
echo $result
```
上面的例子中，如果变量result不声明为整数，val1*val2会被当做字面量，不会进行整数运算。
另外，val1和val2不需要声明为整数，只需要将result声明为整数它的赋值会自动解释为整数运算。
``` shell 
val3=1;val4=3
declare -i result
result=val3*val4
echo $result
```
注意，一个声明为整数的变量，依旧可以被改写为字符串。  
### -x 参数
-x 参数等同于export命令，可以输出一个变量为子Shell的环境变量。  
``` shell 
declare -x foo
foo=hello
#进入子bash
bash
echo $foo
#等价
export foo
```
### -r 参数
-x 参数可以声明只读变量，无法改变变量值，也不能unset变量。
``` shell 
declare -r bar=1
bar=2
echo $?
unset bar
echo $?
```
### -x 参数
-x 参数等同于export命令，可以输出一个变量为子Shell的环境变量。  
``` shell 
declare -x foo
foo=hello
#进入子bash
bash
echo $foo
#等价
export foo
```
### -u 参数
-u 参数声明变量为大写字母，可以自动把变量转成大写字母。
``` shell 
declare -u foo
foo=upper
echo $foo
```
### -l 参数
-l 参数声明变量为小写字母，可以自动把变量转成小写字母。
``` shell 
declare -l bar
bar=LOWER
echo $bar
```
### -p 参数
-p 参数输出变量信息。对于不存在的变量，输出not found
``` shell 
bar=LOWER
declare -p bar
```
### -f 参数
-f 参数输出当前环境的所有函数，包括它的定义。
``` shell 
declare -f
```
### -F 参数
-F 参数输出当前环境的所有函数名。
``` shell 
declare -F
```
## readonly 命令
readonly命令等同于declare -r，用来声明只读变量，不能改变变量值也不能unset。
它的语法形式如下:
``` shell 
readonly fp=1
fp=3
echo $?
```
## let 命令
let命令声明变量时，可以直接执行算数表达式。
它的语法形式如下:
``` shell 
let f=1+2
echo ${f}
```
let命令的参数表达式如果包括空格，就需要使用引号。
``` shell 
let "d = 1 + 4"
echo ${d}
```
let可以同时对多个表达式赋值，赋值表达式之间需要用空格分隔。
``` shell 
let "v1 = 1" "v2 = 2 + 1"
echo $v1,$v2
```