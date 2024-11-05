# Bash的模式扩展

## 简介  
Shell 接收到用户输入的命令后，会根据空格将用户的输入拆分成一个个的词元（token），然后shell会扩展里面的特殊字符，
扩展完成后才会调用响应的命令。  
这种特殊字符的扩展称为模式扩展（globbing），其中有些用到通配符，又称为通配符扩展。
Bash一共提供了8中扩展。
- 波浪线（~）扩展
- 问号（？）扩展
- 星号（*）扩展
- 方括号（[]）扩展
- 大括号（{}）扩展
- 变量扩展
- 子命令扩展
- 算术扩展  

Bash先进行扩展再执行命令，Bash允许用户关闭扩展。
``` shell
set -o noglob
set -f
```
打开扩展  
``` shell
set +o noglob
set +f
```
## 波浪线（~）扩展
波浪线~会自动扩展成当前用户的主目录。
``` shell
echo ~
cd ~/workspaces/
```
~user会自动扩展为用户user的主目录。
``` shell
echo ~li
```
如果~user的user是不存在的用户名，则波浪号不会扩展。
``` shell
echo ~user
```
## 问号（？）扩展
？字符代表文件路径里面包含的任意单个字符，不包含空格符。比如Data？？？匹配所有Data后面跟着三个字符的文件名。
``` shell
ls ???.log
```
## 星号（*）扩展
*字符代表文件路径里面的任意数量的任意字符，包含零个字符。
``` shell
ls ???.*
```
## 方括号（[]）扩展
### [xxx]扩展
方括号的扩展形式是[...]，只有文件存在的前提下才会扩展，如果文件不存在就会原样输出。
匹配括号中的任意一个字符。
``` shell
ls [ab].txt
ls [cd].txt
```
### [start-end]扩展
``` shell
ls [a-c].txt
```
下面是一些常用的例子：    

- [a-z] :所有小写字母  
- [a-zA-Z] :所有小写字母与大写字母  
- [a-zA-Z0-9] :所有小写字母、大写字母与数字  
- [abc]*:以a、b、c字符之一开头的文件名  
- program.[oc]:文件program.c与program.o
- BACKUP.[0-9][0-9][0-9]:所有以BACKUP开头，后面是三个数字的文件名。

``` shell
ls [!1-3].txt
```
上面的代码中[!1-3]表示排除1、2、3  
### [[:class:]]扩展
[[:class:]]表示一个字符类，扩展成某一类特定字符中的一个。
常用的字符如下：
- [[:alnum:]] :匹配任意英文字母与数字
- [[:alpha:]] :匹配任意英文字母
- [[:digit:]] :任意数字
- [[:graph:]] :A-Z、a-z、0-9和标点符号
- [[:lower:]] :匹配任意小写字母a-z
- [[:upper:]] :匹配任意大写字母A-Z
- [[:xdigit:]] :16进制字符
- [[:blank:]] :空格和Tab键
- [[:cntrl:]] :ASCII码0-31中不可打印的字符
- [[:print:]] :ASCII码32-127中可打印的字符
- [[:punct:]] :标点符号，ASCII码127-255中可打印的字符
``` shell
#匹配所有大写字母开头的文件
echo [[:upper:]]*
#匹配所有数字开头的文件
echo [[:digit:]]*
#匹配所有非数字开头的文件
echo [![:digit:]]*
```
## 大括号（{}）扩展
### {a,b,c}扩展
大括号扩展{...}表示分别扩展成大括号中的所有值，各个值之间采用逗号分隔。比如{1，2，3}扩展成1、2、3。
``` shell
echo {1,2,3}
echo d{a,,b,c,d,e}
echo Frone-{A,B,C}-Back
ls {a,b,c}.txt
```
另一个需要注意的地方是，大括号内部的逗号前后不能有空格，否则大括号扩展失效。
``` shell
echo {1,2}
echo {1, 2}
```
逗号前面或者后面可以没有值，表示扩展的为空。
``` shell
echo a.log{,.bak}
echo a.log{.bak,}
```
大括号可以嵌套。
``` shell
echo {j{p,pe}g,png}
```
大括号也可以与其他模式联用，并且总是先于其他模式进行扩展。
``` shell
echo /bin/{cat,b*}
# 等价
echo /bin/cat;echo /bin/b*
```
区别
``` shell
echo [ab].txt
echo {a,b}.txt
```
### {start..end}扩展
大括号扩展有一个简写形式{start...end}，表示扩展成一个连续的序列。
比如{a..z}可以扩展为26个小写字母。
``` shell
echo {a..z}
echo {1..9}
```
这种简写形式支持逆序。
``` shell
echo {z..a}
echo {9..1}
```
嵌套形式
``` shell
echo {201..209}-{01..09}
echo {a..c}{1..9
```
如果整数前面有0，扩展出的每一项都会有0。
``` shell
echo {01..5}
echo {001..9}
```
### {start..end..step}扩展
这种形式通过step来指定步长。
``` shell
echo {0..9..2}
```
## 变量扩展
Bash将美元符号$开头的词元作为变量，将其扩展为变量值。
``` shell
echo $SHELL
echo ${SHELL}
```
${!string*}或${!string@}返回所有匹配给定字符串string的变量名。
``` shell
echo ${!S*}
```
上面的例子中，${!S*}扩展成所有以S开头的变量名。

## 子命令扩展
$(...)可以扩展成另一个命令的运行结果，该命令的所有输出都会作为返回值。
``` shell
echo date
echo $(date)
```
另一种等价的写法是把子命令放在反引号之内。
``` shell
echo `date`
```
## 算术扩展
$((...))可以扩展证整数运算的结果
``` shell
echo $((2+2))
```