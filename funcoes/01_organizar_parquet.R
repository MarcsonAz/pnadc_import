# 01 - organizar arquivos em formato rds

# por agora, o codigo 01 , principal, main

require(pacman)

p_load(
  c('PNADcIBGE','dplyr','fs','stringr','survey'),
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





#### TRIMESTRAL ####


require(pacman)

p_load(
  c('PNADcIBGE','dplyr','fs'),
  character.only = TRUE
)

source('./funcoes/funcoes_apoio.R')

ANO = 2024
TRIMESTRE = 1

data_path = paste0("./../Trimestral/Microdados/",ANO,"/PNADC_0",TRIMESTRE,ANO,".Zip")

input_path = "./../Trimestral/Microdados/Documentacao/input_PNADC_trimestral.txt"

var_list = c("V2009","V4009","V4019","V4032",
              "VD4001","VD4002","VD4003","VD4009","VD4012")

pnadc.df <- read_pnadc(microdata=data_path, 
                       input_txt=input_path, 
                       vars=var_list)


## usar o pacote arrow para salvar

diretorio_microdados_parquet= "./../parquet/"

nome_arquivo = paste0(
  diretorio_microdados_parquet,"arquivo_microdados_",ANO,"_trimestral_t",TRIMESTRE,"_teste.parquet"
)
arrow::write_parquet(pnadc.df,nome_arquivo)




### antigo
### antigo
### antigo
### antigo




#### nova proposta


# library(readr)
# library(arrow)
# library(dplyr)
# 
# process_zip_files <- function(dir1, dir2) {
#   # Lista todos os arquivos zip na pasta dir1
#   arquivos_compacto <- listar_arq_pnadc_tri_compactos()
#   
#   for (zip_file in arquivos_compacto) {
#     # Cria uma pasta temporária para descompactar os arquivos
#     temp_dir <- tempdir()
#     unzip(zip_file, exdir = temp_dir)
#     
#     # Lista todos os arquivos descompactados
#     extracted_files <- list.files(temp_dir, full.names = TRUE)
#     
#     for (file in extracted_files) {
#       # Lê a planilha usando readr
#       data <- read_csv(file)
#       
#       # Seleciona as colunas col1, col2 e col3
#       selected_data <- data %>% select(col1, col2, col3)
#       
#       # Define o nome do arquivo parquet
#       parquet_file <- file.path(dir2, paste0(tools::file_path_sans_ext(basename(file)), ".parquet"))
#       
#       # Salva o dataframe em formato parquet
#       write_parquet(selected_data, parquet_file)
#     }
#   }
# }
# 
# # Exemplo de uso
# dir1 <- "caminho/para/dir1"
# dir2 <- "caminho/para/dir2"
# process_zip_files(dir1, dir2)


#Certifique-se de ajustar os caminhos `dir1` e `dir2` para os diretórios corretos onde os arquivos zip estão localizados e onde você deseja salvar os arquivos parquet.

#Se precisar de mais alguma coisa ou tiver alguma dúvida, estou à disposição!




#data_path = encontra_pnadc(ano=ANO,caminho=diretorio_microdados(n_visita = VISITA))
#input_path = encontra_input_pnadc(ano=ANO,caminho=diretorio_microdados(n_visita = VISITA))

