output$alltable <- renderDataTable({
  
  df <- read.csv('./datasets/varieng.csv')
  
  df <- df[complete.cases(df),]
  
  df$TextSamples <- as.numeric(df$TextSamples)

  dfplot <- as.datatable(
    formattable(df, list(
      Corpus = formatter("span", style = style(font.weight = "bold")),
      Start = color_tile("white", "orange"),
      End = color_tile("white", "orange"),
      Type = formatter("span",
                       style = x ~ ifelse(x == "Spoken",
                                          style(color = "green", font.weight = "bold"),
                                          ifelse(x == "Written",
                                                 style(color = "red", font.weight = "bold"),
                                                 style(color = "blue", font.weight = "bold")))),
      area(col = c(WordCount)) ~ normalize_bar("pink", 0.2),
      area(col = c(TextSamples)) ~ normalize_bar("pink", 0.2),
      Availability = formatter("span",
                               style = x ~ ifelse(x == "Open access",
                                                  style(color = "green", font.weight = "bold"),
                                                  ifelse(x == "Not available",
                                                         style(color = "red", font.weight = "bold"),
                                                         ifelse(x == "Free subscription",
                                                                style(color = "blue", font.weight = "bold"),
                                                                ifelse(x == "License required",
                                                                       style(color = "orange", font.weight = "bold"),
                                                                       ifelse(x == "In preparation",
                                                                              style(color = "brown", font.weight = "bold"),
                                                                              ifelse(x == "Commercial",
                                                                                     style(color = "purple", font.weight = "bold"), NA))))))),
      Annotation = formatter("span",
                             style = x ~ style(color = ifelse(x, "green", "red")),
                             x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No")))
    ))
  )
  
})