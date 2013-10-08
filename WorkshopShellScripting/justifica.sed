prompt$ chmod +x justifica.sed
prompt$ ./justifica.sed arquivo.txt &gt; arquivo-justificado.txt

se quiser alterar, o nzmero de colunas maximo, troque todos os 65
do script pelo nzmero desejado.

se  quiser  usar  no  vim,  selecione o texto com o modo visual e
:'&lt;,'&gt;!justifica.sed

ah!    esta    mensagem    foi    justificada    por    ele   &:)

justifica.sed

#!/bin/sed -f
# justify.sed
#
# it  gets  a text already wrapped on the desired number of columns
# and  add  extra  white  spaces, from left to right, word by word,
# to  justify  all  the lines. there is a maximum of 5 spaces to be
# inserted  between  the  words. if this limit is reached, the line
# is  not  justified  (come  on,  more  than  5 is horrible). empty
# lines  are  ignored.  btw, this comments were justified with this
# script &:)
#
# 20000715 &lt;aurelio@conectiva.com.br&gt;

# we'll only justify lines with less than 65 chars
/^.\{65\}/!{

  # cleaning extra spaces of the line
  s/^ \+//
  s/ \+/ /g
  s/ \+$//

  # don't try to justify blank lines
  /^$/b

  # backup of the line
  h

  # spaces -&gt; pattern
  # convert series of spaces to a internal pattern `n
  :s2p
  s/     /`5/g
  s/    /`4/g
  s/   /`3/g
  s/  /`2/g
  s/ /`1/g
  t 1space
  b

  # pattern -&gt; spaces
  # restore the spaces converted to the internal pattern `n
  :p2s
  s/`5/     /g
  s/`4/    /g
  s/`3/   /g
  s/`2/  /g
  s/`1/ /g
  t check
  b

  # check if we've reached our right limit
  # if not, continue adding spaces
  :check
  /^.\{65\}/!b s2p
  b

  # here's the "magic":
  # add 1 space to the first and minor internal pattern found.
  # this way, the extra spaces are always added from left to right,
  # always balanced, one by one.
  # right after the substitution, we'll restore the spaces and
  # test if our limit was reached.
  :1space
  s/`1/`2/ ; t p2s
  s/`2/`3/ ; t p2s
  s/`3/`4/ ; t p2s
  s/`4/`5/ ; t p2s

  # we don't want to justify with more than 5 added spaces between
  # words, so let's restore the original line
  /`5/x

}
