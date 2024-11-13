#!/bin/bash
# trouble: script to demonstrate common errors

number=1
if [ $number = 1 ]; then
  echo "Number is equal to 1."
else
  echo "Number is not equal to 1."
fi

echo "This is line $LINENO"

# function func1()
# {
#   echo "func1: FUNCNAME0 is ${FUNCNAME[0]}"
#   echo "func1: FUNCNAME1 is ${FUNCNAME[1]}"
#   echo "func1: FUNCNAME2 is ${FUNCNAME[2]}"
#   func2
# }

# function func2()
# {
#   echo "func2: FUNCNAME0 is ${FUNCNAME[0]}"
#   echo "func2: FUNCNAME1 is ${FUNCNAME[1]}"
#   echo "func2: FUNCNAME2 is ${FUNCNAME[2]}"
# }

# func1


source lib1.sh
source lib2.sh
func1