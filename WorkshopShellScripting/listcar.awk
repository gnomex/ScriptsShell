awk '
BEGIN  { printf "%15s %10s %9s %7s %10s\n",
                "Modelo", "Vel.Max.", "0 a 100", "Cons.", "Preco" }
{ printf "%15s %7s %11s %8s %11s\n",
          $1, $2, $3, $4, $5
  VelM = VelM + $2 ; Pr = Pr + $5 }
END { printf "\n%7s\n%10s %7s\n%5s %10s\n",
             "MEDIAS:", "Velocidade", VelM / NR, "Preco", Pr / NR }' carros

