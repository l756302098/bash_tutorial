#!/bin/bash
# function func2()
# {
#   echo "func2: BASH_SOURCE0 is ${BASH_SOURCE[0]}"
#   echo "func2: BASH_SOURCE1 is ${BASH_SOURCE[1]}"
#   echo "func2: BASH_SOURCE2 is ${BASH_SOURCE[2]}"
# }

function func2()
{
  echo "func2: BASH_LINENO is ${BASH_LINENO[0]}"
  echo "func2: FUNCNAME is ${FUNCNAME[0]}"
  echo "func2: BASH_SOURCE is ${BASH_SOURCE[1]}"
}