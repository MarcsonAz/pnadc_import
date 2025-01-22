# funcoes de apoio
# codigo para armazenar funcoes de apoio


### funcao encontrar pnadc

# versao 1
# vai buscar o arquivo zip para ter os dados por ano dado caminho

# encontra_pnadc
# entrada: ano, caminho
# caminho do arquivo zip

encontra_pnadc <- function(ano,caminho = ""){
  stopifnot("ano deve ser numérico"=is.numeric(ano))
  stopifnot("caminho deve ser texto"=is.character(caminho))
  
  caminho_final <- list.files(paste0(caminho,"Dados"), 
                   pattern=paste0("*PNADC_",ano), full.names=TRUE)
  
  if(length(caminho_final)>1){
    i_arquivo_recente = which.min(
      order(
        file_info(
          caminho_final)$modification_time, 
        decreasing = TRUE))
    }
  return(caminho_final[i_arquivo_recente])
}



# encontra_input_pnadc

# versao 1
# vai buscar o arquivo de input para ler os dados por ano

# encontra_input_pnadc
# entrada: ano, caminho
# caminho do arquivo de texto

encontra_input_pnadc <- function(ano,caminho = ""){
  stopifnot("ano deve ser numérico"=is.numeric(ano))
  stopifnot("caminho deve ser texto"=is.character(caminho))
  
  caminho_final <-list.files(paste0(caminho,"Documentacao"), 
                             pattern=paste0("*PNADC_",ano), full.names=TRUE)
  if(length(caminho_final)>1){
    i_arquivo_recente = which.min(
      order(
        file_info(
          caminho_final)$modification_time, 
        decreasing = TRUE))
  }
  return(caminho_final[i_arquivo_recente])
}


## versaõ 2

# encontrar lista de arquivos de pnadcs tri 
# dado resposta de não ter lá na lista de arquivos,


# quero 1 - ter todas as pnadcs tri salvas em parquet.
# funcao final de atualizar dados de tri

# preciso: 
# - lista de arquivos ja em parquet (OK)
# - lista de arquivos compactados (OK)
# --- pegar anos com nome de pasta (OK)
# - filtrar dado a comparação das lista acima ()
# - carregar os necessários no R, com variáveis selecionadas e 
# salvar em parquet.

listar_arq_pnadc_tri_compactos <- function(
    caminho = "./../Trimestral/Microdados/"){
  
  stopifnot("caminho deve ser texto"=is.character(caminho))
  
  arquivos_compacto <- list.dirs(caminho) %>% 
    filtrar_dir_anos() %>% 
    list.files(full.names = TRUE,recursive = TRUE)
  
  return(arquivos_compacto)
}

listar_arq_pnadc_tri_parquet <- function(
    caminho = "./../parquet/"){
  
  stopifnot("caminho deve ser texto"=is.character(caminho))
  
  arquivos_parquet <- list.files(caminho,full.names = TRUE,recursive = TRUE)
  
  return(arquivos_parquet)
}


parquet_antigo <- function(
    caminho = "./../parquet/"){
  
  stopifnot("caminho deve ser texto"=is.character(caminho))
  
    arquivos_parquet <- listar_arq_pnadc_tri_parquet()
    arquivos_compacto <- listar_arq_pnadc_tri_compactos()
    
    
  
  return(arquivos_parquet)
}






lista_arquivos_pnadc_tri <- function(ano = "todos",caminho = "", tri=NULL){
  stopifnot("ano deve ser numérico"=is.numeric(ano))
  stopifnot("caminho deve ser texto"=is.character(caminho))
  stopifnot("tri deve ser numérico (1,2,3,4) ou NULo"=is.numeric(ano))
  
  caminho_final <-list.files(paste0(caminho,"Dados"), 
                             pattern=paste0("*PNADC_",ano), full.names=TRUE)
  
  
  return(caminho_final)
}



filtrar_dir_anos <- function(dir_principal) {
  
  pattern <- "/20\\d{2}$"
  dir_anos <- dir_principal[grepl(pattern, dir_principal)]
  
  return(dir_anos)
}


filtrar_dir_anos(caminho_final)




diretorio_microdados <- function(n_visita){
  dir_apoio = "./../Anual/Microdados/Visita/Visita_"
  
  if(n_visita == 1){
    return(paste0(dir_apoio,'1/'))
  }
  
  if(n_visita == 5){
    return(paste0(dir_apoio,'5/'))
  }
}




