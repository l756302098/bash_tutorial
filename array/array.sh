#!/bin/bash
array[0]=val
array[1]=val
array[2]=val

foo=(1 b c d e f)
echo ${foo[@]}
echo ${foo[*]}

# activities=( swimming "water skiing" canoeing "white-water rafting" surfing )
# for act in ${activities[@]}; do
#     echo "Activity: $act"
# done

# activities=( swimming "water skiing" canoeing "white-water rafting" surfing )
# for act in "${activities[@]}"; do
#     echo "Activity: $act"
# done

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

arr=(a b c d)
for i in ${!arr[@]};do
  echo ${arr[i]}
done

food=( apples bananas cucumbers dates eggs fajitas grapes )
echo ${food[@]:1:1}
echo ${food[@]:1:3}
echo ${food[@]:4}

food=( a b c )
echo ${food[@]}
food+=( d e f)
echo ${food[@]}

foo=( a b c )
echo ${foo[@]}
unset foo[1]
echo ${foo[@]}

foo=( a b c )
echo ${foo[@]}
foo[1]=''
echo ${foo[@]}

foo=(a b c d e f)
foo[1]=''
echo ${#foo[@]}
echo ${!foo[@]}

foo=(a b c d e f)
foo[1]=''
echo ${foo[@]}

foo=(a b c d e f)
unset foo
echo ${foo[@]}

declare -A colors
colors["red"]="#ff0000"
colors["green"]="#00ff00"
colors["blue"]="#0000ff"
echo ${colors[@]}
echo ${colors["blue"]}
