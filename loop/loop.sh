#!/bin/bash
number=1
while [ $number -lt 10 ]; do
    echo "number = $number"
    number=$((number+1))
done

for i in word1 word2 word3; do
  echo $i
done

for (( i=0;i<10;i++ )); do
    echo $i
done

for number in 1 2 3 4 5 6
do
  echo "number is $number"
  if [ "$number" = "3" ]; then
    break
  fi
done

# while read -p "What file do you want to test?" filename
# do
#   if [ ! -e "$filename" ]; then
#     echo "The file does not exist."
#     continue
#   fi

#   echo "You entered a valid file.."
# done

# select brand in Samsung Sony iphone symphony Walton
# do
#   echo "You have chosen $brand"
# done

echo "Which Operating System do you like?"

select os in Ubuntu LinuxMint Windows8 Windows10 WindowsXP
do
  case $os in
    "Ubuntu"|"LinuxMint")
      echo "I also use $os."
    ;;
    "Windows8" | "Windows10" | "WindowsXP")
      echo "Why don't you try Linux?"
    ;;
    *)
      echo "Invalid entry."
      break
    ;;
  esac
done