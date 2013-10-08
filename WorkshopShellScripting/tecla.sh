getc ()
{
stty raw
eval $1="`dd bs=1 count=1 2>/dev/null | tr '\015' '\012'`"
stty cooked
}

echo "Digite uma opcao: \c"
getc anychar

echo \\n\\n\\n$anychar\\n\\n\\n
