# 脚本除错
如何对 Shell 脚本除错。
## 常见错误
编写 Shell 脚本的时候，一定要考虑到命令失败的情况，否则很容易出错。
``` shell
dir_name=/path/not/exist
cd $dir_name
rm *
```
上面脚本中，如果目录$dir_name不存在，cd $dir_name命令就会执行失败。这时，就不会改变当前目录，脚本会继续执行下去，导致rm *命令删光当前目录的文件。  
如果改成下面的样子，也会有问题。  
``` shell
cd $dir_name && rm *
```
上面脚本中，只有cd $dir_name执行成功，才会执行rm *。但是，如果变量$dir_name为空，cd就会进入用户主目录，从而删光用户主目录的文件。  
下面的写法才是正确的。
``` shell
[[ -d $dir_name ]] && cd $dir_name && rm *
```
上面代码中，先判断目录$dir_name是否存在，然后才执行其他操作。  
如果不放心删除什么文件，可以先打印出来看一下。
``` shell
[[ -d $dir_name ]] && cd $dir_name && echo rm *
```
## bash的参数
bash的-x参数可以在执行每一行命令之前，打印该命令。一旦出错，这样就比较容易追查。  
下面是一个脚本script.sh。
``` shell
echo hello world
```
- -n: 不运行脚本，只检查是否有语法错误。  
- -v: 输出每一行语句运行结果前，会先输出该行语句。  
- -x: 执行每条命令之前，都会显示该命令。  
``` shell
bash -x script.sh
```
上面例子中，行首为+的行，显示该行是所要执行的命令，下一行才是该命令的执行结果。  
下面再看一个-x写在脚本内部的例子。
``` shell
#! /bin/bash -x
# trouble: script to demonstrate common errors

number=1
if [ $number = 1 ]; then
  echo "Number is equal to 1."
else
  echo "Number is not equal to 1."
fi
```
## 环境变量
### LINENO
变量LINENO返回它在脚本里面的行号。
``` shell
echo "This is line $LINENO"
```
### FUNCNAME
变量FUNCNAME返回一个数组，内容是当前的函数调用堆栈。该数组的0号成员是当前调用的函数，1号成员是调用当前函数的函数，以此类推。
``` shell
function func1()
{
  echo "func1: FUNCNAME0 is ${FUNCNAME[0]}"
  echo "func1: FUNCNAME1 is ${FUNCNAME[1]}"
  echo "func1: FUNCNAME2 is ${FUNCNAME[2]}"
  func2
}

function func2()
{
  echo "func2: FUNCNAME0 is ${FUNCNAME[0]}"
  echo "func2: FUNCNAME1 is ${FUNCNAME[1]}"
  echo "func2: FUNCNAME2 is ${FUNCNAME[2]}"
}

func1
```
### BASH_SOURCE
变量BASH_SOURCE返回一个数组，内容是当前的脚本调用堆栈。该数组的0号成员是当前执行的脚本，1号成员是调用当前脚本的脚本，以此类推，跟变量FUNCNAME是一一对应关系。
``` shell
function func1()
{
  echo "func1: BASH_SOURCE0 is ${BASH_SOURCE[0]}"
  echo "func1: BASH_SOURCE1 is ${BASH_SOURCE[1]}"
  echo "func1: BASH_SOURCE2 is ${BASH_SOURCE[2]}"
  func2
}
```

### BASH_LINENO
变量BASH_LINENO返回一个数组，内容是每一轮调用对应的行号。${BASH_LINENO[$i]} 跟 ${FUNCNAME[$i]}是一一对应关系，表示${FUNCNAME[$i]}在调用它的脚本文件${BASH_SOURCE[$i+1]}里面的行号。
``` shell
function func1()
{
  echo "func1: BASH_SOURCE0 is ${BASH_SOURCE[0]}"
  echo "func1: BASH_SOURCE1 is ${BASH_SOURCE[1]}"
  echo "func1: BASH_SOURCE2 is ${BASH_SOURCE[2]}"
  func2
}
```