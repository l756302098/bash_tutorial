#!/bin/bash
# set -x

# echo $a
# echo bar

# set -e

# foo | echo a
# echo bar

# set -eo pipefail

# foo | echo a
# echo bar

# set -e

# trap "echo ERR trap fired!" ERR

# myfunc()
# {
#   # 'foo' 是一个不存在的命令
#   foo
# }

# myfunc

set -Eeuo pipefail

trap "echo ERR trap fired!" ERR

myfunc()
{
  # 'foo' 是一个不存在的命令
  foo
}

myfunc