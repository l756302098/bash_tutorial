# Bash的循环
## while 循环
while 循环有一个判断条件，只要符合条件，就不断执行指定的语句。
``` shell
while condition; do
    commands
done
```
上面代码中，只要满足条件condition，就会执行命令commands，然后再判断是否满足条件condition，只要满足，
就会一直执行下去。只要不满足条件，才会退出循环。  
循环条件condition可以使用test命令，跟if结构的判断条件写法一致。
``` shell
number=1
while [ $number -lt 10 ]; do
    echo "number = $number"
    number=$((number+1))
done
```
while 和do也可以分两行来写，也可以把所有的写成一行用分号分隔。
``` shell
while true
do
  echo 'Hi, while looping ...';
done
#等价
while true; do echo 'Hi, while looping ...'; done
```
while的条件部分也可以是执行的一个命令。
``` shell
while echo 'ECHO'; do echo 'Hi, while looping ...'; done
```
上面的例子中，判断条件echo 'ECHO'，由于这个命令总是执行成功，所有会无线循环。
## until 循环
until 循环与while 循环恰好相反，只要不符合条件，就不断循环执行指定的语句。
一旦符合判断条件就会退出循环。
``` shell
until condition; do
    commands
done
```
## for..in 循环
for..in 循环用于遍历列表的每一项。
``` shell
for variable in list
do
  commands
done
```
下面是一个例子：
``` shell
for i in word1 word2 word3; do
  echo $i
done
```
## for 循环
for循环还支持c语言的循环语法。
``` shell
for (( expression1; expression2; expression3 )); do
  commands
done
```
上面代码中expression1用来初始化循环条件，expression2用来决定循环结束的条件，expression3在每次循环迭代的
末尾执行，用于更新值。  
它等同于下面的while循环。
``` shell
(( expression1 ))
while (( expression2 )); do
  commands
  (( expression3 ))
done
```
下面是一个例子：
``` shell
for (( i=0;i<10;i++ )); do
    echo $i
done
```
## break，continue 
Bash提供了两个内部命令break和continue，用来在循环内部跳出循环。  
break命令立即终止循环，程序继续执行循环块之后的语句。
``` shell
for number in 1 2 3 4 5 6
do
  echo "number is $number"
  if [ "$number" = "3" ]; then
    break
  fi
done
```
continue命令立即终止本轮循环，开始执行下一轮循环。
``` shell
while read -p "What file do you want to test?" filename
do
  if [ ! -e "$filename" ]; then
    echo "The file does not exist."
    continue
  fi

  echo "You entered a valid file.."
done
```
## select
select结构主要用来生成简单的菜单，它的语法与for..in循环基本一致。
``` shell
select name in list
do
  commands
done
```
Bash会对select依次进行下面的处理。  
1. select生成一个菜单，内容是列表list的每一项，并且每一项前面还有一个数字编号。
2. Bash提示用户选择一项，输入它的编号。
3. 用户输入以后，Bash会将该项的内容存在变量名name，该项的编号存入环境变量REPLY。
如果用户没有输入，就按回车键，Bash会重新输出菜单，让用户选择。  
4. 执行命名commands。
5. 执行结束后，回到第一个重复上述过程。

下面是一个例子：
``` shell
select brand in Samsung Sony iphone symphony Walton
do
  echo "You have chosen $brand"
done
```
如果用户没有输入编号直接按回车键，Bash会重新输出一遍菜单，直到用户按下Ctrl+C退出执行。  
select可以与case结合，针对不同项执行不同的命令。
