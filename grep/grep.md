# grep 命令
grep = global regular expression print
## 介绍
用最简单的术语来说，grep（全局正则表达式打印）将搜索输入文件进行搜索
字符串，并打印与其匹配的行。从文件的第一行开始，grep 将一行复制到
buffer，将其与搜索字符串进行比较，如果比较通过，则将该行打印到
屏幕。 Grep 将重复此过程，直到文件用完行。请注意，这里没有任何地方
grep 进程会存储行、更改行或仅搜索行的一部分。 
## 使用示例
### 数据准备 
准备数据文件，将下列数据粘贴、复制到a.txt中。
``` txt
boot
book
booze
machine
boots
bungie
bark
aardvark
broken$tuff
robots
```
### 简单示例
从文本a.txt中逐行过滤包含boo的字符串。
``` shell
grep boo a.txt
# boot
# book
# booze
# boots
```
### -n 参数
这很好，但是如果您正在使用类似的大型 Fortran 文件，那么它会
如果这些行标识了它们是文件中的哪一行，可能对您更有用
如果您需要在编辑器中打开文件，您可以更轻松地追踪特定字符串
做出一些改变。这可以通过添加 -n 参数来完成：
``` shell
grep -n boo a.txt
# 1:boot
# 2:book
# 3:booze
# 5:boots
```
### -v 参数
另一个有趣的开关是 -v，它将打印负结果。换句话说，grep 将打印
与搜索字符串不匹配的所有行，而不是打印与其匹配的行。在
在下面的情况下，grep 将打印不包含字符串“boo”的每一行，并显示
行号，如上一个示例所示
``` shell
grep -v boo a.txt
# machinmachine
# bungie
# bark
# aardvark
# broken$tuff
# robots
grep -vn boo a.txt
# 4:machine
# 6:bungie
# 7:bark
# 8:aardvark
# 9:broken$tuff
# 10:robots
```
### -c 参数
-c 选项告诉 grep 禁止打印匹配行，并且只显示匹配行的数量与查询匹配的行。例如，下面将打印数字 4，因为有 4
a_file 中出现“boo”
``` shell
grep -c boo a.txt
# 4
```
### -l 参数
-l 选项仅打印查询中具有与搜索匹配的行的文件的文件名
细绳。如果您在多个文件中搜索相同的字符串，这非常有用。像这样
``` shell
grep -l boo *
# a.txt
# grep.md
```
### -i 参数
对于搜索非代码文件更有用的选项是 -i，忽略大小写。该选项将处理
匹配搜索字符串时大小写相同。在下面的示例中，
即使搜索字符串是大写的，包含“boo”的行也会被打印出来。
``` shell
grep -i Boo a.txt
# boot
# book
# booze
# boots
```
### -x 参数
-x 选项仅查找精确匹配。换句话说，以下命令将
什么都没有打印，因为没有任何行只包含模式“boo”
``` shell
grep -x boo a.txt
grep -x boot a.txt
# boot
```
### -A 参数
最后，-A 允许您指定上下文文件的附加行，因此您可以获得搜索字符串加上
附加行数，例如
``` shell
grep -A2 mach a.txt
# machine
# boots
# bungie
grep -A4 mach a.txt
# machine
# boots
# bungie
# bark
# aardvark
```
## 正则表达式
正则表达式是描述文本中复杂模式的一种紧凑方式。使用 grep，您可以
使用它们来搜索模式。其他工具允许您使用正则表达式（“regexps”）来修改
文本以复杂的方式。到目前为止我们使用的普通字符串实际上非常简单
正则表达式。如果您使用“*”或“?”等通配符，您也可能会遇到它们。什么时候
列出文件名等。您可以使用 grep 使用基本正则表达式进行搜索，例如搜索文件
以字母 e 结尾的行：  

``` shell
grep "e$" a.txt
# booze
# machine
# bungie
```
如果您想要更广泛的正则表达式命令，那么您必须使用“grep -E”（也称为
如egrep命令）。例如，正则表达式命令 ?将匹配 1 次或 0 次出现
前一个字符：
``` shell
grep -E "boots?" a.txt
# boot
# boots
```
您还可以使用管道 (|) 组合多个搜索，管道 (|) 表示“或”，因此可以执行以下操作：
``` shell
grep -E "boot|boots" a.txt
# boot
# boots
```
## 特殊字符
如果您要搜索的内容是特殊字符怎么办？如果你想找到所有行
包含美元字符 '$' 那么你不能执行 grep '$' a_file 因为 '$' 将被解释为
相反，您将得到所有以任何内容作为行尾的行，即所有行！这
解决方案是“转义”该符号，因此您可以使用：  

``` shell
grep '\$' a.txt
# broken$tuff
```