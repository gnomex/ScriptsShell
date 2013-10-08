awk '{
     Registros   [$1] = $0 
     Velocidades [$1] = $2
     }
END  {
     for ( Modelo in Velocidades )
          print Modelo, "\t", Velocidades[Modelo] | "sort"
     }' carros
