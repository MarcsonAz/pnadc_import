# 03 trimestral survey design

trimestral_survey <- function(df, 
                         dic_path,
                         def_path){
  
  # gerar o design,
  
  df <- pnadc_labeller(data_pnadc = df, dictionary.file = dic_path)
  
  df <- pnadc_deflator(data_pnadc =df, deflator.file = def_path)
  
  survey <- pnadc_design(data_pnadc = df)
  
  return(survey)
}