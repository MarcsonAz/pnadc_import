# resultados trimestral

# vou carregar a survey de trimestre e gerar os resultados

# ainda não sei se vai ser chamando o source ou vou abrir e gerar as medidas

# mas quero deixar os resultados em memoria para gerar uma planilha no fim para
# ter de onde pegar, caso queira fazer analises em tabelas para colocar no texto
# que aí depois, decidido do que analisar, coloco em gráficos para fazer o texto




#### carregar dados



#### calcular

View(head(pnadc.survey$variables))

vds_i <- names(pnadc.survey$variables) %>% 
  stringr::str_detect(pattern = "VD")

vds <- names(pnadc.survey$variables)[vds_i]


# totais

t_ft = svyby(~one, by = ~VD4001, design=pnadc.survey, FUN = svytotal)
t_idade_14 = svyby(~one, by = ~V2009>=14, design=pnadc.survey, FUN = svytotal)

t_ocup = svyby(~one, by = ~VD4002, design=pnadc.survey, FUN = svytotal)

#"VD4009" "VD4012"

# posicao e contribuinte

t_contrib = svyby(~one, by = ~VD4012, design=pnadc.survey, FUN = svytotal)

t_pos_contrib = svyby(~one, by = ~VD4012+VD4009, design=pnadc.survey, FUN = svytotal)





##############
# SIDRA PARA VALIDACAO DA BASE

# tabela ft, ocup
data = sidrar::get_sidra(4092,period = c("201904","202304"))

data = data %>% 
  as_tibble() %>% 
  janitor::clean_names() %>% 
  filter(unidade_de_medida == "Mil pessoas") %>% 
  select(nivel_territorial, 
         trimestre_codigo, trimestre,
         variavel, condicao_em_relacao_a_forca_de_trabalho_e_condicao_de_ocupacao,
         unidade_de_medida, valor)





### tentar um funcao que pega todas t_ em memoria e colocar em abas e
# e salvar uma planilha com data e hora

diretorio_resultados= "./../rds/resultados/"


write.csv2(data,paste0(diretorio_resultados,"data_sidra_total.csv"))
write.csv2(t_contrib,paste0(diretorio_resultados,"t_contrib_total.csv"))
write.csv2(t_ft,paste0(diretorio_resultados,"t_ft_total.csv"))
write.csv2(t_idade_14,paste0(diretorio_resultados,"t_idade_14_total.csv"))
write.csv2(t_ocup,paste0(diretorio_resultados,"t_ocup_total.csv"))
write.csv2(t_pos_contrib,paste0(diretorio_resultados,"t_pos_contrib_total.csv"))


