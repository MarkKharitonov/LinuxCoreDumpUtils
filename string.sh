#!/bin/bash
if [ -z $1 ]; then
    echo "Usage: $0 address [dst_file_path]"
    exit 1
fi

StringAddr=$1
if [[ $StringAddr != 0x* ]];
then
    StringAddr=0x$1
fi

FileName=$2
if [ -z $FileName ]; then
    FileName="string@${StringAddr}.txt"
fi

StringLength=$(lldb -b -o "dumpobj $StringAddr" -c core_20220303_012350 dotnet | grep _stringLength | tr -s ' ' | cut -d' ' -f7)
ByteLength=$(($StringLength * 2))
FirstByteAddr=$(printf "0x%X\n" $(($StringAddr + 0xC)))
lldb -b -o "x -c$ByteLength -b -o $FileName --force $FirstByteAddr" -c core_20220303_012350 dotnet
