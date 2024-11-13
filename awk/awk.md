# awk 命令
一种文本模式扫描和处理语言，由 Aho、Weinberger 和 Kernighan 创建（因此
名称）。它可能非常复杂，因此这不是完整的指南，但应该可以让您体验一下
awk 可以做什么。它使用起来非常简单，强烈推荐。有许多
不同复杂程度的在线教程，当然，总是有“man awk”。 
## 基本用法
awk 程序对输入文件的每一行进行操作。它可以有一个可选的 BEGIN{} 部分
在处理文件的任何内容之前完成的命令，然后 main {} 部分起作用
文件的每一行，最后有一个可选的 END{} 操作部分，发生在
文件读取已完成：  
``` shell
BEGIN { …. initialization awk commands …}
{ …. awk commands for each line of the file…}
END { …. finalization awk commands …}
```
对于输入文件的每一行，它会查看是否有任何模式匹配指令，在这种情况下
仅对与该模式匹配的行进行操作，否则对所有行进行操作。这些
与 grep 一样，“模式匹配”命令可以包含正则表达式。 awk 命令可以
做一些相当复杂的数学和字符串操作，awk 还支持关联
数组。
AWK 将每一行视为由许多字段组成，每个字段由“字段”分隔
分隔符'。默认情况下，这是一个或多个空格字符，因此这一行：
``` txt
this is a line of text
```
包含 6 个字段。在 awk 中，第一个字段被称为 $1，第二个字段被称为 $2，等等，整个
行称为 $0。字段分隔符由 awk 内部变量 FS 设置，因此如果设置 FS=”:” 那么
它将根据 ':' 的位置划分一行，这对于 /etc/passwd 这样的文件很有用
其他有用的内部变量是 NR，它是当前记录号（即行号）
输入文件）和 NF（当前行中的字段数）。  
AWK 可以对任何文件进行操作，包括 std-in，在这种情况下它通常与“|”一起使用命令，
例如，与 grep 或其他命令结合使用。例如，如果我列出 a 中的所有文件
像这样的目录：
``` shell
ls -l
# total 8
# -rw-rw-r-- 1 li li 2047 11月 13 12:21 awk.md
# -rwxrwxr-x 1 li li   28 11月  5 10:34 awk.sh
# -rw-rw-r-- 1 li li    0 11月 13 12:22 normal_rand.agr
# -rw-rw-r-- 1 li li    0 11月 13 12:22 random_numbers.f90
# -rw-rw-r-- 1 li li    0 11月 13 12:22 uniform_rand_231.agr
# -rw-rw-r-- 1 li li    0 11月 13 12:22 uniform_rand_232.agr
# -rw-rw-r-- 1 li li    0 11月 13 12:23 uniform_rand_period_1.agr
# -rw-rw-r-- 1 li li    0 11月 13 12:23 uniform_rand_period_2.agr
# -rw-rw-r-- 1 li li    0 11月 13 12:23 uniform_rand_period_3.agr
# -rw-rw-r-- 1 li li    0 11月 13 12:23 uniform_rand_period_4.agr
# -rw-rw-r-- 1 li li    0 11月 13 12:23 uniform_rand_period.agr
```
可以看到文件大小报告为第五列数据。所以如果我想知道所有的总大小
该目录中的文件我可以执行以下操作：  
``` shell
ls -l | awk 'BEGIN {sum=0} {sum=sum+$5} END {print sum}'
```
请注意，“print sum”打印变量 sum 的值，因此如果 sum=2，则“print sum”给出
输出“2”，而“print $sum”将打印“1”，因为第二个字段包含值“1”。  
因此，编写一个 awk 命令来计算平均值和
一列数字的标准差 – 您在主函数中累积“sum_x”和“sum_x2”
部分，然后使用标准公式计算 END 部分的平均值和标准差。  
AWK 提供对循环（“for”和“while”）和分支（使用“if”）的支持。所以如果你
想要修剪文件并仅对每第三行进行操作，您可以这样做：
``` shell
ls -l | awk '{for (i=1;i<3;i++) {getline};print NR,$0}'
```
其中“for”循环使用“getline”命令在文件中移动，并且仅每第三次打印一次
线。注意，可以看到我们也打印了使用 NR 变量输出行号。
## 模式匹配
AWK 是一种面向行的语言。首先是模式，然后是行动。动作语句是
包含在 { 和 } 中。要么模式可能缺失，要么动作可能缺失，但是，当然，
两者都不是。如果模式丢失，则针对每个输入记录执行该操作。一个失踪的
操作打印整个记录。  
AWK 模式包括正则表达式（使用与“grep -E”相同的语法）和使用的组合
特殊符号“&&”表示“逻辑与”、“||”表示“逻辑或”，“！”意思是“逻辑非”。你
还可以做关系模式、模式组、范围等。 
``` shell
if (condition) statement [ else statement ]
while (condition) statement
do statement while (condition)
for (expr1; expr2; expr3) statement
for (var in array) statement
break
continue
exit [ expression ]
```
### AWK input/output statements include:
类型    | 描述  
------- | ---------- 
close(file [, how])    |   Close file, pipe or co-process.
getline    |   Set $0 from next input record.
getline <file    |   Set $0 from next record of file.
getline var    |   Set var from next input record.
getline var <file    |   Set var from next record of file.
next    |   Stop processing the current input record. The next input record is read and processing starts over with the first pattern in the AWK program. If the end of the input data is reached, the END block(s),if any, are executed.
nextfile    |   Stop processing the current input file. If the endof the input data is reached, the END block(s), if
any, are executed.
print    |   Prints the current record.
print expr-list    |   Prints expressions.
print expr-list>file    |   Prints expressions on file.
printf fmt,expr-list    |   Format and print.
### AWK numeric functions include:
类型    | 描述  
------- | ---------- 
atan2(y, x)    |   Returns the arctangent of y/x in radians.
cos(expr)    |   Returns the cosine of expr, which is in radians.
exp(expr)    |   The exponential function.
int(expr)    |   Truncates to integer.
log(expr)    |   The natural logarithm function.
Rand()    |   Returns a random number N, between 0 and 1, such that 0 <= N < 1.
sin(expr)    |   Returns the sine of expr, which is in radians.
sqrt(expr)    |   The square root function.
srand([expr])    |  Uses expr as a new seed for the random number generator. If no expr is provided, the time of day is used.
### AWK string functions include:
类型    | 描述  
------- | ---------- 
gsub(r, s [, t])    |   For each substring matching the regular expression r in the string t,substitute the string s, and return the number of substitutions. If t is not supplied, use $0.
index(s, t)    |   Returns the index of the string t in the string s, or 0 if t is not present.
length([s])    |   Returns the length of the string s, or the length of $0 if s is not supplied.
match(s, r [, a])    |   Returns the position in s where the regular expression r occurs, or 0 if r is not present.
split(s, a [, r])    |   Splits the string s into the array a using the regular expression r, and returns the number of fields. If r is omitted, FS is used instead.
sprintf(fmt,expr-list)    |   Prints expr-list according to fmt, and returns the resulting string.
strtonum(str)    |   Examines str, and returns its numeric value.
sub(r, s [, t])    |   Just like gsub(), but only the first matching substring is replaced.
substr(s, i [, n])    |   Returns the at most n-character substring of s starting at i. If n is omitted, the rest of s is used.
tolower(str)    |   Returns a copy of the string str, with all the upper-case characters in str translated to their corresponding lower-case counterparts.Non-alphabetic characters are left unchanged.
length([s])    |   Returns a copy of the string str, with all the lower-case characters in str translated to their corresponding upper-case counterparts.Non-alphabetic characters are left unchanged.