# Bash的条件判断
## if结构
if是最常用的条件判断结构，只有符合给定条件是，才会执行特定的命令。
它的语法如下：
``` shell
if commands; then
    commands
elif commands; then
    commands
else
    commands
fi
```
这个命令分成三个部分：if、elif和else。其中，后两个部分是可选的。  
if 关键字后面是主要的判断条件，elif用来添加在主条件不成立时的其他判断条件，
else则是所有条件都不成立时要执行的部分。
``` shell
if test $USER = "foo";  then
# 等价 
#if [ $USER = "foo" ];  then
    echo "hello foo."
else
    echo "Who are you."
fi
```
上面的例子中，判断条件是环境变量$USER是否等于foo，如果等于输出hello foo.，否则输出其他内容。  
if 和 then 写在同一行是，需要分号分隔。分号是Bash的命令分隔符，它们可以写成两行则不需要分号。
``` shell
if true; then
    echo "it is true."
fi

if false
then
    echo "it is false."
fi
```
上面的例子中，true和false是两个特殊命令，前者代表成功，后者代表失败。  
除了多行的写法，可以写成一行。
``` shell
if true; then echo "it is true."; fi
```
注意，if关键字后面也可以是一条命令，该命令执行成功返回值0，就意味着判断条件成立。
``` shell
if echo "hi."; then echo "it is true."; fi
```
if命令后面可以跟任意数量的命令，这是所有命令都会执行，但是判断真伪只看最后一个命令。
只要最后一个返回0就会执行then的部分。
``` shell
if echo "hi.";false;echo "start"; then echo "it is true."; fi
```
## test 命令
if结构的判断条件，一般使用test命令，有三种形式。
``` shell
# 写法一
test expression

# 写法二
[ expression ]

# 写法三
[[ expression ]]
```
上面的三个形式是等价的，但是第三种形式还支持正则判断。  
上面的expression是一个表达式，这个表达式为真，test命令执行成功。  
注意，第二种和第三种写法[ 和 ]与内部的表达式之间必须有空格。
``` shell
test -f /etc/hosts
echo $?
# 等价
[ -f /etc/hosts ]
echo $?
# 等价
[[ -f /etc/hosts ]]
echo $?
```
判断一个文件是否存在的三种形式。
``` shell
# 写法一
if test -e /tmp/foo.txt ; then
    echo "found foo.txt"
fi

# 写法二
if [ -e /tmp/foo.txt ] ; then
    echo "found foo.txt"
fi

# 写法三
if [[ -e /tmp/foo.txt ]] ; then
    echo "found foo.txt"
fi
```
## 判断表达式
if关键字后面跟的是一个命令，这个命令可以是test命令也可以是其他命令。命令的返回值为0表示判断成立，否则不成立。
因为这些命令主要是为了得到返回值，所以可以视为表达式。
常用的判断表达式有以下几种形式：
### 文件判断
以下表达式用来判断文件状态。
- [ -a file ] : 如果file存在，则为true。
- [ -b file ] : 如果file存在并且是一个块（设备）文件，则为true。
- [ -c file ] : 如果file存在并且是一个字符（设备）文件，则为true。
- [ -d file ] : 如果file存在并且是一个目录，则为true。
- [ -e file ] : 如果file存在，则为true。
- [ -f file ] : 如果file存在并且是一个普通文件，则为true。
- [ -g file ] : 如果file存在并且设置了组ID，则为true。
- [ -G file ] : 如果file存在并且属于有效的组ID，则为true。
- [ -h file ] : 如果file存在并且是符号链接，则为true。
- [ -k file ] : 如果file存在并且设置了它的“sticky bit”，则为true。
- [ -L file ] : 如果file存在并且是符号链接，则为true。
- [ -N file ] : 如果file存在并且自上次读取后已被修改，则为true。
- [ -O file ] : 如果file存在并且是属于有效的组ID，则为true。
- [ -p file ] : 如果file存在并且是一个命名管道，则为true。
- [ -r file ] : 如果file存在并且可读（当前用户有可读权限），则为true。
- [ -s file ] : 如果file存在且其长度大于0，则为true。
- [ -S file ] : 如果file存在且是一个网络socket，则为true。
- [ -t fd ] : 如果fd是一个文件描述符并且重定位到终端，则为true。这可以用来判断是否重定向了标准输入、输出、错误。
- [ -u file ] : 如果file存在并且设置了setid位，则为true。
- [ -w file ] : 如果file存在并且可写（当前用户有写权限），则为true。
- [ -x file ] : 如果file存在并且可执行（当前用户有执行、搜索权限），则为true。
- [ FILE1 -nt FILE2 ] : 如果FILE1比FILE2的更新时间更近或FILE1存在而FILE2不存在，则为true。
- [ FILE1 -ot FILE2 ] : 如果FILE1比FILE2的更新时间更旧或如果FILE2存在而FILE1不存在，则为true。
- [ FILE1 -ef FILE2 ] : 如果FILE1和FILE2引用相同的设备和inode编号，则为true。

