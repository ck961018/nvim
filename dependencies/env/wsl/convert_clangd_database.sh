#!/bin/bash

# 指定compile_commands.json文件路径
compile_commands_file=$1

# 检查文件是否存在
if [ ! -f "$compile_commands_file" ]; then
    echo "Error: $compile_commands_file 文件不存在."
    exit 1
fi

sed -i 's/\\\"//g' $compile_commands_file
sed -i 's/\(\\\\\|\\\)/\//g' $compile_commands_file

sed -i 's/\([A-Z]\):/\/mnt\/\l\1/g' $compile_commands_file

sed -i 's/\/mnt\/[^ \t]*\/\(cl\|clang++\)\.exe/\/usr\/bin\/c++/g' $compile_commands_file

sed -i 's/std[:=]c++/std=gnu++/g' $compile_commands_file
