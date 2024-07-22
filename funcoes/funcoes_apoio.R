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
