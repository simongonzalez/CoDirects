output$austalkOutputEC <- renderEcharts4r({
  if(is.null(input$mapIntOptions))
    return()
  
  if(input$mapIntOptions == 'World Connections')
    return()
  
  df <- read.csv('./datasets/austalkcl.csv')
  
  if(input$mapIntOptions == "Overall Speakers"){
    df <- as.data.frame(df %>% group_by(region) %>% count())
    
    df$n <- as.numeric(df$n)
    
    df %>%
      e_charts(region) %>%
      em_map("Australia") %>%
      e_map(n, map = "Australia") %>%
      e_visual_map(n) %>%
      e_theme("infographic")
  }else{
    #individually in Aus Map
    df %>%
      e_charts(long) %>%
      e_geo(
        roam = TRUE,
        boundingCoords = list(
          c(140, - 10),
          c(125, -45)
        )
      ) %>%
      e_scatter(
        lat, age, legend = F,
        coord_system = "geo"
      ) %>%
      e_visual_map(min = 0, max = 1, rm_x = T, rm_y = T) %>%
      e_tooltip(formatter = htmlwidgets::JS("
                                            function(params){
                                            return('Age: ' + params.value[2])
                                            }
                                            ")) %>%
      e_theme("dark")
  }
  
  })

output$austalkOutputMD <- renderMapdeck({
  
  if(is.null(input$mapIntOptions))
    return()
  
  if(input$mapIntOptions != 'World Connections')
    return()
  
  set_token('pk.eyJ1Ijoic2ltb25nb256YWxleiIsImEiOiJjazJjc3Y4dGUyMXR3M21vNnp6b29xdGQ0In0.9jrdfph8jioWuTA3XXY1UQ')
  
  key <- 'pk.eyJ1Ijoic2ltb25nb256YWxleiIsImEiOiJjazJjc3Y4dGUyMXR3M21vNnp6b29xdGQ0In0.9jrdfph8jioWuTA3XXY1UQ'
  
  df <- read.csv('./datasets/austalkcl.csv')
  
  mapdeck(style = mapdeck_style('dark'), pitch = 35)  %>%
    add_arc(
      data = df
      , layer_id = "arc_layer"
      , origin = c("long", "lat")
      , destination = c("longitude", "latitude")
      , stroke_from = 'city'
      , stroke_to = 'country'
      , auto_highlight = T)
})

output$dispMessage <- renderUI({
  
  if(input$mapIntOptions == 'Overall Speakers'){
    h5("This map shows the number of speakers per state/territory. These are the speakers recorded in the database. The darker the color, the more speakers in the state/territory. As observed, there are more speakers recorded in New South Wales and the Northern Territory shows the least number of speakers recorded.")
  }else if(input$mapIntOptions == "Individual Speakers"){
    h5("This map shows all the speakers in the corpus. Each point represents a specific speaker. The size of the point represents the age, so the larger the circle, the older the speaker. The location is based on the place of origin for each speaker.")
  }else{
    h5("This map shows the place of origin of the father for each speaker. Speakers were recorded in Australia and relevant sociolinguistic information was collected. Among others, the place of origin of the parens was collected. The plot shows a significant amount of speakers whose fathers come originally from outside of Australia, especially from Europe.")
  }
  
})

output$mapplot1 <- renderEcharts4r({
  if(is.null(input$mapIntOptions))
    return()
  
  df <- read.csv('./datasets/austalkcl.csv')
  
  if(input$mapIntOptions == "Overall Speakers"){
    df <- as.data.frame(df %>% group_by(region) %>% count())
    df$total <- sum(df$n)
    df$percentage <- round(df$n * 100 / df$total)
    
    df$percentage <- as.numeric(df$percentage)
    
    df %>% 
      e_charts() %>% 
      e_funnel(percentage, region, legend = F) %>% 
      e_title("Number of speakers per state/territory")
  }else if(input$mapIntOptions == "Individual Speakers"){
    df %>% 
      group_by(state) %>% 
      e_charts() %>% 
      e_boxplot(age) %>%
      e_title('Ages per state/territory') %>%
      e_theme('dark') %>%
      e_tooltip()
  }else if(input$mapIntOptions == "World Connections"){
    
    df$educationLevel <- ifelse(df$father_education_level == df$mother_education_level, 
                                'Same Level', 'Different Level')
    
    df2 <- as.data.frame(df %>% 
                           group_by(state, educationLevel) %>% 
                           count())
    
    df2$n <- as.numeric(df2$n)
    
    df2 %>%
      e_charts() %>% 
      e_sunburst(state, educationLevel, n) %>% 
      e_title("Level of education of both parents") %>%
      e_theme('dark') %>%
      e_tooltip()
  }
  
})