# Shell的重定向
就像我们平时写程序一样，一段程序会处理外部分输入，然后将运算结果输出到指定位置。
在交互式的程序中，输入来自用户的键盘和鼠标，结果输出到用户的屏幕，设置播放设备中。
而对于某些后台运行的程序，输入可能来自外部的一些文件，运算的结果通常又写到其他的文件中。
而程序在运行过程中，会有一些关键信息，比如异常堆栈，外部接口调用情况等，这些都会通通写到
日志文件中。  
Shell脚本也一样，但是我们一般在使用Shell命令时，更多的还是通过键盘输入，然后再屏幕上查看命令的
执行结果。如果某些情况下，我们需要将shell命令的执行结果存储到文件中，那么我们就需要使用输入输出的
重定位功能。  
## 文件描述符
当执行shell命令时，会默认打开3个文件，每个文件都有对应的文件描述符来方便我们使用。
类型    | 文件描述符   |   默认情况    |   对应文件句柄位置
------- | ---------- | ------------ | --------------
输入/standard input    |   0         | 从键盘获取      |   /proc/self/fd/0
输出/standard ouput    |   1         | 输出到屏幕即控制台      |   /proc/self/fd/1
错误输出/error ouput    |   2         | 输出到屏幕即控制台      |   /proc/self/fd/2

## 输出重定向
输出重定向的使用方式很简单，基本的一些命令如下：
命令    | 说明 
------- | ---------- 
command > filename    |   把标准输出重定向到新文件中
command 1> filename    |   同上
command >> filename    |   把标准输出追加到新文件中
command 1>> filename    |   同上
command 2> filename    |   把标准错误重定向到新文件中
command 2>> filename    |   把标准错误追加到新文件中 

我们使用>或者 >> 对输出进行重定向，符号左边表示文件描述符，如果没有的话就是1，也就是标准输出，
符号的右边可以是一个文件，也可以是一个设备。当使用>时，会判断右边存不存在，如果存在的话就先删除然后创建一个新的文件，
不存在的话就直接创建。但是当使用>>时，则不会删除原来已经存在的文件。  
下面是一个例子：  
我们创建一个测试目录，目录下面仅有一个a.txt文件，在我们执行ls a.txt b.txt之后，一共有两种输出，
其中ls无法访问 b.txt，没有那个文件或目录是错误输出，ls a.txt就是标准输出。
``` shell
touch a.txt
ls a.txt b.txt
# ls: cannot access 'b.txt': No such file or directory
# a.txt
```
在上述命令中，我们将原来的标准输出重定向到out文件中，所以控制台只剩下了错误输出。
并且执行了追加操作，out文件的内容非但没有被清空，胆儿多了一条a.txt
``` shell
ls a.txt b.txt >> out
# ls: cannot access 'b.txt': No such file or directory
cat out
# a.txt
```
同理，我们也可以将错误输出重定向到文件中
``` shell
ls a.txt b.txt 2>err
# a.txt
cat err
# ls: cannot access 'b.txt': No such file or directory

ls a.txt b.txt >out 2>err
cat out
# a.txt
cat err
# ls: cannot access 'b.txt': No such file or directory
```
## 输入重定向
输入重定位的一些命令如下：
命令    | 说明 
------- | ---------- 
command < filename    |   以filename文件作为标准输入
command 0< filename    |   同上
command << filename    |   从标准输入读入，直到delimiter分隔符

我们使用< 对输入做重定向，如果符号坐标没有写值，那么默认为0。  
我们以cat命令为例。如果cat后面没有跟文件名的话，那它的作用就是将标准输入（比如键盘）回显大盘标准输出上：
``` shell
cat
# 123
# 123
# test
# test
```
我们可以利用输入重定向，将我们键盘输入的字符写入文件中。
``` shell
cat > out
#hello world
cat out
#hello world
```
如果使用cat > out <<end, 然后按下回车之后命令并没有结束，此时cat命令像开始一样等待输入数据。
直到输入end之后cat才会结束。
``` shell
cat > out <<end
> hello world end
> end
cat out
# hello world end
```
## 重定向绑定
命令 > /dev/null 2>&1 其实分为两个部分，一个是> /dev/null，另一个是2>&1。  
linux在执行命令之前，就会确定好所有的输入输出位置，并且从左到右依次执行重定向命令，
所以先执行> /dev/null，表示表示标准输出重定向/dev/null(丢弃)，然后错误输出由于重用了
标准输出的描述符，所以错误也丢弃。  
执行了这条命令后，控制台不会输出任何信息，也不会写文件。  
### /dev/null
这条命令的作用是将标准输出1重定向到/dev/null中，/dev/null代表linux的空设备文件，所有往这个文件写入的内容都会被丢弃，
俗称“黑洞”。那么执行了>/dev/null之后，标准输出就不会存在，没有任何地方能找到输出的内容。  
### 2>&1
这条命令用到了重定向绑定，采用&可以将两个输出绑定在一起，这条命令的作用是错误输出和标准输出用同一个地址，也就是
错误输出重定向到标准输出。
### >/dev/null 2>&1 和 2>&1 >/dev/null

命令    | 标准输出  | 错误输出  
------- | ---------- | ----------   
    >/dev/null 2>&1    |   丢弃 |   丢弃  
    2>&1 >/dev/null    |   丢弃 |   屏幕  

 下面看一个例子：
 ``` shell
ls a.txt b.txt >/dev/null 2>&1
ls a.txt b.txt 2>&1 > /dev/null
# ls: cannot access 'b.txt': No such file or directory
```
## nohup结合
我们经常使用nohup command &的形式来启动一些后台程序
``` shell
nohup xxx &
```
为了不让一些执行命令输出到控制台，会在后面加上>/dev/null 2>&1 命令来丢弃所有的输出。
``` shell
nohup xxx >/dev/null 2>&1 &
```