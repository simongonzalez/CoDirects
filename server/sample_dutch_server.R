output$theSpokenDutchCorpusProject_sample1 <- renderUI({
  path <- "./www/TheSpokenDutchCorpusProject/sample1.txt"
  con <- file(path, open = "rt", raw = TRUE)
  text <- readLines(con, skipNul = TRUE)
  close(con)
  
  text <- do.call(c, lapply(text, strsplit, split = "\t"))
  text <- unlist(text, use.names=FALSE)
  
  text <- gsub('^', '<b>', text)
  text <- gsub('\\: ', ':</b> ', text)
  
  HTML(paste(text, collapse = '<br/><br/>'))
  
})


output$theSpokenDutchCorpusProject_sample1_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/TheSpokenDutchCorpusProject/sample1.wav", type = "audio/wav", autostart = 0, controls = NA)
})

output$theSpokenDutchCorpusProject_sample2 <- renderUI({
  path <- "./www/TheSpokenDutchCorpusProject/sample2.txt"
  con <- file(path, open = "rt", raw = TRUE)
  text <- readLines(con, skipNul = TRUE)
  close(con)
  
  text <- do.call(c, lapply(text, strsplit, split = "\t"))
  text <- unlist(text, use.names=FALSE)
  
  text <- gsub('^', '<b>', text)
  text <- gsub('\\: ', ':</b> ', text)
  
  HTML(paste(text, collapse = '<br/><br/>'))
  
})


output$theSpokenDutchCorpusProject_sample2_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/TheSpokenDutchCorpusProject/sample2.wav", type = "audio/wav", autostart = 0, controls = NA)
})

output$theSpokenDutchCorpusProject_sample3 <- renderUI({
  path <- "./www/TheSpokenDutchCorpusProject/sample3.txt"
  con <- file(path, open = "rt", raw = TRUE)
  text <- readLines(con, skipNul = TRUE)
  close(con)
  
  text <- do.call(c, lapply(text, strsplit, split = "\t"))
  text <- unlist(text, use.names=FALSE)
  
  text <- gsub('^', '<b>', text)
  text <- gsub('\\: ', ':</b> ', text)
  
  HTML(paste(text, collapse = '<br/><br/>'))
  
})


output$theSpokenDutchCorpusProject_sample3_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/TheSpokenDutchCorpusProject/sample3.wav", type = "audio/wav", autostart = 0, controls = NA)
})

output$theSpokenDutchCorpusProject_tagging <- renderUI({
  addResourcePath("www", "./www")
  tags$iframe(style="height:600px; width:100%", src="www/TheSpokenDutchCorpusProject/postag.pdf")
})