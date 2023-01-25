#Load Libraries

library(shiny)
library(tidyverse)
library(echarts4r)
library(echarts4r.assets)
library(echarts4r.maps)
library(echarts4r.suite)
library(reshape2)
library(zoo)
library(geojsonsf)
library(sf)
library(leaflet)
library(lubridate)
library(varhandle)
library(shinyjqui)
library(shinyalert)
library(shinyBS)
library(shinyWidgets)
library(plotly)
library(countrycode)
library(visNetwork)
library(DT)
library(formattable)
library(jsonify)
library(mapdeck)
library(highcharter)
library(streamgraph)
library(viridis)
library(shinydashboard)
library(XML)
library(grImport)
library(gridExtra)
library(RCurl)
library(htmltidy)
library(readr)
library(formattable)
library(DT)
library(stopwords)

shinyUI(fluidPage(theme = "_bootswatch.scss",
                  navbarPage("CoDirectS",
                             tabPanel("HOME",
                                      tags$h1('CoDirectS'),
                                      tags$h2('Collective Directory of Speech Databases'),
                                      tags$h5('This is a demo version of an initiative to create a comprehensive directory of speech adatbases available worldwide. The main focus in on corpora relevant to forensic phonetic studies, such as speaker identification and variation. The aim is to allow willing users to contribute to the directory by constantly updating it. It will facilitate locating available speech data and consequently, the potential to contrinute to the growth and strenthening of existing corpora.'),
                                      tags$hr(),
                                      tags$h5('Developer:'),
                                      tags$a(href="https://www.visualcv.com/simongonzalez/", 
                                             "Simon Gonzalez (simon.gonzalez@anu.edu.au)", 
                                             target="_blank")
                             ),
                             tabPanel("Datasets",
                                      tags$a(href="http://www.helsinki.fi/varieng/CoRD/corpora/corpusfinder/", 
                                             "Go to Source (VARIENG): Research unit for variation, contacts and change in English", 
                                             target="_blank"),
                                      tags$hr(),
                                      dataTableOutput('alltable')       
                             ),
                             tabPanel("Visual Inspection",
                                      tags$a(href="https://www.clarin.eu/resource-families/spoken-corpora", 
                                             "Go to Source (CLARIN): European Research Infrastructure for Language Resources and Technology", 
                                             target="_blank"),
                                      tags$hr(),
                                      
                                      fluidRow(
                                        column(6,
                                               echarts4rOutput('visualInspection1')
                                        ),
                                        column(6,
                                               echarts4rOutput("visualInspection2")
                                        )
                                      ),
                                      fluidRow(
                                        column(6,
                                               echarts4rOutput("visualInspection3")
                                        ),
                                        column(6,
                                               echarts4rOutput("visualInspection4")
                                        )
                                      )
                             ),
                             navbarMenu("See Corpus by",
                                        tabPanel("Overall",
                                                 tags$a(href="https://www.clarin.eu/resource-families/spoken-corpora", 
                                                        "Go to Source (CLARIN): European Research Infrastructure for Language Resources and Technology", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 uiOutput('isolateCorpusui'),
                                                 jqui_resizable(echarts4rOutput("sankeyOutputOverall"))
                                        ),
                                        tabPanel("Language",
                                                 tags$a(href="https://www.clarin.eu/resource-families/spoken-corpora", 
                                                        "Go to Source (CLARIN): European Research Infrastructure for Language Resources and Technology", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 uiOutput('isolateLanguageui'),
                                                 jqui_resizable(echarts4rOutput("sankeyOutputLanguage"))
                                        ),
                                        tabPanel("Speech Type",
                                                 tags$a(href="https://www.clarin.eu/resource-families/spoken-corpora", 
                                                        "Go to Source (CLARIN): European Research Infrastructure for Language Resources and Technology", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 uiOutput('isolateSpeechui'),
                                                 jqui_resizable(echarts4rOutput("sankeyOutputSpeechType"))
                                        ),
                                        tabPanel("Licence",
                                                 tags$a(href="https://www.clarin.eu/resource-families/spoken-corpora", 
                                                        "Go to Source (CLARIN): European Research Infrastructure for Language Resources and Technology", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 uiOutput('isolateLicenceui'),
                                                 jqui_resizable(echarts4rOutput("sankeyOutputLicence"))
                                        ),
                                        tabPanel("Annotation",
                                                 tags$a(href="https://www.clarin.eu/resource-families/spoken-corpora", 
                                                        "Go to Source (CLARIN): European Research Infrastructure for Language Resources and Technology", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 uiOutput('isolateAnnotationui'),
                                                 jqui_resizable(echarts4rOutput("sankeyOutputAnnotation"))
                                        ),
                                        tabPanel("Country",
                                                 tags$a(href="https://www.clarin.eu/resource-families/spoken-corpora", 
                                                        "Go to Source (CLARIN): European Research Infrastructure for Language Resources and Technology", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 uiOutput('isolateCountryui'),
                                                 jqui_resizable(echarts4rOutput("sankeyOutputCountry"))
                                        )
                             ),
                             tabPanel("Network Inspection",
                                      
                                      tags$a(href="https://github.com/JRMeyer/open-speech-corpora", 
                                             "Go to Source (Open Speech Corpora): A list of open speech corpora for Speech Technology research and development", 
                                             target="_blank"),
                                      tags$hr(),
                                      visNetworkOutput("network"),
                                      uiOutput("urllink"),
                                      formattableOutput('tbl'),
                                      DTOutput('table')
                             ),
                             tabPanel("Map Integration",
                                      tags$a(href="https://austalk.edu.au/", 
                                             "Go to Source (AusTalk): An audio-visual corpus of Australian English", 
                                             target="_blank"),
                                      tags$hr(),
                                      sidebarLayout(
                                        sidebarPanel(
                                          selectInput("mapIntOptions", "Choose a map type:",
                                                      choices = c("Overall Speakers", 
                                                                  "Individual Speakers", "World Connections")),
                                          uiOutput('dispMessage')
                                        ),
                                        mainPanel(
                                          conditionalPanel(
                                            condition = "input.mapIntOptions != 'World Connections'",
                                            jqui_resizable(echarts4rOutput("austalkOutputEC"))
                                          ),
                                          conditionalPanel(
                                            condition = "input.mapIntOptions == 'World Connections'",
                                            jqui_resizable(mapdeckOutput("austalkOutputMD"))
                                          ),
                                          echarts4rOutput("mapplot1")
                                        ))),
                             navbarMenu("Sample Files",
                                        tabPanel("The Spoken Dutch Corpus project",
                                                 
                                                 tags$a(href="http://lands.let.ru.nl/cgn/doc_English/topics/project/pro_info.htm", 
                                                        "Go to Source: The Spoken Dutch Corpus project", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 
                                                 tabBox(width = 12,
                                                        id = "tabset1", height = "250px",
                                                        tabPanel("Record announcement", "",
                                                                 htmlOutput('theSpokenDutchCorpusProject_sample1'),
                                                                 tags$hr(),
                                                                 tags$h4('Audio file'),
                                                                 uiOutput('theSpokenDutchCorpusProject_sample1_audio')),
                                                        tabPanel("Sports commentary", "",
                                                                 htmlOutput('theSpokenDutchCorpusProject_sample2'),
                                                                 tags$hr(),
                                                                 tags$h4('Audio file'),
                                                                 uiOutput('theSpokenDutchCorpusProject_sample2_audio')),
                                                        tabPanel("Sports news", "",
                                                                 htmlOutput('theSpokenDutchCorpusProject_sample3'),
                                                                 tags$hr(),
                                                                 tags$h4('Audio file'),
                                                                 uiOutput('theSpokenDutchCorpusProject_sample3_audio')),
                                                        tabPanel("POS tagging and lemmatization", "",
                                                                 htmlOutput('theSpokenDutchCorpusProject_tagging')
                                                        )
                                                 )
                                        ),
                                        tabPanel("CALLHOME Japanese",
                                                 
                                                 tags$a(href="https://www.ldc.upenn.edu/", 
                                                        "Go to Source (LDC): Linguistic Data Consortium", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 
                                                 tabBox(width = 12,
                                                        id = "tabset1", height = "250px",
                                                        tabPanel("Overview", "",
                                                                 htmlOutput('callhome_Japanese_ovv')),
                                                        tabPanel("Sample 1", "",
                                                                 htmlOutput('callhome_Japanese_sample1_audio'),
                                                                 htmlOutput('callhome_Japanese_sample1')
                                                                 
                                                        ),
                                                        tabPanel("Sample 2", "",
                                                                 htmlOutput('callhome_Japanese_sample2_audio'),
                                                                 htmlOutput('callhome_Japanese_sample2')
                                                                 
                                                        ),
                                                        tabPanel("Sample 3", "",
                                                                 htmlOutput('callhome_Japanese_sample3_audio'),
                                                                 htmlOutput('callhome_Japanese_sample3')
                                                                 
                                                        )
                                                 )
                                        ),
                                        tabPanel("West Point Korean Speech",
                                                 
                                                 tags$a(href="https://www.ldc.upenn.edu/", 
                                                        "Go to Source (LDC): Linguistic Data Consortium", 
                                                        target="_blank"),
                                                 tags$hr(),
                                                 
                                                 tabBox(width = 12,
                                                        id = "tabset1", height = "250px",
                                                        tabPanel("Overview", "",
                                                                 htmlOutput('westPointKoreanSpeech_ovv')),
                                                        tabPanel("Auido files and transcriptions", "",
                                                                 textOutput('westPointKoreanSpeech_sample1'),
                                                                 uiOutput('westPointKoreanSpeech_sample1_audio'),
                                                                 tags$hr(),
                                                                 textOutput('westPointKoreanSpeech_sample2'),
                                                                 uiOutput('westPointKoreanSpeech_sample2_audio'),
                                                                 tags$hr(),
                                                                 textOutput('westPointKoreanSpeech_sample3'),
                                                                 uiOutput('westPointKoreanSpeech_sample3_audio'),
                                                                 tags$hr(),
                                                                 textOutput('westPointKoreanSpeech_sample4'),
                                                                 uiOutput('westPointKoreanSpeech_sample4_audio'),
                                                                 tags$hr(),
                                                                 textOutput('westPointKoreanSpeech_sample5'),
                                                                 uiOutput('westPointKoreanSpeech_sample5_audio'),
                                                                 tags$hr(),
                                                                 textOutput('westPointKoreanSpeech_sample6'),
                                                                 uiOutput('westPointKoreanSpeech_sample6_audio')
                                                        )
                                                 )
                                        )
                             ),
                             tabPanel("Reference Correlations (TIMIT)",
                                      tabBox(width = 12,
                                             id = "tabset1", height = "250px",
                                             tabPanel("References", "",
                                                      htmlOutput('allReferences')),
                                             tabPanel("Correlations", "",
                                                      visNetworkOutput("networkReferences"))
                                      )
                                      
                             )
                  )))
