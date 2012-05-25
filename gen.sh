#!/bin/sh

rm cscope* 

find . -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files
cscope -bkq -i cscope.files

rm tags

ctags `find . -name "*.h" -o -name "*.c"` -a
