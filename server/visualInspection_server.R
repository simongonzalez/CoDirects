output$visualInspection1 <- renderEcharts4r({
  
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  df <- as.data.frame(df %>% group_by(Language) %>% count())
  #df$y <- 1:nrow(df)
  df$n <- as.numeric(df$n)
  df <- df[order(df$n, decreasing = T),]
  df %>% 
    e_charts(Language) %>% 
    e_polar() %>% 
    e_angle_axis(Language) %>% # angle = x
    e_radius_axis() %>% 
    e_bar(n, coord_system = "polar", legend = F) %>%
    e_title('Nº of Corpora p/Language') %>% 
    e_theme("dark") %>% 
    e_tooltip() %>%
    e_toolbox_feature(feature = "saveAsImage") %>% e_toolbox_feature(feature = "dataView")
  
})

output$visualInspection2 <- renderEcharts4r({
  
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  df <- as.data.frame(df %>% group_by(speechType) %>% count())
  df$n <- as.numeric(df$n)
  df <- df[order(df$n, decreasing = T),]
  df %>% 
    e_charts(speechType) %>% 
    e_pie(n, roseType = "radius", legend = F) %>%
    e_title('Nº of Corpora p/Speech Type') %>% 
    e_theme("dark") %>% 
    e_tooltip(formatter = htmlwidgets::JS("
                                          function(params){
                                          return('' + params.name + ' ' + params.value)
                                          }
                                          ")
    ) %>%
    e_toolbox_feature(feature = "saveAsImage") %>% e_toolbox_feature(feature = "dataView")
  
  })

output$visualInspection3 <- renderEcharts4r({
  
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  df <- as.data.frame(df[df$metrics == 'hours',] %>% group_by(Corpus) %>% summarise(hours = mean(value)))
  #df$n <- as.numeric(df$n)
  df <- df[order(df$hours),]
  df %>% 
    e_charts(Corpus) %>% 
    e_bar(hours, legend = F) %>%
    e_title('Nº of hours p/Corpora') %>% 
    e_theme("dark") %>% 
    e_tooltip() %>%
    e_toolbox_feature(feature = "saveAsImage") %>% e_toolbox_feature(feature = "dataView")
  
})

output$visualInspection4 <- renderEcharts4r({
  
  options(scipen = 999)
  df <- read.csv('./datasets/clarin.csv', stringsAsFactors = F)
  countries <- read.csv('./datasets/countrylatlong.csv', stringsAsFactors = F)
  
  df <- merge(df, countries, by = 'country')
  
  df <- as.data.frame(df %>% group_by(location, latitude, longitude) %>% count())
  
  
  df %>%
    e_charts(longitude) %>%
    e_geo(
      roam = TRUE,
      boundingCoords = list(
        c(0, 42 ),
        c(30, 65)
      )
    ) %>%
    e_effect_scatter(
      latitude, n, legend = F,
      coord_system = "geo",
      rippleEffect = list(brushType = "fill")
    ) %>%
    e_visual_map(min = 0, max = 1, rm_x = T, rm_y = T) %>%
    e_tooltip(formatter = htmlwidgets::JS("
                                          function(params){
                                          return('Number of Corpora: ' + params.value[2])
                                          }
                                          ")) %>%
    e_title('Corpora Locations') %>% 
    e_theme("dark") %>% 
    e_toolbox_feature(feature = "saveAsImage") %>% e_toolbox_feature(feature = "dataView")
  
})
