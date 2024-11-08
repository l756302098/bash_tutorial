# read 命令
## 用法
有时脚本需要再执行过程中，由用户提供一部分数据，这时可以使用read命令。
它将用户的输入存入一个变量，方便后面的代码使用。用户按下回车键，就表示输入结束。
read命令的格式如下：
``` shell
read [-options] [variable...]
```
上面语法中options是参数选项，variable是用来保存输入数值的一个或多个变量名。
如果没有提供变量名，环境变量REPLY会包含用户输入的一整行数据。
``` shell
echo -n "输入一些文本 > "
read text
echo "你的输入: $text"
```
read可以接受用户输入的多个值。
``` shell
echo Please, enter your firstname and lastname
read FN LN
echo "H! $LN, $FN !"
```
上面的例子中，read根据用户的输入同时为两个变量赋值。  
如果用户的输入少于read命令给出的参数数量，那么额外的变量值为空。
如果用户输入项多余定义的变量，那么多余的输入会包含在最后一个变量中。  
如果read命令之后没有定义变量名，那么环境变量REPLY会包含所有的输入。
``` shell
echo Please, enter your firstname and lastname
read
echo "H! $REPLY !"
```
read命令出了读取键盘输入，还可以用来读取文件。
``` shell
filename='/etc/hosts'
while read line
do
    echo "$line"
done < $filename
```
上面的例子通过read命令，读取一个文件的内容。done命令后面的定相符<将文件内容
导入read命令，每次读取一行，存入变量line直到读取完成。
## 参数
read命令的参数如下。
### -t 参数
read命令的-t参数，设置了超时的秒数。如果超过了指定时间，用户仍然没有输入，脚本将放弃等待，
继续向下执行。
``` shell
echo -n "输入一些文本 >"
if read -t 3 response; then
    echo "用户已经输入了 $response"
else
    echo "用户没有输入"
fi
```
环境变量TMOUT也可以起到同样作用，指定read命令等待用户输入的时间。
``` shell
TMOUT=3
read response
```
### -p 参数
read命令的-p参数指定用户输入的提示信息。
``` shell
read -p "Enter one or more values >"
echo "REPLY = '$REPLY'"
#Enter one or more values >hello world
#REPLY = 'hello world'
```
### -a 参数
read命令的-a参数把用户的输入赋值给一个数组，从零号位置开始。
``` shell
read -a people
echo ${people[1]}
#hello world !
#world
```
### -n 参数
read命令的-n参数指定只读取若干个字符为变量值，而不是读取整行。
``` shell
read -n 3 data
echo -e "\n$data"
#hel
#hel
```
### -e 参数
read命令的-e参数允许用户输入的时候，使用readline库提供的快捷键，比如自动补全。
``` shell
echo Please input the path to the file:
read -e filename
echo $filename
```
### 其他参数
- -d delimiter：定义字符串delimiter的第一个字符作为用户输入的结束，而不是一个换行符。
- -r raw：raw模式，表示不把用户输入的反斜杠字符解释为转义字符。
- -s ：使得用户的输入不显示在屏幕上，这常常用于输入密码或保密信息。
- -u fd：使用文件描述符fd作为输入。
## IFS 变量
read命令读取的值，默认是以空格分隔的。可以通过自定义环境变量IFS修改分隔标志。  
IFS的默认值是空格、Tab符号、换行符号，通常取第一个。  
如果把IFS定义成冒号(:)或分号（;）就可以分隔以这两个符号分隔的值，这对读取文件很有用。
``` shell
FILE=/etc/passwd

read -p "Enter a username > " user_name
file_info="$(grep "^$user_name:" $FILE)"

if [ -n "$file_info" ]; then
    IFS=":" read user pw uid gid name home shell <<< """$file_info"
    echo "user = $user"
    echo "pw = $pw"
    echo "uid = $uid"
    echo "gid = $gid"
    echo "name = $name"
    echo "home = $home"
    echo "shell = $shell"
else
    echo "No such user '$user_name'" 1>&2
    exit 1
fi
```
上面的例子中，IFS为冒号，然后分解/etc/passwd文件的一行。IFS的赋值命令read写在设置之后，
这样的话IFS的改变仅对后面的命令生效，该命令执行后IFS会自动回复原来的值。如果不写在同一行，
就要采用下面的写法。
``` shell
IFS=":"
read user pw uid gid name home shell <<< """$file_info"
IFS="$OLD_IFS"
```