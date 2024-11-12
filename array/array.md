# 数组
数组（array）是一个包含多个值的变量。成员的编号从0开始，数量没有上线，也没有要求成员被连续索引。
## 创建数组
数组可以采用逐个赋值的方法创建。
``` shell
ARRAY[INDEX]=value
```
上面的语法中，ARRAY是数组的名字，可以是任意合法的变量名。INDEX是一个大于或等于0的整数，也可以是算术表达式。
注意数组的第一个元素的下标是0。  
下面创建有三个成员的数组。  
``` shell
array[0]=val
array[1]=val
array[2]=val
```
也可以采用一次性赋值的方式创建。
``` shell
ARRAY=(value1 value2 ... valueN)

# 等同于
ARRAY=(
  value1
  value2
  value3
)
```
采用上面方式创建数组时，可以按照默认顺序赋值，也可以在每个值前面指定位置。
``` shell
array=(a b c)
array=([2]=c [0]=a [1]=b)

days=(Sun Mon Tue Wed Thu Fri Sat)
days=([0]=Sun [1]=Mon [2]=Tue [3]=Wed [4]=Thu [5]=Fri [6]=Sat)
```
只为某些值指定位置可是可以的。
``` shell
names=(hatter [5]=duchess alice)
```
上面的例子中，hatter是数组的0号位置，duchess是5号位置，alice是6号位置。  
没有赋值的数组元素的默认值是空字符串。  
定义数组的时候，可以使用通配符。
``` shell
mp3s=( *.mp3 )
```
上面的例子中，将当前目录的所有mp3文件放进一个数组。  
先用declare -a 命令声明一个数组，也是可以的。  
``` shell
declare -a ARRAYNAME
```
read -a 命令则是将用户的命令行输入，存入一个数组。
``` shell
read -a dice
```
## 读取数组
### 读取单个元素
数组可以采用逐个赋值的方法创建。
``` shell
echo ${array[i]}     # i 是索引
```
上面语法中的大括号是必不可少的，否则Bash会把索引部分[i]按照原样输出。
``` shell
array[0]=a
echo ${array[0]}
echo $array[0]
```
### 读取所有元素
@和*是数组的特殊索引，表示返回数组的所有成员。
``` shell
foo=(1 b c d e f)
echo ${foo[@]}
echo ${foo[*]}
```
这两个特殊索引配合for循环，就可以用来遍历数组。
``` shell
foo=(1 b c d e f)
for i int ${foo[@]}; do
    echo $i
done
```
@和*放不放在双引号之中，是有差别的。
``` shell
activities=( swimming "water skiing" canoeing "white-water rafting" surfing )
for act in ${activities[@]}; do
    echo "Activity: $act"
done
```
上面的例子中，数组activities实际包含5个成员，但是for...in循环直接遍历${activities[@]}，导致返回7个结果。为了避免这种情况，一般把${activities[@]}放在双引号之中。
``` shell
activities=( swimming "water skiing" canoeing "white-water rafting" surfing )
for act in "${activities[@]}"; do
    echo "Activity: $act"
done
```
所以，拷贝一个数组最方便的方式是
``` shell
activities=( swimming "water skiing" canoeing "white-water rafting" surfing )
hobbies=( "${activities[@]}" )
for act in "${hobbies[@]}"; do
    echo "Activity: $act"
done
echo -e "\n"
hobbies=( "${activities[@]}" diving )
for act in "${hobbies[@]}"; do
    echo "Activity: $act"
done
```
### 默认位置
如果读取数组成员时，没有读取指定哪一个位置的成员，默认使用0号位置。
``` shell
declare -a foo
foo=A
echo ${foo[0]}
```
上面例子中，foo是一个数组，赋值的时候不指定位置，实际上是给foo[0]赋值。  
引用一个不带下标的数组变量，则引用的是0号位置的数组元素。
``` shell
foo=(a b c d e f)
echo ${foo[0]}
#等价
echo ${foo}
```
## 数组的长度
要想知道数组的长度（即一共包含多少成员），可以使用下面两种语法。
``` shell
${#array[*]}
${#array[@]}
```
下面是一个例子：
``` shell
a[100]=foo
echo ${#a[*]}
```
上面例子中，把字符串赋值给100位置的数组元素，这时的数组只有一个元素。  
注意，如果用这种语法去读取具体的数组成员，就会返回该成员的字符串长度。这一点必须小心。
``` shell
a[100]=foo
echo ${#a[100]}
```
上面例子中，${#a[100]}实际上是返回数组第100号成员a[100]的值（foo）的字符串长度。
## 提取数组序号
${!array[@]}或${!array[*]}，可以返回数组的成员序号，即哪些位置是有值的。
``` shell
arr=([5]=a [9]=b [23]=c)
echo ${!arr[@]}
```
上面例子中，数组的5、9、23号位置有值。  
利用这个语法，也可以通过for循环遍历数组。
``` shell
arr=(a b c d)
for i in ${!arr[@]};do
  echo ${arr[i]}
done
```
## 提取数组成员
${!array[@]:position:length}的语法可以提取数组成员。
``` shell
food=( apples bananas cucumbers dates eggs fajitas grapes )
echo ${food[@]:1:1}
echo ${food[@]:1:3}
```
上面例子中，${food[@]:1:1}返回从数组1号位置开始的1个成员，${food[@]:1:3}返回从1号位置开始的3个成员。  
如果省略长度参数length，则返回从指定位置开始的所有成员。  
``` shell
food=( apples bananas cucumbers dates eggs fajitas grapes )
echo ${food[@]:4}
```
## 追加数组成员
数组末尾追加成员，可以使用+=赋值运算符。它能够自动地把值追加到数组末尾。否则，就需要知道数组的最大序号，比较麻烦。  
``` shell
food=( a b c )
echo ${food[@]}
food+=( d e f)
echo ${food[@]}
```
## 删除数组
删除一个数组成员，使用unset命令。  
``` shell
foo=( a b c )
echo ${foo[@]}
unset foo[1]
echo ${foo[@]}
```
上面的例子中，删除了数组中的第二个元素。  
将某个成员设为空值，可以从返回值中'隐藏'这个成员。
``` shell
foo=( a b c )
echo ${foo[@]}
foo[1]=''
echo ${foo[@]}
```
上面例子中，将数组的第二个成员设置空字符串，数组的返回值中，这个成员就'隐藏'了。  
注意，这里是'隐藏'而不是删除，因为这个成员仍然存在，只是值变成了空值。
``` shell
foo=(a b c d e f)
foo[1]=''
echo ${#foo[@]}
echo ${!foo[@]}
```
上面代码中，第二个成员设为空值后，数组仍然包含6个成员。  
直接将数组变量赋值为空字符串，相当于'隐藏'数组的第一个成员。
``` shell
foo=(a b c d e f)
foo[1]=''
echo ${foo[@]}
```
unset array 可以清空整个数组。  
``` shell
foo=(a b c d e f)
unset foo
echo ${foo[@]}
```
## 关联数组
Bash的新版本支持关联数组，关联数组使用字符串而不是整数作为整数索引。  
declare -A 可以声明关联数组。  
``` shell
declare -A colors
colors["red"]="#ff0000"
colors["green"]="#00ff00"
colors["blue"]="#0000ff"
echo ${colors[@]}
```
关联数组必须用带有-A选项的declare命令声明创建。相比之下，整数索引的数组，可以直接使用变量名创建数组，关联数组就不行。  
访问关联数组成员的方式，几乎与整数索引数组相同。  
``` shell
declare -A colors
colors["red"]="#ff0000"
colors["green"]="#00ff00"
colors["blue"]="#0000ff"
echo ${colors["blue"]}
```