# Renomear boletos 📄
### Sistema para renomear boletos PDF, em lote | Lazarus / Delphi (Objeto Pascal)

##

Desenvolvi um *sistema para renomear boletos em lote* na linguagem **Lazarus** (Objeto Pascal) para resolver um problema interno na empresa onde trabalho (em 2021).

Existia um processo manual nessa empresa que se resumia em: </br>
Após receber os boletos do banco para enviar aos clientes; </br>
Os boletos vinham todos em um único PDF (podendo chegar até 4.000 boletos/mês); </br>
A maioria desses boletos eram impressos e; </br>
Escaneados um a um; </br>
Após isso renomeados **manualmente** com o respectivo nome do cliente; </br>
Para ser enviado via e-mail. </br>
Uma outra parte era enviada via correio. </br>

**Tudo isso ocorria por carência de tecnologia qualificada e aplicada.**

Indignado com esse processo, passei alguns dias pensando o que fazer para ajudar; então tive a ideia de desenvolver esse sistema.

E o processo que durava cerca de duas semanas, **passou a durar menos de dez minutos!**


##

Abaixo está a lógica do sistema:

##

**1º Dividir os boletos**

![1º Dividir](https://github.com/amancio10/Renomear-boletos/assets/48102777/4e11527b-a625-42a1-92f2-68130fd70cce)

Para dividir os boletos estou utilizando o site *I Love PDF*.

![1º Dividir I Love PDF](https://github.com/amancio10/Renomear-boletos/assets/48102777/23dfa203-9e67-4f35-b58b-244ab7ead27b)

![1 1º Dividir PDF](https://github.com/amancio10/Renomear-boletos/assets/48102777/d9388be5-5331-4852-bf43-63f26db77fa4)

##

**2º Apagar as capas**

![2º Apagar capas](https://github.com/amancio10/Renomear-boletos/assets/48102777/dc263f22-817c-4a4b-8547-411b1490bb6b)

Apos ter migrado de *banco*, não foi mais necessária a exclusão de capas, por isso desabilitei essa função do sistema.

##

**3º Converter**

![3º Converter](https://github.com/amancio10/Renomear-boletos/assets/48102777/cf114d28-70b9-4eae-a421-347eccec638b)

![3 1º Converter](https://github.com/amancio10/Renomear-boletos/assets/48102777/dbb93815-94ef-464d-8994-191ec1958a6a)

![3 2º Converter](https://github.com/amancio10/Renomear-boletos/assets/48102777/a30c0800-0b8a-46a2-a018-562d5242a809)


Agora que convertemos os arquivos para .TXT podemos extrair os dados deles. </br>
Respeitando a posição inicial do bloco de notas como 1 (um) e dos códigos como 0 (zero).

![Identificador dos campos](https://github.com/amancio10/Renomear-boletos/assets/48102777/44372285-de6f-4a81-b1ab-42e19bb15897)

##

**4º Renomear**

Antes de renomear precisamos preencher os dados solicitados.

![4º Renomear](https://github.com/amancio10/Renomear-boletos/assets/48102777/448ef1d3-5733-4fd3-ab85-0c2fba8f5606)

Por fim é só clicar em "renomear" e ver a mágica acontecer!

![4 1 º Renomear](https://github.com/amancio10/Renomear-boletos/assets/48102777/43747546-7861-46dd-8fde-12a8ce3aceb0)
