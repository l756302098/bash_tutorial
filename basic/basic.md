# Bash的基本语法

## echo命令
echo 命令的作用是在屏幕输出一行文本。
``` shell
echo hello world
```  

多行文本输出
``` shell
echo "Monica Code brings Claude 3.5 
and GPT-4o directly into VSCode, 
providing in-depth project understanding 
without disrupting your workflow."
```  

### -n 参数
默认情况下，echo输出的文本末尾会有一个回车符。-n参数可以取消末尾的换行符，使得下一个提示符紧跟在输出内容的后面。
``` shell
echo hello world
echo -n hello world

echo a;echo b
echo -n a;echo b
```

### -e 参数
该参数会解释引号内的特殊字符（比如换车符\n）,如果不使用-e参数默认情况下，echo不会解释原样输出。
``` shell
echo "hello\nworld"
echo -e "hello\nworld"
```

## 命令格式
命令行环境下主要通过使用shell命令进行各种操作，shell遵循一定的格式。
``` shell
command --help
    command: command [-pVv] command [arg ...]
    Execute a simple command or display information about commands.
    
    Runs COMMAND with ARGS suppressing  shell function lookup, or display
    information about the specified COMMANDs.  Can be used to invoke commands
    on disk when a function with the same name exists.
    
    Options:
      -p    use a default value for PATH that is guaranteed to find all of
            the standard utilities
      -v    print a description of COMMAND similar to the `type' builtin
      -V    print a more verbose description of each COMMAND
    
    Exit Status:
    Returns exit status of COMMAND, or failure if COMMAND is not found.
```
如使用下列命令，ls是命令，-l是参数。 
``` shell
ls -l
```
多行命令可以用反斜杠分行
``` shell
echo use a default value for PATH that is guaranteed to find all of the standard utilities
echo use a default value for PATH \
that is guaranteed to find all of the standard utilities 
```

## 空格
Bash使用空格、Tab键区分不同的参数。
``` shell
command arg1 arg2
```
上面的命令中，arg1 arg2之间有一个空格，所以认为这是两个参数。
如果arg1 arg2之间有多个空格，Bash会忽略多余的空格。
``` shell
echo this is a     test
```

## 分号
分号（;）是命令的结束符。
``` shell
clear;ls
```
上面的例子中先执行clear命令，再执行ls命令。
注意：使用分号时，命令总是顺序执行，无关执行结果。
``` shell
foo;ls
```  
## 命令的组合符 && 和 ||
出了分号外Bash还提供了两个或多个命令的组合符&& 和 ||，允许更好的控制多个命令之间的继发关系。
如果希望command1命令运行成功，再继续运行command2命令。
``` shell
command1 && command2
```
如果希望command1命令运行失败，再继续运行command2命令。
``` shell
command1 || command2
```
下面举例说明：
``` shell
cat zed.sh ;ls -l zed.sh
```
上面无论cat是否成功都会执行下一条命令，如果希望cat成功后再运行下一条命令
``` shell
cat zed.sh && ls -l zed.sh
```
如果希望cat失败后再运行下一条命令
``` shell
cat zed.s || ls -l zed.sh
```
## type命令
Bash本身内置了很多命令，同时也可以执行外部命令。怎么知道是一个内置命令还是一个外部命令呢？
可以使用type命令来判断命令的来源。
``` shell
type echo
```
如果要查看一个命令的所有定义，可以使用type -a 的参数。
``` shell
type -a echo
```
type -t可以返回一个命令的类型，别名（alias），关键字（keyword），函数（function），内置命令（buildin）和文件（file）
``` shell
type -t ls
type -t if
type quote_readline
type -t echo
type -t bash
```
## 快捷键
Bash提供了很多的快捷键，可以方便操作。  
- Ctrl+L： 清楚屏幕  
- Ctrl+C：终止当前正在执行的命令  
- Shift+PageUp：向上滚动  
- Shift+PageDown：向下滚动  
- Ctrl+U：从光标位置删除到行首  
- Ctrl+K：从光标位置删除到行尾  
- Ctrl+W：从光标位置向前删除一个单词  
- Ctrl+D：关闭shell会话  
- Tab：自动补全  