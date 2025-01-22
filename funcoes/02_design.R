# 02 - organizar design.

# por agora, o codigo 02

require(pacman)

p_load(
  c('PNADcIBGE','dplyr','fs','stringr'),
  character.only = TRUE
)

source('./funcoes/funcoes_apoio.R')

#### ANUAL ####

ANO = 2023
VISITA = 1

## ajustar diretorio

data_path = paste0("./../Anual/Microdados/Visita/Visita_",VISITA,
                   "/Dados/PNADC_",ANO,"_visita",VISITA,"_20241220.zip")

input_path = paste0("./../Anual/Microdados/Visita/Visita_",VISITA,
                    "/Documentacao/input_PNADC_",ANO,"_visita",VISITA,"_20241220.txt")

var_list = c("VD4001","VD4002")

pnadc.df <- read_pnadc(microdata=data_path, 
                       input_txt=input_path, 
                       vars=var_list)


## usar o pacote arrow para salvar


diretorio_microdados_parquet= "./../parquet/"

nome_arquivo = paste0(
  diretorio_microdados_parquet,"arquivo_microdados_",ANO,"_anual_v",VISITA,"_teste.parquet"
)
arrow::write_parquet(pnadc.df,nome_arquivo)

