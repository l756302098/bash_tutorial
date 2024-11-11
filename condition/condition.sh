#!/bin/bash
if test $USER = "foo";  then
# 等价 
#if [ $USER = "foo" ];  then
    echo "hello foo."
else
    echo "Who are you."
fi

if true; then
    echo "it is true."
fi

if false
then
    echo "it is false."
fi


if true; then echo "it is true."; fi

if echo "hi."; then echo "it is true."; fi

if echo "hi.";false;echo "start"; then echo "it is true."; fi

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

# INT=-5
# if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
#     echo "INT is an integer."
#     exit 0
# else
#     echo "INT is not an integer."
#     exit 1
# fi

# MIN_VAL=1
# MAX_VAL=100

# INT=50

# if [[ $INT =~ ^-?[0-9]+$ ]]; then
#     echo ""
#     if [[ $INT -ge $MIN_VAL && $INT -le $MAX_VAL ]]; then
#         echo "$INT is within $MIN_VAL to $MAX_VAL"
#     else
#         echo "$INT is out of range."
#     fi
# else
#     echo "INT is not an integer." >&2
#     exit 1
# fi

MIN_VAL=1
MAX_VAL=100

INT=50
if [ ! \( $INT -ge $MIN_VAL -a $INT -le $MAX_VAL \) ]; then
    echo "$INT is outside $MIN_VAL to $MAX_VAL."
else
    echo "$INT is in range."
fi

if (( 3 > 2 )); then
    echo true
fi

filename=$1
word1=$2
word2=$3

# if grep $word1 $filename && grep $word2 $filename; then
#     echo "$word1 and $word2 are both in $filename." 
# fi


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

OS=$(uname -s)

case "$OS" in
  FreeBSD) echo "This is FreeBSD" ;;
  Darwin) echo "This is Mac OSX" ;;
  AIX) echo "This is AIX" ;;
  Minix) echo "This is Minix" ;;
  Linux) echo "This is Linux" ;;
  *) echo "Failed to identify this OS" ;;
esac