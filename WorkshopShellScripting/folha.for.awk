awk 'BEGIN { print "Relacao de Proventos\n" ; Titulo="   Nome: Salario:   Extra: Anuenio: " }
    {
    for ( i = 1; i <= NF; i++ )
	{
	print substr (Titulo, (i - 1) * 9 + 1, 9), $i
	}
    printf "\n"
    }' funcionarios

