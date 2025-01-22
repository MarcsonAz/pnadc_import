# 02 
# TRIMESTRAL

trimestral_variaveis_auxiliares <- function(pnadc.df){
  pnadc.df <- pnadc.df %>% 
    mutate(one = 1)
  
  return(pnadc.df)
}
