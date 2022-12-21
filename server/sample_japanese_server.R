output$callhome_Japanese_ovv <- renderUI({
  path <- "./www/callhome_Japanese/callhome_Japanese_ovv.txt"
  con <- file(path, open = "rt", raw = TRUE)
  text <- readLines(con, skipNul = TRUE)
  close(con)
  
  text <- do.call(c, lapply(text, strsplit, split = "\t"))
  text <- unlist(text, use.names=FALSE)
  
  text <- gsub('^', '<b>', text)
  text <- gsub('\\: ', ':</b> ', text)
  
  HTML(paste(text, collapse = '<br/><br/>'))
  
})

output$callhome_Japanese_sample1 <- renderUI({
  addResourcePath("www", "./www")
  tags$iframe(style="height:600px; width:100%", src="www/callhome_Japanese/ja_0696.pdf")
})

output$callhome_Japanese_sample1_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/callhome_Japanese/ja_0696.mp3", type = "audio/mp3", autostart = 0, controls = NA)
})


output$callhome_Japanese_sample2 <- renderUI({
  addResourcePath("www", "./www")
  tags$iframe(style="height:600px; width:100%", src="www/callhome_Japanese/ja_0743.pdf")
})

output$callhome_Japanese_sample2_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/callhome_Japanese/ja_0743.mp3", type = "audio/mp3", autostart = 0, controls = NA)
})


output$callhome_Japanese_sample3 <- renderUI({
  addResourcePath("www", "./www")
  tags$iframe(style="height:600px; width:100%", src="www/callhome_Japanese/ja_0856.pdf")
})

output$callhome_Japanese_sample3_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/callhome_Japanese/ja_0856.mp3", type = "audio/mp3", autostart = 0, controls = NA)
})
