# sed 命令
sed = stream editor
sed 对输入流（文件或来自管道的输入）执行基本文本转换单次通过流，因此非常高效。然而，sed 能够过滤文本
它与其他类型的编辑器特别不同的管道。
## 基本使用
将下列内容粘贴复制到a.txt文件中。
``` txt
please input your name.
my name is sed tutorial.
```
sed 可以在命令行或 shell 脚本中使用，以非交互方式编辑文件。也许
最有用的功能是对一个字符串进行“搜索并替换”到另一个字符串。  
您可以使用“-e”选项将 sed 命令嵌入到调用 sed 的命令行中，或者
将它们放在单独的文件中，例如'sed.in' 并使用 '-f sed.in' 选项调用 sed。后一个选项是
如果 sed 命令很复杂并且涉及大量正则表达式，则最常用！例如：
``` shell
sed -e 's/input/output/' a.txt
```
将从 a.txt 的每一行回显到标准输出，更改每个行上第一次出现的“输入”
行进入“输出”。注意 sed 是面向行的，因此如果您希望更改每行上的每个出现位置，
那么你需要将其设为“贪婪”搜索和替换，如下所示：
``` shell
sed -e 's/input/output/g' a.txt
```
/.../ 中的表达式可以是文字字符串或正则表达式。  
注意：默认情况下，输出会写入 stdout。您可以将其重定向到一个新文件，或者如果您愿意
编辑现有文件，您应该使用“-i”标志：
``` shell
sed -e 's/input/output/' a.txt > b.txt
```
## 正则表达式
如果您希望在搜索命令中使用的字符之一是特殊符号（例如“/”）怎么办
（例如在文件名中）或“*”等？然后您必须像 grep（和 awk）一样转义该符号。说你
想要编辑 shell 脚本以引用 /usr/local/bin 而不是 /bin ，那么你可以这样做
``` shell
sed -e 's/\/bin/\/usr\/local\/bin/' my_script > new_script
```
如果您想使用通配符作为搜索的一部分该怎么办 - 如何编写输出字符串？你
需要使用与找到的模式相对应的特殊符号“&”。所以说你想拿
文件中以数字开头并用括号将该数字括起来的每一行：
``` shell
sed -e 's/[0-9]*/(&)/' my_file
```
其中 [0-9] 是所有单位数字的正则表达式范围，“*”是重复计数，表示任何
位数。  
您还可以在正则表达式中使用位置指令，甚至将部分匹配保存在
模式缓冲区可在其他地方重用。