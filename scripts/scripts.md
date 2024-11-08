# Bash脚本入门
脚本（script）就是包含一系列命令的一个文本文件。Shell读取这个文件，一次执行里面的所有命令，
就好像这些命令直接输入到命令行一样。所有能够在命令行完成的任务都能够在脚本完成。
脚本的好处是可以重复使用，也可以指定在特定场合自动调用，比如系统启动或关闭时自动执行脚本。
## Shebang行
脚本的第一行通常是解释器，即这个脚本必须通过什么解释器执行。这一行以#!字符开头，
这个字符称为Shebang，所以这一行就叫做Shebang行。
#! 后面就是脚本解释器的位置，Bash脚本的解释器一般是#!/bin/bash或#!/bin/sh。
``` shell
#!/bin/bash
#或
#!/bin/sh
```
#!与脚本解释器之间有没有空格都可以。  
如果Bash解释器不放在目录/bin，脚本就无法执行。为了保险起见可以写成下面的形式。
``` shell
#!/usr/bin/env bash
```
上面命令使用env命令，返回Bash可执行文件的位置。env命令的详细介绍，请看后文。  
Shebang行不是必须的，但是建议加上。如果缺少这行就需要手动将脚本传给解释器。  
举例来说，脚本是scripts.sh，有Shebang行的时候，可以直接执行。
``` shell
./script.sh
```
如果没有Shebanghang，就只能手动将脚本传给解释器执行。
``` shell
/bin/sh ./script.sh
# 或
/bin/bash ./script.sh
```
## 执行权限和路径
前面说过只要制定了Shebang行的脚步，可以直接执行。但是有一个前提，就是脚本需要有执行权限。
可以使用下面的命令，赋予脚本执行权限。
``` shell
chmod +x script.sh
chmod +rx script.sh
chmod 755 script.sh
```
脚本的权限755表示拥有者所有权限，其他人有读和执行权限。
出了执行权限，脚本调用时一般还需要指定路径（比如path/script.sh）。如果将脚本放在环境变量$PATH指定的目录中，
就不需要指定目录了。因为Bash会自动到这些目录中，寻找是否存在同名的可执行文件。  
建议在主目录下建一个~/bin子目录下，专门存放可执行脚本，然后把~/bin加入$PATH。
``` shell
export PATH=$PATH:~/bin
```
以后不管在什么目录，直接输入脚本名称就可以执行。
## env 命令
env命令总是指向/usr/bin/env文件，或者说这个二进制文件总是在目录/usr/bin。  
#!/usr/bin/env NAME这个语法的意思是，让Shell查找$PATH环境变量里面第一个匹配的NAME。
如果你不知道某个命令的具体路径，或者希望兼容其他机器可以这样写。
``` shell
#!/usr/bin/env bash
```
env命令的参数如下:
- -i:--ignore-environment：不带环境变量启动。
- -u:--unset=NAME：从环境变量中删除一个变量。
- --help:显示帮助。
- --version:输出版本信息。

下面是一个例子，新建一个不带任何环境变量的Shell。
``` shell
env -i /bin/sh
env --help
env --version
```
## 注释
Bash脚本中#表示注释，可以放在行首也可以放在行尾。
``` shell
# 本行是注释
echo 'Hello World!'

echo 'Hello World!' # 井号后面的部分也是注释
```
## 脚本参数
调用脚本的时候，脚本文件名的后面可以带参数。
``` shell
# 本行是注释
script.sh word1 word2 word3
```
上面的例子中，script.sh是一个脚本文件，word1、word2和word3是三个参数。  
脚本文件内部，可以使用特殊的变量引用这些参数。  
- $0 :脚本的文件名，即script.sh。
- $1-$9 :对应脚本的第一个参数到第九个参数。
- $# :参数的总数。
- $@ :全部的参数，参数之间使用空格分隔。
- $* :全部的参数，参数之间使用变量$IFS值的第一个字符分隔，默认是空格，也可以自定义。

