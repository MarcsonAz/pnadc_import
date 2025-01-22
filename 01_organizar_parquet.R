# 01 - organizar arquivos em formato parquet.

# por agora, o codigo 01 , principal, main

require(pacman)

p_load(
  c('PNADcIBGE','dplyr','fs','stringr'),
  character.only = TRUE
)

source('./funcoes/funcoes_apoio.R')

#### ANUAL ####

#diretorio_microdados_v1
## pegar dados da Pnad Continua de 2022, visita 1

ANO = 2023
VISITA = 1


data_path = encontra_pnadc(ano=ANO,caminho=diretorio_microdados(VISITA))
input_path = encontra_input_pnadc(ano=ANO,caminho=diretorio_microdados(VISITA))

pnadc.df <- read_pnadc(microdata=data_path, 
                       input_txt=input_path, 
                       vars=c("VD4001","VD4002"))


## usar o pacote arrow para salvar


diretorio_microdados_parquet= "./../parquet/"
ano = 2022
visita = 1
nome_arquivo = paste0(
  diretorio_microdados_parquet,"arquivo_microdados_",ANO,"_anual_v",VISITA,"_teste.parquet"
)
arrow::write_parquet(pnadc.df,nome_arquivo)





#### TRIMESTRAIS ####


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




#### nova proposta


library(readr)
library(arrow)
library(dplyr)

process_zip_files <- function(dir1, dir2) {
  # Lista todos os arquivos zip na pasta dir1
  arquivos_compacto <- listar_arq_pnadc_tri_compactos()
  
  for (zip_file in arquivos_compacto) {
    # Cria uma pasta temporária para descompactar os arquivos
    temp_dir <- tempdir()
    unzip(zip_file, exdir = temp_dir)
    
    # Lista todos os arquivos descompactados
    extracted_files <- list.files(temp_dir, full.names = TRUE)
    
    for (file in extracted_files) {
      # Lê a planilha usando readr
      data <- read_csv(file)
      
      # Seleciona as colunas col1, col2 e col3
      selected_data <- data %>% select(col1, col2, col3)
      
      # Define o nome do arquivo parquet
      parquet_file <- file.path(dir2, paste0(tools::file_path_sans_ext(basename(file)), ".parquet"))
      
      # Salva o dataframe em formato parquet
      write_parquet(selected_data, parquet_file)
    }
  }
}

# Exemplo de uso
dir1 <- "caminho/para/dir1"
dir2 <- "caminho/para/dir2"
process_zip_files(dir1, dir2)


#Certifique-se de ajustar os caminhos `dir1` e `dir2` para os diretórios corretos onde os arquivos zip estão localizados e onde você deseja salvar os arquivos parquet.

#Se precisar de mais alguma coisa ou tiver alguma dúvida, estou à disposição!












