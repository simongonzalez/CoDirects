output$westPointKoreanSpeech_ovv <- renderUI({
  path <- "./www/WestPointKoreanSpeech/westPointKoreanSpeech_ovv.txt"
  con <- file(path, open = "rt", raw = TRUE)
  text <- readLines(con, skipNul = TRUE)
  close(con)
  
  text <- do.call(c, lapply(text, strsplit, split = "\t"))
  text <- unlist(text, use.names=FALSE)
  
  text <- gsub('^', '<b>', text)
  text <- gsub('\\: ', ':</b> ', text)
  
  HTML(paste(text, collapse = '<br/><br/>'))
  
})

output$westPointKoreanSpeech_sample1 <- renderText({
  "누구와 같이 지내실 예정입니까"
})

output$westPointKoreanSpeech_sample1_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/WestPointKoreanSpeech/59.wav", type = "audio/wav", autostart = 0, controls = NA)
})



output$westPointKoreanSpeech_sample2 <- renderText({
  "그 사람들과는 어떤 관계입니까"
})

output$westPointKoreanSpeech_sample2_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/WestPointKoreanSpeech/60.wav", type = "audio/wav", autostart = 0, controls = NA)
})

output$westPointKoreanSpeech_sample3 <- renderText({
  "이 주동안 여행을 했습니다"
})

output$westPointKoreanSpeech_sample3_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/WestPointKoreanSpeech/61.wav", type = "audio/wav", autostart = 0, controls = NA)
})

output$westPointKoreanSpeech_sample4 <- renderText({
  "그날 발표회도 너무 아름답고 그 자리에 있다는 것도 참 행복했습니다"
})

output$westPointKoreanSpeech_sample4_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/WestPointKoreanSpeech/9359.wav", type = "audio/wav", autostart = 0, controls = NA)
})

output$westPointKoreanSpeech_sample5 <- renderText({
  "그날의 감격스러운 모습을 다시 보고 싶은데 올려주시면 참 감사하겠습니다"
})

output$westPointKoreanSpeech_sample5_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/WestPointKoreanSpeech/9360.wav", type = "audio/wav", autostart = 0, controls = NA)
})

output$westPointKoreanSpeech_sample6 <- renderText({
  "하나님의 경륜에서 우리에게 있어 가장 근본적인 죄가 무엇인가"
})

output$westPointKoreanSpeech_sample6_audio <-renderUI({
  addResourcePath("www", "./www")
  tags$audio(src = "www/WestPointKoreanSpeech/9361.wav", type = "audio/wav", autostart = 0, controls = NA)
})