如果脚本的参数多余9个，那么第10个参数可以用${10}的形式引用，以此类推。  
注意，如果命令时command -o foo bar，那么-o是$1，foo是$2，bar是$3。
下面是一个脚本内部读取命令行参数的例子。

``` shell
echo "全部参数：" $@
echo "命令行参数数量：" $#
echo '$0 = ' $0
echo '$1 = ' $1
echo '$2 = ' $2
echo '$3 = ' $3
```
用户可以输入任意数量的参数，利用for循环读取每一个参数。
``` shell
for i in "$@";do
    echo $i
done
```
如果多个参数放在双引号里面视为一个参数。
``` shell
./scripts.sh "1 2 3" b c d e
```
## shift 命令
shift命令可以改变脚本参数，每次执行都会移除脚本当前的第一个参数（$1）,使得后面的参数向前一位，
即$2变成$1，$3变成$2，以此类推。  
while循环结合shift命令，也可以读取每一个参数。
``` shell
echo "一共输入了$#个参数"
while [ "$1" != "" ]; do
    echo "剩下 $# 个参数"
    echo "参数:$1"
    shift
done
```
上面的例子中shift命令每次移动当前第一个参数，从而通过while遍历所有参数。  
shift命令可以接受一个整数作为参数，指定所要移除的参数个数，默认是1。
``` shell
shift 3
```
## getopts 命令
getopts命令用在脚本内部，可以解析复杂的脚本命令行参数，通常与while循环一起使用，取出脚本所有的
带有前置连词线（-）的参数。  
while循环结合shift命令，也可以读取每一个参数。
``` shell
getopts optstring name
```
它带有两个参数，第一个参数optstring是字符串，给出脚本所有的连词线参数。比如，
某个脚本可以有三个配置项参数-l、-h、-a，其中只有-a可以带有参数值，而-l、-h是开发参数，
那么getopts的第一个参数写成lha:，顺序不重要。注意，a后面有一个冒号，表示该参数带有参数值，
getopts规定带有参数值的配置项后面必须带有一个冒号(:)。getopts的第二个参数name是一个变量名，
用来保存当前读取到的配置参数，即l、h和a。
``` shell
while getopts 'lha:' OPTION;do
    case "$OPTION" in
        l)
        echo "linuxconfig"
        ;;
        h)
        echo "h stands for h"
        ;;
        a)
        avalue="$OPTARG"
        echo "the value provided is $OPTARG"
        ;;
        ?)
        echo "script usage: $(basename $0) [-l] [-h] [-a somevalue]" >&2
        exit 1
        ;;
    esac
done
shift "$(($OPTIND - 1))"
```
上面例子中，while循环不断执行 getopts 'lha' OPTION 命令，每次执行都会读取一个连词线参数
（以及对应的值）然后进入循环体。变量OPTION保存的是，当前处理的的哪一个连词线参数（即l、a、h）。
如果用户输入了没有指定的参数那么OPTION等于？。循环体内使用case判断处理不同的情况。  
如果某个连词线参数带有参数，比如-a foo，那么处理a参数的时候环境变量$OPTARG保存的就是参数值。  
注意，只要遇到不带连词线的参数，getopts就会执行失败，从而退出while循环。比如getopts可以解析
command -l foo，但不能解析command foo -l。另外多个连词线参数写在一起的形式，比如command -lh，
getopts也可以正确处理。  
变量$OPTIND在getopts开始执行之前是1，然后每次执行+1，等到退出while循环就意味连词线参数全部处理完成。
这时$OPTIND - 1 就是已经处理的连词线参数的个数，使用shift命令将这些参数移除，保证后面的代码可以用$1、
$2来处理命令的主参数。
## 配置项参数终止符 --
- 和 -- 开头的参数会被Bash当做配置项解释。但是，有时他们不是配置项而是实际参数的一部分，比如文件名叫做-f或--file。  
``` shell
cat -f
#cat: invalid option -- 'f'
cat --file
#cat: unrecognized option '--file'
```
上面命令的原意是输出文件-f和--file的内容，但是会被Bash当做配置项解释。  
这时就可以使用配置项参数终止符--，它的作用是告诉Bash在它后面的参数开头的 -和--不是配置项，只能当作参数实体。
## exit 命令
exit命令用于终止当前脚本的执行，并向Shell返回一个退出值。  
``` shell
exit
```
上面命令中止当前脚本，将最后一条命令的退出状态作为整个脚本的退出状态。  
exit命令后面可以跟参数，该参数就是退出状态。
``` shell
#退出值0代表成功
exit 0
#退出值1代表失败
exit 1
```
退出时脚本会返回一个退出值，退出值0表示正常，1表示发生错误，2表示用法不对，
126表示不是可执行脚本，127表示命令没有被发现。
如果脚本被信号N中止，则退出值为128+N。简单来说，只要退出值非0就表示执行出错。  
下面是一个例子：
``` shell
if [ $(id -u) != "0" ]; then
    echo "根用户才能执行当前脚本"
    exit 1
fi
```
上面的例子中，id -u命令返回用户的id，一旦用户的id不等于0脚本就会退出，并且退出码为1，
表示运行失败。      
exit和return命令的差别是，return命令时函数的退出，并返回一个值给调用者，脚本依然会执行。
exit是整个脚本的退出，如果在函数之中调用exit则退出函数并中止脚本。
## 命令执行结果
命令执行结束后，会有一个返回值。0表示成功，非0表示执行失败。环境变量$?可以读取前一个命令的返回值。  
利用这一点可以在脚本中对命令的执行结果进行判断。  
``` shell
exit
```
上面命令中止当前脚本，将最后一条命令的退出状态作为整个脚本的退出状态。  
exit命令后面可以跟参数，该参数就是退出状态。
``` shell
cd /home/li/works/caffer
if [ "$?" == "0" ];then
    rm *
else
    echo "无法切换目录！" 1>&2
    exit 1
fi
```
更简洁的写法是利用两个逻辑运算符&&或||。
``` shell
cd /home/li/works/caffer && rm *
# 失败则退出
cd /home/li/works/caffer || exit 1
```
## source 命令
source命令用户执行一个脚本，通常用于重新加载一个配置文件。  
``` shell
source .bashrc
```
source命令最大的特点是在当前Shell执行脚本，不想直接执行脚本时会创建一个子Shell。  
所以source命令执行脚本时不需要export变量。
``` shell
foo=1
source test.sh
bash test.sh
```
source命令的另一个用途，是在脚本内部加载外部环境变量。
``` shell
source .bashrc
```
source有一个简写形式，可以使用一个点（.）来表示。
``` shell
. .bashrc
```
## alias 别名 命令
alias命令用户为一个命令指定别名，这样更便于记忆。格式如下:  
``` shell
alias NAME=DEFINITION
```
上面命令中，NAME是别名的名称，DEFINITION是别名对应的原始指令。  
注意，等号两侧不能有空格，否则会报错。
``` shell
alias search=grep
```
alias也可以用来为长命令指定一个更短的别名，下面是通过别名定义一个today命令。
``` shell
alias today='date +"%A, %B %-d,%Y"'
today
```
有时为了防止误删文件，可以指定rm命令的别名。
``` shell
rm cppcheck.sh
#rm: remove regular file 'cppcheck.sh'?
```
alias命令的别名也可以接受参数，参数会直接传入原始命令。
``` shell
alias echo='echo It says: '
echo hello world
#It says: hello world
```
指定别名之后，就可以像使用其他命令一样使用别名。一般来说，都会把常用的别名写在~/.bashrc的末尾。
另外，只能为命令定义别名，为其他部分定义别名是无效的。  
直接调用alias命令，可以显示所有别名。
``` shell
alias
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# alias echo='echo It says: '
# alias egrep='egrep --color=auto'
# alias fgrep='fgrep --color=auto'
# alias grep='grep --color=auto'
# alias l='ls -CF'
# alias la='ls -A'
# alias ll='ls -alF'
# alias ls='ls --color=auto'
```
unalias命令可以解除别名。
``` shell
unalias echo
echo hello world
```
