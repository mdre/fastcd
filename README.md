# fastcd
A fast change director command that add new behavior to the bash cd
**fcd**: is like cd command but can jump to previous visited directories using a the last name.
To use add this line to `.bashrc`:

`alias fcd='. /path-to-script-dir/fastcd'`

### Parameters
`-h` show the help

`-l` list the database

`-L <pattern>`: list the reccords that match the pattern.

`<pattern>` pattern to search and jump to.

### Example:
### First time: 
`fcd /usr/share/okular/`
### and next time just type the final dir
`fcd okular`
### or
`fcd oku`

**fcd** use grep over the last part of the visited path so you can use any valid pattern. It jump to the first match it find or, if it fail to match, it try to cd to the parameter. If the **cd** command is succefull it is added to the database.
The **visited** directory database can be found in `~/.fcd` directory.
