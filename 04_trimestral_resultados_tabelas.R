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

t_idade_14_sexo = svyby(~one, by = ~(V2009>=14)+V2007, design=pnadc.survey, FUN = svytotal)

t_ocup = svyby(~one, by = ~VD4002, design=pnadc.survey, FUN = svytotal)

#"VD4009" "VD4012"

# posicao e contribuinte

t_contrib = svyby(~one, by = ~VD4012, design=pnadc.survey, FUN = svytotal)

t_pos_contrib = svyby(~one, by = ~VD4012+VD4009, design=pnadc.survey, FUN = svytotal)


### perfil de cntribuinte

t_contrib = svyby(~one, by = ~VD4012, design=pnadc.survey, FUN = svytotal)
t_contrib_sex = svyby(~one+V2007, by = ~VD4012, design=pnadc.survey, FUN = svytotal)
t_contrib_cr = svyby(~one+V2010, by = ~VD4012, design=pnadc.survey, FUN = svytotal)

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
         variavel, 
         variavel_nome = condicao_em_relacao_a_forca_de_trabalho_e_condicao_de_ocupacao,
         unidade_de_medida, valor)

data2 = sidrar::get_sidra(5947,period = c("201904","202304"))

data2 = data2 %>% 
  as_tibble() %>% 
  janitor::clean_names() %>% 
  filter(unidade_de_medida == "Mil pessoas") %>% 
  select(nivel_territorial, 
         trimestre_codigo, trimestre,
         variavel,
         variavel_nome = contribuicao_para_instituto_de_previdencia_em_qualquer_trabalho,
         unidade_de_medida, valor)



### tentar um funcao que pega todas t_ em memoria e colocar em abas e
# e salvar uma planilha com data e hora

diretorio_resultados= "./../rds/resultados/"


write.csv2(rbind(data,data2),paste0(diretorio_resultados,"data_sidra_total.csv"))
write.csv2(t_contrib,paste0(diretorio_resultados,"t_contrib_total.csv"))
write.csv2(t_ft,paste0(diretorio_resultados,"t_ft_total.csv"))
write.csv2(t_idade_14,paste0(diretorio_resultados,"t_idade_14_total.csv"))
write.csv2(t_ocup,paste0(diretorio_resultados,"t_ocup_total.csv"))
write.csv2(t_pos_contrib,paste0(diretorio_resultados,"t_pos_contrib_total.csv"))









write.csv2(t_contrib,paste0(diretorio_resultados,"t_contrib_19.csv"))
write.csv2(t_contrib_cr,paste0(diretorio_resultados,"t_contrib_cr_19.csv"))
write.csv2(t_contrib_sex,paste0(diretorio_resultados,"t_contrib_sex_19.csv"))
write.csv2(t_ft,paste0(diretorio_resultados,"t_ft_19.csv"))
write.csv2(t_ocup,paste0(diretorio_resultados,"t_ocup_19.csv"))
write.csv2(t_pos_contrib,paste0(diretorio_resultados,"t_pos_contrib_19.csv"))




######## PERFIL DO CONTRIBUINTE
######## PERFIL DO NÃO CONTRIBUINTE

# DADOS
diretorio_rds = "./../rds/"

pnadc.survey.2019 <- readRDS(paste0(
  diretorio_rds,"arquivo_survey_2019_trimestral_t4.rds"
))

# pnadc.survey.2023 <- readRDS(paste0(
#   diretorio_rds,"arquivo_survey_2023_trimestral_t4.rds"
# ))

# TOTAIS E REMUNERAÇÃO HABITUAL 

variaveis <- names(pnadc.survey.2019$variables)

### deflacionar
pnadc.survey.2019$variables <- transform(pnadc.survey.2019$variables, VD4016_hab=VD4016*Habitual)

rend_medio <- svymean(~VD4016_hab, 
                      design = subset(pnadc.survey.2019,
                                      VD4002=="Pessoas ocupadas",
                                      VD4016>0), 
                      na.rm=TRUE)

cv(object=rend_medio)
confint(object=rend_medio)


rend_medio_sexo <- svyby(~VD4016_hab, by = ~V2007, 
                      design = subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"),
                      FUN=svymean,
                      na.rm=TRUE)


cv(object=rend_medio_sexo)*100


## contribuinte remuneração média

rend_contrib = svyby(~VD4016_hab, by = ~VD4012, 
                  design = subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"),
                  FUN=svymean,
                  na.rm=TRUE)


## contribuinte remuneração média e posicao na ocupacao

rend_contrib_pos = svyby(~VD4016_hab, by = ~interaction(VD4012,VD4009), 
                     design = subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"),
                     FUN=svymean,
                     na.rm.all=TRUE,
                     na.rm=TRUE,
                     na.rm.by=TRUE)



rend_pos = svyby(~VD4016_hab, by = ~VD4009, 
                         design = subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"),
                         FUN=svymean,
                         na.rm.all=TRUE,
                         na.rm=TRUE,
                         na.rm.by=TRUE)


### total dos contribuintes sem carteira no privado


