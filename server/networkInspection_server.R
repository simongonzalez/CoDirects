output$network <- renderVisNetwork({
  
  options(scipen = 999)
  df <- read.csv('./datasets/bylicense.csv', stringsAsFactors = F)
  
  tmpoptions <- unique(c(df$CORPUS, df$LANGUAGES))
  
  languageMap <- setNames(df$LANGUAGES, df$CORPUS)
  
  titleMapText <- paste(df$CORPUS, df$LANGUAGES, df$HOURS, df$SPEAKERS, df$LICENSE, sep = '<br/>')
  titleMap <- setNames(titleMapText, df$CORPUS)
  
  descriptionMap <- setNames(df$DOWNLOAD, df$CORPUS)
  
  hoursMap <- setNames(df$HOURS, df$CORPUS)
  
  nodes <- data.frame(
    id = tmpoptions,
    label = tmpoptions, stringsAsFactors = FALSE
  )
  
  nodes$group <- languageMap[as.character(nodes$id)]
  nodes$group[is.na(nodes$group)] <- 'Language'
  
  nodes$title <- titleMap[as.character(nodes$id)]
  nodes$title[is.na(nodes$title)] <- as.character(nodes[is.na(nodes$title),'id'])
  
  nodes$description <- descriptionMap[as.character(nodes$id)]
  nodes$description[is.na(nodes$description)] <- 'Language'
  
  nodes$value <- hoursMap[as.character(nodes$id)]
  nodes$value[is.na(nodes$value)] <- 10
  
  dfLanguageCount <- df %>% group_by(LANGUAGES) %>% count()
  names(dfLanguageCount) <- c('title', 'value')
  
  nodesLanguages <- nodes[nodes$description == 'Language',]
  nodesLanguages$value = NULL
  nodes <- nodes[nodes$description != 'Language',]
  
  nodesLanguages <- merge(nodesLanguages, as.data.frame(dfLanguageCount), by = 'title')
  
  nodes <- rbind(nodes, nodesLanguages)
  
  edges <- data.frame(
    from = df$CORPUS,
    to = df$LANGUAGES, stringsAsFactors = FALSE
  )
  
  visNetwork(nodes, edges,
             height = "100%", width = "100%", 
             main = "") %>% 
    visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>% 
    visInteraction(hover = TRUE) %>%
    visEvents(
      click = "function(nodes) {
      console.info('click')
      console.info(nodes)
      Shiny.onInputChange('clicked_node', {nodes : nodes.nodes[0], edges : nodes.edges});
      ;}",
      hoverNode = "function(nodes) {
      console.info('hover')
      console.info(nodes)
      Shiny.onInputChange('hovered_node', {node : nodes.node});
      ;}"
    )
  })

output$table <- DT::renderDataTable({
  
  options(scipen = 999)
  df <- read.csv('./datasets/bylicense.csv', stringsAsFactors = F)
  df <- df[,unlist(strsplit('CORPUS LANGUAGES HOURS SPEAKERS DOWNLOAD', ' '))]
  rownames(df) <- NULL
  
  
  if(nrow(df[df$CORPUS == input$hovered_node$node,]) == 0){
    DT::datatable(df[df$LANGUAGES == input$hovered_node$node,], escape = FALSE)
  }else{
    DT::datatable(df[df$CORPUS == input$hovered_node$node,], escape = FALSE)
  }
  
  
})