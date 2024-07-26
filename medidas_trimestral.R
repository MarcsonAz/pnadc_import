### medidas trimestral


# Dos dados de 4 tri de 2023 em parquet

# calcular os totais dos cruzamentos de 
# contribuintes, CNPJ, ocupado, posição na ocupação

# variaveis

# v2009 idade,
# VD400 1,2,3
# #VD4009
# VD4012
# V4019
# V4009, V4032

# pegar dados

diretorio_microdados_parquet= "./../parquet/"
ano = 2023
trimestre = 4
nome_arquivo = paste0(
  diretorio_microdados_parquet,"arquivo_microdados_",ano,"_trimestral_t",trimestre,"_teste.parquet"
)

df = arrow::read_parquet(nome_arquivo)

dadosPNADc <- pnadc_design(data_pnadc=df)


library(survey)


names(dadosPNADc$variables)

total_na_ft <- svytotal(x=~VD4001, design=dadosPNADc, na.rm=TRUE)
total_na_ft %>% as_tibble() %>% pull(total)
# 109066328 +  66285994 = 175.352.322

total_14_mais <- svytotal(x=~V2009>=14, design=dadosPNADc, na.rm=TRUE)
total_14_mais %>% as_tibble() %>% pull(total)
# 175.352.322


total_ocupado <- svytotal(x=~VD4002, design=dadosPNADc, na.rm=TRUE)
total_ocupado %>% as_tibble() %>% pull(total)

# sim       +  nao = total na ft
# 100984562 + 8081765 = 109066327

total_posicao <- svytotal(x=~VD4009, design=dadosPNADc, na.rm=TRUE)
total_posicao %>% as_tibble() %>% pull(total) %>% sum()

# 37972859 13526585  1422445  4614275  1460691  3063241  7678098  4220887 25615024 1410459
# soma = 100.984.562 iguala total_ocupado==sim



total_contrib <- svytotal(x=~VD4012, design=dadosPNADc, na.rm=TRUE)
total_contrib %>% as_tibble() %>% pull(total) %>% sum()

# 65454250 35530312
# 35 milhões e meio trabalham e NAO contribuem
# 35 % dos ocupados NAO contribuem
# soma = 100.984.562 igual a total_ocupado==sim


total_cnpj <- svytotal(x=~V4019, design=dadosPNADc, na.rm=TRUE)
total_cnpj %>% as_tibble() %>% pull(total) %>% sum()

# sim      nao
# 9854606 19981305
# soma = 29.835.911 

# preciso ver quem responde esse de CNPJ

# cruzar cnpj com posicao


total_cnpj_posicao <- svytotal(x=~interaction(V4019,VD4009), design=dadosPNADc, na.rm=TRUE)
total_cnpj_posicao %>% as_tibble() %>% pull(total) %>% sum()

# 4220887 +25615024 # soma = 29.835.911 

# somente empregador e conta-propria que respondem sobre CNPJ
# filtro esta na pegunta de posição na ocupacao



### TESTE 1 DO CRUZAMENTO BUSCADO


# contribuintes, CNPJ, ocupado, posição na ocupação

total_cnpj_posicao_ocupado_contrib <- svytotal(x=~V4019+VD4009+VD4002+VD4012, design=dadosPNADc, na.rm=TRUE)
total_cnpj_posicao_ocupado_contrib %>% as_tibble() %>% pull(total) %>% sum()

total_cnpj_posicao_ocupado_contrib2 <- svytotal(x=~V4019*VD4009*VD4002*VD4012, design=dadosPNADc, na.rm=TRUE)
total_cnpj_posicao_ocupado_contrib2 %>% as_tibble() %>% pull(total) %>% sum()

## tabela resultante

# dominio de ft - acima de 14 anos              (175 mi)
# dominio de ocupados - sim em ft               (109 mi)
# dominio posicao - sim em ocupado              (100 mi)
# dominio contribuinte - sim em ocupado         (100 mi)
# dominio de cnpj - posicao = 8 & 9             ( 29 mi)




# NOVA ANALISE 

# CONTRIBUINTE E POSICAO


total_contrib_posicao <- svytotal(x=~interaction(VD4012,VD4009), design=dadosPNADc, na.rm=TRUE)
total_contrib_posicao %>% as_tibble() %>% pull(total) %>% sum()

# 4220887 +25615024 # soma = 29.835.911 

# somente empregador e conta-propria que respondem sobre CNPJ
# filtro esta na pegunta de posição na ocupacao



# MAIS NOVA ANALISE 

# CONTRIBUINTE E POSICAO (8 E 9) E CNPJ


total_contrib_posicao_cnpj <- svytotal(x=~interaction(VD4012,VD4009,V4019), design=dadosPNADc, na.rm=TRUE)

# total_contrib_posicao_cnpj <- svytotal(x=~interaction(VD4012,VD4009,V2009),
#                                        design=subset(dadosPNADc, VD4009 %in% c("8","9")),
#                                        na.rm=TRUE)

total_contrib_posicao_cnpj %>% as_tibble() %>% pull(total) %>% sum()

# 4220887 +25615024 # soma = 29.835.911 

# somente empregador e conta-propria que respondem sobre CNPJ
# filtro esta na pegunta de posição na ocupacao