t_contrib_semcarteira = svytotal(~one, 
                 design = subset(pnadc.survey.2019,
                                 VD4002=="Pessoas ocupadas"&
                                   VD4012=="Contribuinte"&
                                   VD4009=="Empregado no setor privado sem carteira de trabalho assinada"),
                 na.rm=TRUE)


t_pos = svyby(~one, by = ~VD4009, 
                 design = subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"&
                                   VD4012=="Contribuinte"),
                 FUN=svytotal,
                 na.rm.all=TRUE,
                 na.rm=TRUE,
                 na.rm.by=TRUE)

#### quantile 

# distribuição de rendimento

rend_quantis <- svyquantile(~VD4016_hab,
                            design=subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"),
                            na.rm=TRUE,
                            quantiles=c(0.1,0.25,0.5,0.75,0.9),
                            ci=FALSE)

# # distribuição de rendimento por sexo

rend_quantis_home <- svyquantile(~VD4016_hab,
                                 design=subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"&
                                                 V2007=="Homem"),
                                 na.rm=TRUE,
                                 quantiles=c(0.1,0.25,0.5,0.75,0.9),
                                 ci=FALSE)


# # distribuição de rendimento por contribuinte

rend_quantis_contrib <- svyquantile(~VD4016_hab,
                                 design=subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"&
                                                 VD4012=="Contribuinte"),
                                 na.rm=TRUE,
                                 quantiles=c(0.1,0.25,0.5,0.75,0.9),
                                 ci=FALSE)

rend_quantis_n_contrib <- svyquantile(~VD4016_hab,
                                    design=subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"&
                                                    VD4012=="Não contribuinte"),
                                    na.rm=TRUE,
                                    quantiles=c(0.1,0.25,0.5,0.75,0.9),
                                    ci=FALSE)




### antigo com erro

rend_quantis_sexo <- svyby(~VD4016_hab, by = ~V2007,
                            design=subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"),
                            FUN=svyquantile,
                            quantiles=c(0.1,0.25,0.5,0.75,0.9),
                            ci=FALSE,
                            na.rm=TRUE)


# # distribuição de rendimento por contribuinte

rend_quantis_contrib <- svyby(~VD4016_hab, by = ~VD4012,
                              design=subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"),
                              FUN=svyquantile,
                              na.rm.all=TRUE,
                              na.rm=TRUE,
                              na.rm.by=TRUE,
                              quantiles=c(0.25,0.5,0.75),
                              ci=FALSE)




write.csv2(rend_contrib,paste0(diretorio_resultados,"rend_contrib_19.csv"))
write.csv2(rend_contrib_pos,paste0(diretorio_resultados,"rend_contrib_pos_19.csv"))
write.csv2(rend_medio_sexo,paste0(diretorio_resultados,"rend_medio_sexo_19.csv"))
write.csv2(rend_pos,paste0(diretorio_resultados,"rend_pos_19.csv"))
write.csv2(t_pos,paste0(diretorio_resultados,"t_pos_19.csv"))



df_rend_quantis <- rbind(
as.data.frame(rend_quantis$VD4016_hab),
as.data.frame(rend_quantis_contrib$VD4016_hab),
as.data.frame(rend_quantis_n_contrib$VD4016_hab)
) %>% as_tibble() %>% 
  mutate(grupo = c('Ocupados','Contribuintes','Não contribuintes')) %>% 
  select(grupo, everything())

write.csv2(df_rend_quantis,paste0(diretorio_resultados,"df_rend_quantis_19.csv"))

## teste grafico com quantis



df_plot <- tibble(
  grupo = c(""),
  quantil = c(""),
  valor =  c()
)

library(ggplot2)

df_rend_quantis_plot <- df_rend_quantis %>% 
  tidyr::pivot_longer(cols= `0.1`:`0.9`,names_to = 'quantil', names_prefix = "quantil")



df_rend_quantis_plot %>% 
  ggplot(aes(y=grupo, x=value, group=grupo, color=grupo)) +
  geom_line()

df_rend_quantis_plot %>% 
  ggplot(aes(y=value, group=grupo, color=grupo)) +
  geom_boxplot()

df_rend_quantis_plot %>% 
  ggplot(aes(x=value, fill=grupo, color=grupo)) +
  geom_density(alpha=0.25)


# 	
# Ocupados
# 656.8421
# 1317.5002
# 1863.363
# 3061.239
# 5400.630

pnadc.survey.2019$variables <- transform(pnadc.survey.2019$variables, 
                                         renda_ate_10 = ifelse(
                                           VD4002=="Pessoas ocupadas" & VD4016<= 656.84,
                                           TRUE, FALSE
                                         ),
                                         renda_ate_50 = ifelse(
                                           VD4002=="Pessoas ocupadas" & VD4016<= 1863.36,
                                           TRUE, FALSE
                                         )
)



t_teste = svyby(~one, by = ~renda_ate_50, 
              design = subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"),
              FUN=svytotal,
              na.rm.all=TRUE,
              na.rm=TRUE,
              na.rm.by=TRUE)


svytotal(~one,design = subset(pnadc.survey.2019,VD4002=="Pessoas ocupadas"))





