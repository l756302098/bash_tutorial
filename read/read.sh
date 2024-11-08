#!/bin/bash
# echo -n "输入一些文本 > "
# read text
# echo "你的输入: $text"

# echo Please, enter your firstname and lastname
# read FN LN
# echo "H! $LN, $FN !"

# echo Please, enter your firstname and lastname
# read
# echo "H! $REPLY !"

# filename='/etc/hosts'
# while read line
# do
#     echo "$line"
# done < $filename

# echo -n "输入一些文本 >"
# if read -t 3 response; then
#     echo "用户已经输入了 $response"
# else
#     echo "用户没有输入"
# fi

# read -p "Enter one or more values >"
# echo "REPLY = '$REPLY'"

# read -a people
# echo ${people[1]}

# read -n 3 data
# echo -e "\n$data"

# echo Please input the path to the file:
# read -e filename
# echo $filename

# FILE=/etc/passwd

# read -p "Enter a username > " user_name
# file_info="$(grep "^$user_name:" $FILE)"

# if [ -n "$file_info" ]; then
#     IFS=":" read user pw uid gid name home shell <<< """$file_info"
#     echo "user = $user"
#     echo "pw = $pw"
#     echo "uid = $uid"
#     echo "gid = $gid"
#     echo "name = $name"
#     echo "home = $home"
#     echo "shell = $shell"
# else
#     echo "No such user '$user_name'" 1>&2
#     exit 1
# fi

FILE=/etc/passwd

read -p "Enter a username > " user_name
file_info="$(grep "^$user_name:" $FILE)"

if [ -n "$file_info" ]; then
    IFS=":"
    read user pw uid gid name home shell <<< """$file_info"
    IFS="$OLD_IFS"
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
