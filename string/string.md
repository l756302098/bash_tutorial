# string的基本语法

## 字符串的长度
获取字符串的长度如下,格式如下：
``` shell
${#varname}
```
下面是一个例子。
``` shell
myPath=$HOME
echo ${#myPath}
```
## 子字符串
字符串提取子串格式如下：
``` shell
${varname:offset:length}
```
上面语法的含义是返回变量$varname的子字符串，从位置offset开始（从0开始计算）长度为length。  
``` shell
dstring=frontfooman
echo ${dstring:5:3}
```
如果省略length，则从位置offset开始，已知返回到字符串的结尾。
``` shell
dstring=frontfooman
echo ${dstring:5}
```
如果offset为负值表示从字符串的末尾开始计算。
注意，负数前面必须有一个空格，以防止与${varname:-word}的变量设置默认值混淆。
这是还可以指定length，length可以是正值也可以是负值。（负值不能超过offset的长度）
当length为负数时不再表示长度，表示的截止位置。
``` shell
dstring=frontfooman
echo ${dstring: -5}
echo ${dstring: -5:2}
echo ${dstring: -5:-2}
```
## 搜索和替换
Bash提供了字符串搜索和替换的多种方法。
### 字符串头部模式匹配
一下两种语法可以检查字符串开头，是否匹配给定的模式。如果匹配成功，就删除匹配的部分返回剩下的部分，
原始变量不会发生改变。
``` shell
# 如果 pattern 匹配变量 variable 的开头，
# 删除最短匹配（非贪婪匹配）的部分，返回剩余部分
${variable#pattern}

# 如果 pattern 匹配变量 variable 的开头，
# 删除最长匹配（贪婪匹配）的部分，返回剩余部分
${variable##pattern}
```
上面两种语法会删除变量字符串开头匹配的部分，返回剩下的部分。
区别是一个是最短匹配另一个是最长匹配。
匹配模式pattern可以使用*、?、[]等通配符。
``` shell
myPath=/home/li/cam/book/long.file.name
echo ${myPath#/*/}
echo ${myPath##/*/}
```
上面的例子中匹配的模式是/*/，其中*可以匹配任意数量的字符，
所以最短匹配时/home/，最长匹配是/home/li/cam/book/。
下面写法可以删除文件路径的目录部分，只留下文件名。
``` shell
myPath=/home/li/cam/book/long.file.name
echo ${myPath##*/}
```
另外一个例子。
``` shell
phone=111-222-333
echo ${phone#*-}
echo ${phone##*-}
```
如果匹配不成功就返回原始字符串。
``` shell
phone=111-222-333
echo ${phone#444}
```
如果要将头部匹配的部分替换成其他内容，格式如下：
``` shell
${varname/#pattern/string}
foo=JPG.png
echo ${foo/#JPG/123}
```
### 字符串尾部模式匹配
一下两种语法可以检查字符串结尾，是否匹配给定的模式。如果匹配成功，就删除匹配的部分返回剩下的部分，
原始变量不会发生改变。
``` shell
# 如果 pattern 匹配变量 variable 的结尾，
# 删除最短匹配（非贪婪匹配）的部分，返回剩余部分
${variable%pattern}

# 如果 pattern 匹配变量 variable 的结尾，
# 删除最长匹配（贪婪匹配）的部分，返回剩余部分
${variable%%pattern}
```
上面两种语法会删除变量字符串开头匹配的部分，返回剩下的部分。
区别是一个是最短匹配另一个是最长匹配。
匹配模式pattern可以使用*、?、[]等通配符。
下面写法可以删除路径的文件名部分，只留下路径。
``` shell
myPath=/home/li/cam/book/long.file.name
echo ${myPath%.*}
echo ${myPath%%.*}
```
下面写法可以删除路径的文件名部分，只留下部分。
``` shell
myPath=/home/li/cam/book/long.file.name
echo ${myPath%/*}
```
下面的写法可以替换后缀保留文件名不变。
``` shell
file=123.png
echo ${file%.png}.jpg
```
下面是另外一个例子。
``` shell
phone="111-222-333"
echo ${phone%-*}
echo ${phone%%-*}
```
如果匹配不成功返回原始字符串。
### 任意位置的模式匹配
一下两种语法可以检查字符串内部，是否匹配给定的模式。如果匹配成功，就删除匹配的部分返回剩下的部分，
原始变量不会发生改变。
``` shell
# 如果 pattern 匹配变量 variable 的一部分，
# 最长匹配（贪婪匹配）的那部分被 string 替换，但仅替换第一个匹配
${variable/pattern/string}

# 如果 pattern 匹配变量 variable 的一部分，
# 最长匹配（贪婪匹配）的那部分被 string 替换，所有匹配都替换
${variable//pattern/string}
```
上面两种语法都是最长匹配（贪婪匹配）下的替换，区别是前一个语法仅仅替换第一个匹配，
后一个语法替换所有匹配。
``` shell
path=/home/li/foo/foo.name
echo ${path/foo/bar}
echo ${path//foo/bar}
```
下面的命令将分割符从:替换成\n.
``` shell
echo -e ${PATH//:/'\n'}
```
模式部分可以使用通配符。
``` shell
phone="111-222-333"
echo ${phone/1-2/-}
```
如果省略了string部分，那么相当于匹配的部分替换成空字符串。

``` shell
phone="111-222-333"
echo ${phone/1-2/}

path=/home/li/book/cook/cook.name
echo ${path/.*/}
```
这个语法还有另种扩展形式。
``` shell
# 模式必须出现在字符串的开头
${variable/#pattern/string}

# 模式必须出现在字符串的结尾
${variable/%pattern/string}
```
示例如下：

``` shell
path=/home/li/book/cook/cook.name
echo ${path/%.*/hello}
echo ${path/%.*/.hello}
```
## 改变大小写
下面的语法可以改变变量的大小写。
``` shell
# 转为大写
${varname^^}
# 转为小写
${varname,,}
```
``` shell
foo=hello
echo ${foo^^}

bar=WORLD
echo ${bar,,}
```