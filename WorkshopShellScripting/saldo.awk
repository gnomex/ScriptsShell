#
#   Calcula Saldo em Conta Corrente
#
awk '
    FILENAME == "creditos" { Saldo[$1] += $2 }
    FILENAME == "debitos"  { Saldo[$1] -= $2 }
END { for (Nome in Saldo)
    print Nome, Saldo [Nome]
    }' creditos debitos