``` shell
FILE=~/.bashrc

if [ -e $FILE ]; then
    echo "$FILE is exist."
    if [ -f $FILE ]; then
        echo "$FILE is a file."
    fi
    if [ -d $FILE ]; then
        echo "$FILE is a directory."
    fi
    if [ -r $FILE ]; then
        echo "$FILE is readable."
    fi
    if [ -w $FILE ]; then
        echo "$FILE is writable."
    fi
    if [ -x $FILE ]; then
        echo "$FILE is executable/searchable.."
    fi
else
    echo "other."
fi
```
上面代码中，$FILE要放在双引号之中，这样可以防止变量$FILE为空从而出错。
因为$FILE如果为空，这是[ -e $FILE ]就变成[ -e ]，这会被判断为真。而
$FILE放在双引号之中，[ -e $FILE ]就变成[ -e "" ]这会被判断为伪。
### 字符串判断
以下表达式用来判断字符串。
- [ string ] : 如果string不为空，则为true。
- [ -n string ] : 如果string的长度大于0，则为true。
- [ -z string ] : 如果string的长度为0，则为true。
- [ string1 = string2 ] : 如果string1和string2相同，则为true。
- [ string1 == string2 ] : 等同于[ string1 = string2 ]。
- [ string1 != string2 ] : 如果string1和string2不相同，则为true。
- [ string1 '>' string2 ] : 如果按照字典顺序string1排列在string2之后，则为true。
- [ string1 '<' string2 ] : 如果按照字典顺序string1排列在string2之前，则为true。

注意，test命令内部的> 和 <，必须用引号或者反斜杠转义。否则他们会被Shell解释为重定向操作符。  
下面是一个示例：
``` shell
ANSWER=maybe

if [ -z $ANSWER ]; then
    echo "there is no answer." >&2
    exit 1
fi
if [ $ANSWER = "yes" ];then
    echo "The answer is YES."
elif [ $ANSWER = "no" ];then
    echo "The answer is NO."
elif [ $ANSWER = "maybe" ];then
    echo "The answer is MAYBE."
else
    echo "The answer is UNKONWN."
fi
```
上面代码中，首先确定$ANSWER字符串是否为空。如果为空，就终止脚本，并把退出状态设为1。
注意，这里的echo命令会把错误信息The answer is NO.重定向到标准错误，这是处理错误的常用方法。
如果$ANSWER字符串不为空，就判断它的值是否等于yes、no和maybe。  
注意，字符串判断时，变量要放在双引号之中，比如[ -n $COUNT ],否则变量替换成字符串以后，test命令
就会报错，提示参数过多。另外不放在双引号之中，变量为空时，命令就会变成[ -n ],这时会判断为真。如果放在
双引号之中，[ -n "" ]就判断为伪。
### 整数判断
以下表达式用来判断整数。
- [ integer1 -eq integer2 ] : 如果integer1等于integer2，则为true。
- [ integer1 -nq integer2 ] : 如果integer1不等于integer2，则为true。
- [ integer1 -le integer2 ] : 如果integer1小于或等于integer2，则为true。
- [ integer1 -lt integer2 ] : 如果integer1小于integer2，则为true。
- [ integer1 -ge integer2 ] : 如果integer1大于或等于integer2，则为true。
- [ integer1 -gt integer2 ] : 如果integer1大于integer2，则为true。

下面是一个用法的例子。
``` shell
INT=-5
if [ -z $INT ];then
    echo "INT is empty." >&2
    exit 1
fi
if [ $INT -eq 0 ];then
    echo "INTis zero."
else
    if [ $INT -lt 0 ];then
        echo "INT is negative."
    else
        echo "INT is positive."
    fi
    if [ $((INT % 2)) -eq 0 ]; then
        echo "INT is even."
    else
        echo "INT is odd." 
    fi
fi
```
### 正则判断
[[ expression ]]这种判断形式支持正则表达式。
``` shell
[[ string1 =~ regex ]]
```
上面的语法中，regex是一个正则表达式，=~是正则比较运算符。  
下面是一个例子：

``` shell
INT=-5
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    echo "INT is an integer."
    exit 0
else
    echo "INT is not an integer."
    exit 1
fi
```
上面的代码中，先判断变量INT的字符串形式，是否满足正则匹配，如果满足就表明它是一个整数。
### test 判断的逻辑运算
通过逻辑运算可以把多个test判断表达式结合起来，创造更复杂的判断。三种逻辑AND、OR和NOT都有自己的专用符号。  
- AND运算 : 符号&& 也可以用参数-a。
- OR运算 : 符号|| 也可以用参数-o。
- NOT运算 : 符号！。

下面是一个AND的例子：
``` shell
MIN_VAL=1
MAX_VAL=100

INT=50

if [[ $INT =~ ^-?[0-9]+$ ]]; then
    echo ""
    if [[ $INT -ge $MIN_VAL && $INT -le $MAX_VAL ]]; then
        echo "$INT is within $MIN_VAL to $MAX_VAL"
    else
        echo "$INT is out of range."
    fi
else
    echo "INT is not an integer." >&2
    exit 1
fi
```
上面例子中，&&用来连接两个判断条件。  
使用否定操作符！时，最好使用圆括号确定转义的范围。

