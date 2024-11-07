# Bash的算术运算
Bash提供了多种算术运算语法。
## 算术表达式
((...))语法可以进行整数的算术运算。
``` shell
((result= 1 + 2))
echo $result
```
((...))会自动省略内部的空格，所以下面的写法都正确，得到同样的结果。

``` shell
((result= 1 + 2))
((result= 1+ 2))
((result= 1+2))
```
这个语法不返回值，命令执行的结果根据算术运算的结果而定，只要算术结果不为0就算执行成功。  
如果要读取算术运算的结果，需要在((...))前面加上美元符号$((...))，使其变成算术表达式，返回算术运算的结果。  
``` shell
echo $((2+2))
```
((...))语法支持的算术运算符如下:
- +: 加法
- -: 减法
- *: 乘法
- /: 除法（整除）
- %: 余数
- **: 指数
- ++: 自加运算
- --: 自减运算
注意，除法运算的返回结果是整数，比如5除以2得到的结果是2，而不是2.5。
``` shell
echo $((5/2))
```
++ 和 -- 这两个运算符有前置和后置的区别。前置是先运算再返回结果，后置是先返回再运算。
``` shell
i=1
echo $i
echo $((i++))
echo $i
echo $((++i))
echo $i
```
$((...))内部可以通过圆括号改变运算顺序。  
``` shell
echo $(( (2+1) * 2 ))
```
$((...))结构可以嵌套。  
``` shell
echo $(( (2+1) * 2 ))
# 等价
echo $(( $((2+1)) * 2 ))
```
这个语法只能计算整数，否则会报错。
``` shell
echo $(( 1.5 * 2 ))
#bash: 1.5 * 2 : syntax error: invalid arithmetic operator (error token is ".5 * 2 ")
```
## 数值的进制
Bash的数值默认都是十进制的，但是在算术表达式中，也可以使用其他进制。
- number：没有任何特殊表示法的数字就是十进制。
- 0number：八进制数。
- 0xnumber：十六进制数。
- base#number：base进制数。
下面是一些例子：
``` shell
echo $((0xff))
echo $((2#111111))
```
## 位运算
((...))支持以下的二进制位运算符如下:
- <<: 左移运算符
- \>>: 减法
- &: 位的“与”运算符
- |: 位的“或”运算符  
- ~: 位的“否”运算符  
- ^: 位的“异或”运算符
下面是一些示例：
``` shell
echo $((16>>1))
echo $((16>>2))
echo $((16<<1))
echo $((16<<2))
echo $((16&2))
echo $((16|2))
echo $((~16))
echo $((16^1))
```
## 逻辑运算
((...))支持以下的逻辑运算。
- <: 小于
- \> : 大于
- <= : 小于等于
- \>=: 大于等于  
- ==: 等于  
- !=: 不等于
- &&: 逻辑与
- ||: 逻辑或
- ！: 逻辑否  
- expr1?expr2:expr3: 三元条件运算符  

下面是一些示例：
``` shell
echo $((3 > 2))
echo $(( (3 > 2) || (4 <= 1) ))

a=0
echo $((a<1 ? 1 : 0))
echo $((a>1 ? 1 : 0))
```
## 逻辑运算
((...))可以执行赋值运算。
``` shell
echo $((a=1))
echo $a
```
上面的例子中，a=1对变量a进行赋值。这个式子本身也是一个表达式，
返回值就是等号右边的值。  
((...))支持以下的赋值运算符。
- parameter = value: 简单赋值
- parameter += value: 等价于 parameter = parameter + value
- parameter -= value: 等价于 parameter = parameter - value
- parameter *= value: 等价于 parameter = parameter * value
- parameter /= value: 等价于 parameter = parameter / value
- parameter %= value: 等价于 parameter = parameter % value  
- parameter <<= value: 等价于 parameter = parameter << value 
- parameter >>= value: 等价于 parameter = parameter >> value
- parameter &= value: 等价于 parameter = parameter & value
- parameter |= value: 等价于 parameter = parameter | value
- parameter ^= value: 等价于 parameter = parameter ^ value

下面是例子：
``` shell
data=3
echo $((data*=2))
```
## 求值运算
逗号(,)在((...))内部是求值运算符，执行前后两个表达式，并返回后一个表达式的值。
``` shell
echo $((foo= 1+2, 2+5))
```
## expr 命令
expr命令支持算术运算，可以不使用((...))语法。
``` shell
expr 5+2
#5+2
expr 5 + 2
#7
foo=2
expr $foo + 2
expr 1.5 + 2
#expr: non-integer argument
```
## let 命令
let命令用于将算术运算的结果赋予一个变量。
``` shell
let x = 2 + 3
#bash: let: =: syntax error: operand expected (error token is "=")
let x= 2 + 3
#bash: let: x=: syntax error: operand expected (error token is "=")
let x=2 + 3
#bash: let: +: syntax error: operand expected (error token is "+")
let x=2+3
echo $x
#5
```
注意，x=2+3这个式子中不能有空格，否则报错。