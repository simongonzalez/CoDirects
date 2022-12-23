recreatesInputs <- function(tmpList, tmpInput){
  if(is.null(input[[tmpInput]])){
    selected_value <- tmpList[1]
  }else{
    if(length(input[[tmpInput]]) > 1){
      if(input[[tmpInput]][1] == 'All'){
        selected_value = input[[tmpInput]][input[[tmpInput]] != 'All']
      }else{
        if('All' %in% input[[tmpInput]]){
          selected_value = 'All'
        }else{
          selected_value = input[[tmpInput]]
        }
      }
    }else{
      selected_value = input[[tmpInput]]
    }
  }
  
  return(selected_value)
}


output$isolateCorpusui<- renderUI({
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  tmpList <- c('All', sort(unique(df$Corpus)))
  
  tmpInput <- 'isolateCorpus'
  
  selectInput('isolateCorpus', 'Corpus', choices = tmpList, selected = recreatesInputs(tmpList, tmpInput), multiple = T)
})

output$isolateLanguageui<- renderUI({
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  tmpList <- c('All', sort(unique(df$Language)))
  
  tmpInput <- 'isolateLanguage'
  
  selectInput('isolateLanguage', 'Language', choices = tmpList, selected = recreatesInputs(tmpList, tmpInput), multiple = T)
})

output$isolateSpeechui<- renderUI({
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  tmpList <- c('All', sort(unique(df$speechType)))
  
  tmpInput <- 'isolateSpeech'
  
  selectInput('isolateSpeech', 'Speech', choices = tmpList, selected = recreatesInputs(tmpList, tmpInput), multiple = T)
})

output$isolateLicenceui<- renderUI({
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  tmpList <- c('All', sort(unique(df$Licence)))
  
  tmpInput <- 'isolateLicence'
  
  selectInput('isolateLicence', 'Licence', choices = tmpList, selected = recreatesInputs(tmpList, tmpInput), multiple = T)
})

output$isolateAnnotationui<- renderUI({
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  tmpList <- c('All', sort(unique(df$Annotation)))
  
  tmpInput <- 'isolateAnnotation'
  
  selectInput('isolateAnnotation', 'Language', choices = tmpList, selected = recreatesInputs(tmpList, tmpInput), multiple = T)
})

output$isolateCountryui<- renderUI({
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  tmpList <- c('All', sort(unique(df$country)))
  
  tmpInput <- 'isolateCountry'
  
  selectInput('isolateCountry', 'Country', choices = tmpList, selected = recreatesInputs(tmpList, tmpInput), multiple = T)
})


output$sankeyOutputOverall<- renderEcharts4r({
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  if(input$isolateCorpus != 'All'){
    df <- df[df$Corpus %in% input$isolateCorpus,]
  }
  
  sankey <- data.frame(
    source = c(df$Corpus, df$Language, df$speechType, df$Corpus, df$Corpus),
    target = c(df$Language, df$speechType, df$country, df$speechType, df$country),
    value = rep(1, (nrow(df)*5)),
    stringsAsFactors = FALSE
  )
  
  sankey %>%
    e_charts() %>% 
    e_sankey(source, target, value) %>% 
    e_theme("infographic") %>% 
    e_toolbox_feature(feature = "saveAsImage") %>% 
    e_toolbox_feature(feature = "dataView")
})

output$sankeyOutputLanguage<- renderEcharts4r({
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  if(input$isolateLanguage != 'All'){
    df <- df[df$Language %in% input$isolateLanguage,]
  }
  
  sankey <- data.frame(
    source = c(df$Corpus),
    target = c(df$Language),
    value = rep(1, nrow(df)),
    stringsAsFactors = FALSE
  )
  
  sankey %>%
    e_charts() %>% 
    e_sankey(source, target, value) %>% 
    e_theme("infographic") %>% 
    e_toolbox_feature(feature = "saveAsImage") %>% 
    e_toolbox_feature(feature = "dataView")
})


output$sankeyOutputAnnotation<- renderEcharts4r({
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  df <- df[df$Annotation != '',]
  
  if(input$isolateAnnotation != 'All'){
    df <- df[df$Annotation %in% input$isolateAnnotation,]
  }
  
  sankey <- data.frame(
    source = c(df$Corpus),
    target = c(df$Annotation),
    value = rep(1, nrow(df)),
    stringsAsFactors = FALSE
  )
  
  sankey %>%
    e_charts() %>% 
    e_sankey(source, target, value) %>% 
    e_theme("infographic") %>% 
    e_toolbox_feature(feature = "saveAsImage") %>% 
    e_toolbox_feature(feature = "dataView")
})




output$sankeyOutputCountry<- renderEcharts4r({
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  if(input$isolateCountry != 'All'){
    df <- df[df$country %in% input$isolateCountry,]
  }
  
  sankey <- data.frame(
    source = c(df$Corpus),
    target = c(df$country),
    value = rep(1, nrow(df)),
    stringsAsFactors = FALSE
  )
  
  sankey %>%
    e_charts() %>% 
    e_sankey(source, target, value) %>% 
    e_theme("infographic") %>% 
    e_toolbox_feature(feature = "saveAsImage") %>% 
    e_toolbox_feature(feature = "dataView")
})

output$sankeyOutputLicence<- renderEcharts4r({
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  df <- df[df$Licence != '',]
  
  if(input$isolateLicence != 'All'){
    df <- df[df$Licence %in% input$isolateLicence,]
  }
  
  sankey <- data.frame(
    source = c(df$Corpus),
    target = c(df$Licence),
    value = rep(1, nrow(df)),
    stringsAsFactors = FALSE
  )
  
  sankey %>%
    e_charts() %>% 
    e_sankey(source, target, value) %>% 
    e_theme("infographic") %>% 
    e_toolbox_feature(feature = "saveAsImage") %>% 
    e_toolbox_feature(feature = "dataView")
})

output$sankeyOutputSpeechType<- renderEcharts4r({
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  
  if(input$isolateSpeech != 'All'){
    df <- df[df$speechType %in% input$isolateSpeech,]
  }
  
  sankey <- data.frame(
    source = c(df$Corpus),
    target = c(df$speechType),
    value = rep(1, nrow(df)),
    stringsAsFactors = FALSE
  )
  
  sankey %>%
    e_charts() %>% 
    e_sankey(source, target, value) %>% 
    e_theme("infographic") %>% 
    e_toolbox_feature(feature = "saveAsImage") %>% 
    e_toolbox_feature(feature = "dataView")
})
