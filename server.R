shinyServer(function(input, output, session) {
  
  source(file.path("server", "visualInspection_server.R"),  local = TRUE)$value
  source(file.path("server", "seeCorpusBy_server.R"),  local = TRUE)$value
  source(file.path("server", "mapIntegration_server.R"),  local = TRUE)$value
  source(file.path("server", "networkInspection_server.R"),  local = TRUE)$value
  source(file.path("server", "datasets_server.R"),  local = TRUE)$value
  
  source(file.path("server", "sample_dutch_server.R"),  local = TRUE)$value
  source(file.path("server", "sample_korean_server.R"),  local = TRUE)$value
  source(file.path("server", "sample_japanese_server.R"),  local = TRUE)$value
  
  source(file.path("server", "networkReferences_server.R"),  local = TRUE)$value

}
)