#!/bin/bash
OutFileName=$(echo $* | sed "s,[ \\/],_,g").output.txt
lldb -b -o "$*" -c core_20220303_012350 dotnet > $OutFileName
echo cat $OutFileName
