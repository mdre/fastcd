# fastcd
A fast change director command that add new behavior to the bash cd
fcd: is like cd command but can jump to previous visited directories using a the last name.
To use add this line to .bashrc
alias fcd='. /path-to-script-dir/fastcd'

##Example:
##First time: 
fcd /usr/share/okular/
## and next time just type the final dir
fcd okular
## or
fcd oku
