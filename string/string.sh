#!/bin/bash
myPath=$HOME
echo ${#myPath}

dstring=frontfooman
echo ${dstring:5:3}

dstring=frontfooman
echo ${dstring:5}

dstring=frontfooman
echo ${dstring: -5}
echo ${dstring: -5:2}
echo ${dstring: -5:-2}

myPath=/home/li/cam/book/long.file.name
echo ${myPath#/*/}
echo ${myPath##/*/}

myPath=/home/li/cam/book/long.file.name
echo ${myPath##*/}

phone=111-222-333
echo ${phone#*-}
echo ${phone##*-}

phone=111-222-333
echo ${phone#444}

${varname/#pattern/string}
foo=JPG.png
echo ${foo/#JPG/123}

myPath=/home/li/cam/book/long.file.name
echo ${myPath%.*}
echo ${myPath%%.*}

myPath=/home/li/cam/book/long.file.name
echo ${myPath%/*}

file=123.png
echo ${file%.png}.jpg

phone="111-222-333"
echo ${phone%-*}
echo ${phone%%-*}

path=/home/li/foo/foo.name
echo ${path/foo/bar}
echo ${path//foo/bar}

echo -e ${PATH//:/'\n'}

phone="111-222-333"
echo ${phone/1-2/-}

phone="111-222-333"
echo ${phone/1-2/}

path=/home/li/book/cook/cook.name
echo ${path/.*/}

path=/home/li/book/cook/cook.name
echo ${path/%.*/hello}
echo ${path/%.*/.hello}

foo=hello
echo ${foo^^}

bar=WORLD
echo ${bar,,}