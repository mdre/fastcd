#!/usr/bin/fish
function fcd

    # verificar que exista el directorio
    if  test ! -d ~/.fcd 
        mkdir ~/.fcd
    end

    # verificar que exista la base
    if test ! -e ~/.fcd/visited.dir 
        touch ~/.fcd/visited.dir
    end

    # liberar las variables
    set -e FULLLIST
    set -e HELP
    set -e LLIST
    set -e LPATTERN
    set -e PATTERN

    # parsear los param.
    # esto crea las variables _flag_h y las otras y deja el resto en argv
    argparse 'h/help' 'l/list' 'L/LPATTERN' -- $argv

    set PATTERN $argv

    
    if set -q _flag_h
        echo "fcd: idem like cd command but can jump to previous "
        echo "     visited directories using a the last name."
        echo ""
        echo "to use add this line to .bashrc"
        echo "alias fcd='. /path-to-script-dir/fastcd'"
        echo ""
        echo "Example:"
        echo "#First time: "
        echo "fcd /usr/share/okular/"
        echo "# and next time just type the final dir"
        echo "fcd okular"
        echo
        echo "PARAMETERS:"
        echo "-h: this help"
        echo "-l: full list of recorded directories"
        echo "-L <pattern>: list of directories that match the pattern"
        echo ""
        return 0
    end

    if set -q _flag_l
        #echo "Full list: $FULLLIST"
        cat ~/.fcd/visited.dir
        return 0
    end

    if set -q _flag_L
        echo "subpattern: $PATTERN"
        grep "$PATTERN" ~/.fcd/visited.dir
        return 0
    end


    # listar el contenido de la base.

    # buscar en la base la primera línea que corresponda.
    set LINENUM (grep -oE '[^/]+$' ~/.fcd/visited.dir | grep -n -m 1 $PATTERN | cut -d : -f 1)

    # si LINENUM existe y no esta vacía
    if test -n "$LINENUM"
        set NEWDIR (sed $LINENUM"q;d" ~/.fcd/visited.dir)
        cd $NEWDIR
    else
        # no se encontró nada en la base. Verificar si el parámetro
        # es un directorio accesible
        if test -d $PATTERN
            cd $PATTERN
            set NEWDIR (pwd)   
            echo $NEWDIR >>~/.fcd/visited.dir
        else 
            # no se encontró
            # provocar el fallo
            return (cd $PATTERN)
            
        end

    end

end