``` shell
MIN_VAL=1
MAX_VAL=100

INT=50
if [ ! \( $INT -ge $MIN_VAL -a $INT -le $MAX_VAL \) ]; then
    echo "$INT is outside $MIN_VAL to $MAX_VAL."
else
    echo "$INT is in range."
fi
```
### 算术判断
Bash还提供了((...))作为算术条件，进行算术运算的判断。  
下面是一个AND的例子：
``` shell
if (( 3 > 2 )); then
    echo true
fi
```
注意，算术判断不需要使用test命令，而是直接使用((...))结构，这个结构的返回值决定了判断的真伪。  
如果算术计算的结果是非零值，则表示判断成立。这一点跟命令的返回值刚好相反，需要小心。
### 普通命令的逻辑判断
如果if结构使用的不是test命令，而是普通命令，比如上一节的((...))算术运算，或者test命令与普通命令
混用，那么可以使用Bash的命令控制操作符&&或||，进行多个命令的运算。
``` shell
command1 && command2
command1 || command2
```
先创建一个temp的目录，执行成功后才会执行第二个命令，进入目录。
``` shell
mkdir temp && cd temp
```
测试目录temp是否存在，如果不存在，就会执行第二个命令，创建这个目录。
``` shell
[ -d temp ] || mkdir temp
```
如果temp子目录不存在，脚本会终止，并且返回值为1。
``` shell
[ ! -d temp ] && exit 1
```
下面就是if与&&结合使用的写法：
``` shell
if [ condition1 ] && [ condition2 ]; then
    command
fi
```
下面是一个示例，只要在指定的文件里面同时存在关键词word1和word2，就会执行if命令的部分。
``` shell
if grep $word1 $filename && grep $word2 $filename; then
    echo "$word1 and $word2 are both in $filename." 
fi
```
下面的示例演示如何将一个&&判断表达式，改写成对应的if结构。
``` shell
[[ -d "$dir_name" ]] && cd "$dir_name" && rm *

# 等同于

if [[ ! -d "$dir_name" ]]; then
  echo "No such directory: '$dir_name'" >&2
  exit 1
fi
if ! cd "$dir_name"; then
  echo "Cannot cd to '$dir_name'" >&2
  exit 1
fi
if ! rm *; then
  echo "File deletion failed. Check results" >&2
  exit 1
fi
```
## case 结构
case结构用于多值判断，可以为每个值指定对应的命令，跟包含多个elif的if结构等价，但是语义更好。
它的语法如下：
``` shell
case expression in
  pattern )
    commands ;;
  pattern )
    commands ;;
  ...
esac
```
上面代码中，expression是一个表达式，pattern是表达式的值或者一个模式，可以有多条，用来匹配多个值，
每条以两个分号（；）结尾。
``` shell
echo -n "输入一个1到3之间的数字:"
read character
case $character in
  1 ) echo 1
    ;;
  2 ) echo 2
    ;;
  3 ) echo 3
    ;;
  * ) echo 输入不符合要求
esac
```
上面的例子中，最后一条匹配语句的模式是*，这个通配符可以匹配其他字符和没有输入的情况，类似if的else部分。  
下面是另一个例子。
``` shell
OS=$(uname -s)

case "$OS" in
  FreeBSD) echo "This is FreeBSD" ;;
  Darwin) echo "This is Mac OSX" ;;
  AIX) echo "This is AIX" ;;
  Minix) echo "This is Minix" ;;
  Linux) echo "This is Linux" ;;
  *) echo "Failed to identify this OS" ;;
esac
```
case的匹配模式可以使用各种通配符，比如：
- a) : 匹配a
- a|b) : 匹配a或b
- [[:alpha:]]) : 匹配单子字母
- ???) : 匹配三个字符的单词
- *.txt) : 匹配.txt结尾
- *) : 匹配任意输入

``` shell
echo -n "输入一个字母或数字 > "
read character
case $character in
  [[:lower:]] | [[:upper:]] ) echo "输入了字母 $character"
                              ;;
  [0-9] )                     echo "输入了数字 $character"
                              ;;
  * )                         echo "输入不符合要求"
esac
```
上面例子中，使用通配符[[:lower:]] | [[:upper:]]匹配字母，[0-9]匹配数字。  
Bash 4.0之前，case结构只能匹配一个条件，然后就会退出case结构。Bash 4.0之后，允许匹配多个条件，
这时可以用;;&终止每个条件块。
``` shell
read -n 1 -p "Type a character > "
echo
case $REPLY in
  [[:upper:]])    echo "'$REPLY' is upper case." ;;&
  [[:lower:]])    echo "'$REPLY' is lower case." ;;&
  [[:alpha:]])    echo "'$REPLY' is alphabetic." ;;&
  [[:digit:]])    echo "'$REPLY' is a digit." ;;&
  [[:graph:]])    echo "'$REPLY' is a visible character." ;;&
  [[:punct:]])    echo "'$REPLY' is a punctuation symbol." ;;&
  [[:space:]])    echo "'$REPLY' is a whitespace character." ;;&
  [[:xdigit:]])   echo "'$REPLY' is a hexadecimal digit." ;;&
esac
```