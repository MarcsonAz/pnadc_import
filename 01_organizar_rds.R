# 01 - organizar arquivos em formato rds

# por agora, o codigo 01 , principal, main

require(pacman)

p_load(
  c('PNADcIBGE','dplyr','fs','stringr','survey'),
  character.only = TRUE
)

#source('./funcoes/funcoes_apoio.R')

#### ANUAL ####

ANO = 2023
VISITA = 1

## ajustar diretorio

data_path = paste0("./../Anual/Microdados/Visita/Visita_",VISITA,
                   "/Dados/PNADC_",ANO,"_visita",VISITA,"_20241220.zip")

input_path = paste0("./../Anual/Microdados/Visita/Visita_",VISITA,
                    "/Documentacao/input_PNADC_",ANO,"_visita",VISITA,"_20241220.txt")

dic_path = paste0("./../Anual/Microdados/Visita/Visita_",VISITA,
                  "/Documentacao/dicionario_PNADC_microdados_",ANO,"_visita",VISITA,"_20241220.xls")

def_path = paste0("./../Anual/Microdados/Visita/Documentacao_Geral/deflator_PNADC_",ANO,".xls")
                  
  
var_list = c("VD4001","VD4002")

pnadc.df <- read_pnadc(microdata=data_path, 
                       input_txt=input_path, 
                       vars=var_list)

### codigo para gerar survey design e variaveis auxiliares

#02_anual_variaveis_auxiliares.R
source('./02_anual_variaveis_auxiliares.R')
pnadc.df <- anual_variaveis_auxiliares(pnadc.df)

#03_anual_survey.R
source('./03_anual_survey.R')
pnadc.survey <- anual_survey(df = pnadc.df,
                             ano = ANO,
                             dic_path = dic_path,
                             def_path = def_path)


diretorio_rds= "./../rds/"

nome_arquivo = paste0(diretorio_rds,
                      "arquivo_survey_",ANO,"_anual_v",VISITA,".rds")

saveRDS(pnadc.survey,file=nome_arquivo)

rm(pnadc.df,pnadc.survey)
gc()


#### TRIMESTRAL ####


require(pacman)

p_load(
  c('PNADcIBGE','dplyr','fs'),
  character.only = TRUE
)

#source('./funcoes/funcoes_apoio.R')

ANO = 2023
TRIMESTRE = 4

data_path = paste0("./../Trimestral/Microdados/",ANO,"/PNADC_0",TRIMESTRE,ANO,".Zip")

input_path = "./../Trimestral/Microdados/Documentacao/input_PNADC_trimestral.txt"

dic_path = "./../Trimestral/Microdados/Documentacao/dicionario_PNADC_microdados_trimestral.xls"

def_path = "./../Trimestral/Microdados/Documentacao/deflator_PNADC_2024_trimestral_070809.xls"

var_list = c("UF","V1022","V2007","V2010","V2009","V4009","V4019","V4032",
             "VD4001","VD4002","VD4003","VD4009","VD4012","VD4007","VD4016",
             "VD4031")

pnadc.df <- read_pnadc(microdata=data_path, 
                       input_txt=input_path, 
                       vars=var_list)

### codigo para gerar survey design e variaveis auxiliares

#02_trimestral_variaveis_auxiliares.R
source('./02_trimestral_variaveis_auxiliares.R')
pnadc.df <- trimestral_variaveis_auxiliares(pnadc.df)


#03_trimestral_survey.R
source('./03_trimestral_survey.R')
pnadc.survey <- trimestral_survey(pnadc.df,
                                  dic_path = dic_path,
                                  def_path = def_path)

diretorio_rds= "./../rds/"

nome_arquivo = paste0(diretorio_rds,
                      "arquivo_survey_",ANO,"_trimestral_t",VISITA,".rds")

saveRDS(pnadc.survey,file=nome_arquivo)

rm(pnadc.df,pnadc.survey)
gc()

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

