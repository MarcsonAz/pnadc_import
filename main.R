# por agora, o codigo 01 , principal, main

require(pacman)

p_load(
  c('PNADcIBGE','dplyr','fs'),
  character.only = TRUE
)

source('./funcoes/funcoes_apoio.R')



diretorio_microdados_v1 = "./../Anual/Microdados/Visita/Visita_1/"
diretorio_microdados_v5 = "./../Anual/Microdados/Visita/Visita_5/"

#diretorio_microdados_v1
## pegar dados da Pnad Continua de 2022, visita 1

data_path = encontra_pnadc(ano=2022,caminho=paste0(diretorio_microdados_v1))
input_path = encontra_input_pnadc(ano=2022,caminho=paste0(diretorio_microdados_v1))

pnadc.df <- read_pnadc(microdata=data_path, 
                       input_txt=input_path, 
                       vars=c("VD4001","VD4002"))


## usar o pacote arrow para salvar


diretorio_microdados_parquet= "./../parquet/"
ano = 2022
visita = 1
nome_arquivo = paste0(
  diretorio_microdados_parquet,"arquivo_microdados_",2022,"_anual_v",visita,"_teste.parquet"
)
arrow::write_parquet(pnadc.df,nome_arquivo)





#### FAZER UM RESULTADO PARA OS DADOS TRIMESTRAIS


require(pacman)

p_load(
  c('PNADcIBGE','dplyr','fs'),
  character.only = TRUE
)

source('./funcoes/funcoes_apoio.R')



diretorio_microdados_T4 = "./../Trimestral/Microdados/2023/PNADC_042023.Zip"
diretorio_input = "./../Trimestral/Microdados/Documentacao/input_PNADC_trimestral.txt"
#diretorio_microdados_v5 = "./../Anual/Microdados/Visita/Visita_5/"

#diretorio_microdados_v1
## pegar dados da Pnad Continua de 2022, visita 1

#data_path = encontra_pnadc(ano=2022,caminho=paste0(diretorio_microdados_v1))
#input_path = encontra_input_pnadc(ano=2022,caminho=paste0(diretorio_microdados_v1))

lista_var = c("V2009","V4009","V4019","V4032",
              "VD4001","VD4002","VD4003","VD4009","VD4012")

pnadc.df <- read_pnadc(microdata=diretorio_microdados_T4, 
                       input_txt=diretorio_input, 
                       vars=lista_var)


## usar o pacote arrow para salvar


diretorio_microdados_parquet= "./../parquet/"
ano = 2023
trimestre = 4
nome_arquivo = paste0(
  diretorio_microdados_parquet,"arquivo_microdados_",ano,"_trimestral_t",trimestre,"_teste.parquet"
)
arrow::write_parquet(pnadc.df,nome_arquivo)

















