#
#  Conta Ocorrencias de Palavras
#

awk '{ 
     for (w = 1; w <= NF; w++) conta[$w] ++
     }
END  {
     for (w in conta) print conta[w], w | "sort -nr" 
     }' $1

