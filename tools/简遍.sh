#!/usr/bin/env bash

# 简单遍历档夹

for d in */ ; do
    echo "进$d ..."
    pushd $d
    #ls *.mp3
    #rm *.txt
    #rename 's/ *//g' *
    printf "file %s\n" *.mp3 > i${d:0:2}.txt
    ffmpeg -f concat -i i${d:0:2}.txt -aq 2 ../va${d:0:2}.ogg
    popd
    echo "出$d ..."
done
