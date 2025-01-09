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
  
  caminho_final <-list.files(paste0(caminho,"Dados"), 
                   pattern=paste0("*PNADC_",ano), full.names=TRUE)
  
  return(caminho_final)
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
  
  return(caminho_final)
}


## versaõ 2

# encontrar lista de arquivos de pnadcs tri 
# dado resposta de não ter lá na lista de arquivos,


# quero 1 - ter todas as pnadcs tri salvas em parquet.
# funcao final de atualizar dados de tri

# preciso: 
# - lista de arquivos ja em parquet
# - lista de arquivos compactados
# - filtrar dado a comparação das lista acima
# - carregar os necessários no R, com variáveis selecionadas e 
# salvar em parquet.

listar_arq_pnadc_tri_compactos <- function(caminho = ""){
  stopifnot("caminho deve ser texto"=is.character(caminho))
  
  caminho_final <-list.files(paste0(caminho,"Dados"), 
                             pattern=paste0("*PNADC_",ano), full.names=TRUE)




lista_arquivos_pnadc_tri <- function(ano = "todos",caminho = "", tri=NULL){
  stopifnot("ano deve ser numérico"=is.numeric(ano))
  stopifnot("caminho deve ser texto"=is.character(caminho))
  stopifnot("tri deve ser numérico (1,2,3,4) ou NULo"=is.numeric(ano))
  
  caminho_final <-list.files(paste0(caminho,"Dados"), 
                             pattern=paste0("*PNADC_",ano), full.names=TRUE)
  
  
  return(caminho_final)
}









