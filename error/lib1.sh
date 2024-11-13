#!/bin/bash

# function func1()
# {
#   echo "func1: BASH_SOURCE0 is ${BASH_SOURCE[0]}"
#   echo "func1: BASH_SOURCE1 is ${BASH_SOURCE[1]}"
#   echo "func1: BASH_SOURCE2 is ${BASH_SOURCE[2]}"
#   func2
# }

function func1()
{
  echo "func1: BASH_LINENO is ${BASH_LINENO[0]}"
  echo "func1: FUNCNAME is ${FUNCNAME[0]}"
  echo "func1: BASH_SOURCE is ${BASH_SOURCE[1]}"

  func2
}