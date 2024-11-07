# Bash的目录堆栈
为了方便用户在不同目录之间切换，Bash提供了目录堆栈功能。
## cd -
Bash可以记忆用户进入过的目录。默认情况下，值记忆前一次所在的目录，
cd - 命令可以返回上一次的目录。
``` shell
cd workspaces/
cd -
```
## pushd，popd
如果希望记忆多重目录，可以使用pushd和popd命令，它们用来操作目录堆栈。
pushd命令的用法类似cd命令，可以进入指定的目录。
``` shell
pushd workspaces/
```
上面命令会进入目录workspaces，并将该目录放入目录堆栈。  
第一次使用pushd命令时，会将当前目录先放入堆栈，然后将所要进入的目录也放入堆栈，位置在前一个记录的上方。  
以后每次pushd命令，都会将所要进入的目录放到堆栈的顶部。  
popd命令不带有参数时，会移除堆栈顶部记录，并进入新的栈顶目录。
``` shell
pushd  workspaces/
pushd caffer/
popd
popd
```
还可以带参数运行。
### -n 参数
``` shell
popd -n
```
上面的命令仅删除堆栈顶部的记录，不改变目录，执行完后还停留在当前目录。
``` shell
pushd  workspaces/
pushd caffer/
popd -n
popd
```
### 整数参数
这两个命令还可以接受一个整数作为参数，该整数表示堆栈中指定位置的记录（从0开始）。
pushd命令会把这条记录移动到栈顶同时切换到该目录；popd则从堆栈中删除这条记录，不会切换目录。
``` shell
pushd  workspaces/
pushd caffer/
pushd abby_demo/
pushd +2
pushd -2
```
## dirs命令
dirs命令可以显示目录堆栈的内容，一般用来查看pushd和pod操作后的结果。
``` shell
pushd  workspaces/
pushd caffer/
pushd abby_demo/
dirs
#~/workspaces/caffer/abby_demo ~/workspaces/caffer ~/workspaces ~
pushd +2
dirs
#~/workspaces ~ ~/workspaces/caffer/abby_demo ~/workspaces/caffer
```
该命令会输出一行文本，列出目录堆栈，目录之间使用空格分隔。
栈顶在最左边，栈底在最右边。  
它有下列参数：  
- -c:清空目录栈。
- -l:用户主目录不显示波浪号前缀，而是打印完整目录。
- -p:每行打印一个目录。
- -v:每行打印一个目录并显示位置编号，栈顶为0一次递增。
- +N:N为整数表示从栈顶算起的第N个目录，从零开始。
- -N:N为整数表示从栈底算起的第N个目录，从零开始。

