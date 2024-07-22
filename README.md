# pnadc_import

## Geral

O repositório tem os códigos que forma usados para pegar os dados do 
FTP do IBGE para a PNAD Contínua e preparar as visitas nos dados anuais.

Esse arquivos lidos dos microdados são convertidos para o formato parquet e
deixados prontos para se trabalhar com os arquivos nos projetos da equipe do
Atlas do Estado.


## Repo

Vamos primeiro executar o passo a passo no codigo 01 e depois serão geradas
funções de apoio, e por último, a função completa de preparação dos microdados
para parquet.

Não é possível baixar os dados pelo pacote pnadc_ibge dentro do Ipea, logo 
trazemos um espleho da parte de microdados da Pnad COntínua para o nosso 
servidor de dados via FileZilla, um software gerenciador de FTPs.



