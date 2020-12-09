lex_file=lex.yy.c
yacc_file=y.tab.c
yacc_header_file=y.tab.h
exec_file=calc

if test -f "$yacc_file"
then
    rm $yacc_file $yacc_header_file
fi

if test -f "$lex_file"
then
    rm $lex_file
fi

if test -f "$exec_file"
then
    rm $exec_file
fi

yacc -dt ./calc.y
lex calc.lex

if test -f "$yacc_file" 
then
    echo "Yacc file good"
else
    exit 1
fi
if test -f "$lex_file" 
then
    echo "Lexx file good"
else
    exit 1
fi
gcc y.tab.c lex.yy.c -o $exec_file
if test -f "$yacc_file" 
then
    ./$exec_file
else
     exit 1
 fi