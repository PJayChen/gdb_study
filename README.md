gdb_study
=========

gdb study note


example_1.s
-----------
Basic ARM assembly program
run it on QEMU and use gdb to read the register content

gdb command
------------

file <machine code file>:  要被debug的file
l, list: 列出程式碼
c: 執行至下一個中斷點
info reg: show registers content

Reference
----------
makefile:
http://tetralet.luna.com.tw/?op=ViewArticle&articleId=185

gdb:
http://www.cis.nctu.edu.tw/~is93007/acd.htm
