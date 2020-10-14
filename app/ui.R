
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#ag
#    http://shiny.rstudio.com/
#
# Define UI for application that draws a histogram
library(viridis)
library(dplyr)
library(tibble)
library(tidyverse)
library(shinythemes)
library(sf)
library(RCurl)
library(tmap)
library(rgdal)
library(leaflet)
library(shiny)
library(shinythemes)
library(plotly)
library(ggplot2)
library(timevis)
library(shinydashboard)
212#load('./output/covid-19.RData')


shinyUI(
  fluidPage(titlePanel(title="")
            ,navbarPage(title = "",position = c("fixed-bottom"),
                        #Select whichever theme works for the app 
                        theme = shinytheme("united"),
                        #--------------------------
                        #tab panel 1 - Time tine of COVID
                        tabPanel("ABOUT",icon = icon("home") ,
                                 dashboardBody(
                                     tags$img(src = "Coronavirus.png",height = "393px",
                                              width = "700px",
                                              style = 'position: absolute; opacity: 0.2;')
                                   ),
                                
                                # img(src = "Coronavirus.png",align = "right"),
                                 #img(src = "Rest-COVID.png",align = "bottom"),
                                 HTML(
                                   paste(
                                     h1("COVID-19 as we know it!",sep = "\n"),
                                     h6("(play on words from the movie, 'Life as we know it')"),
                                     
                                     h5("Authors: Siyu D., Sneha S., Luyao S., Mengyao H., Wannian L."),'<br/>'
                                     ,'<br/>','<br/>','<br/>','<br/>','<br/>',
                                    # h4("Tabs:",sep = "\n"),
                                    # h5("1. Timeline of Economic Events & Daily Cases", sep = "\n"),
                                    
                                     #h5("2. Weather v.s. Daily Cases", sep = "\n"),
                                     
                                     #h5("3. Filter of Restaurents by Positive Case Rate", sep = "\n"),
                                     '<br/>','<br/>','<br/>','<br/>','<br/>','<br/>','<br/>','<br/>','<br/>',
                                     h3("Enjoy the app!")
                                   )
                                 )
                        ),
                        #--------------------------
                        #tab panel 2 - Time tine of COVID
                        
                        tabPanel("TIMELINE OF ECONOMIC EVENTS & DAILY COVID CASES",icon = icon("calendar"),
                                 dygraphOutput("dygraph"),
                                 fluidPage(timevisOutput("timelineGroups")),
                                 HTML(
                                   paste(
                                     h5("About: The top graph represents daily cases and the bottom timeline represents COVID related events which impacted the economy.
                                     You can adjust the band in the middle of the two graphs to view a specific date ranges and details. The rates of events peaked around March, as you can see. Also the occurance of new events died down around late May. The graph correlates with the timeline on April 6th which shows the highest recorded number of COVID cases.",sep = "\n")
                                   ))
                                 
                        ),
                        
                        #--------------------------
                        #tab panel 3 - 
                        
                        tabPanel("WEATHER VS. DAILY COVID CASES",icon = icon("bar-chart-o"),
                                 dateRangeInput("date", strong("Date range"), start = "2020-02-29",
                                                end = "2020-09-30", min = "2020-02-29", max = "2020-09-30", format = "yyyy-mm-dd") ,
                                 HTML(
                                   paste(
                                     h5("About: The President clamed that high temperature will lower the amount of cases. 
                                        This tab shows graphs of the relationship between cases and temperature and individual graphs of daily cases and temperature 
                                        from Feb. 29th, 2020 to Sept. 30th, 2020.
                                        Using this tab you can moniter the rise and fall in tempreature and the respective daily cases.
                                        When calculating NYC temperature, we have taken a avrage of the temperature in 32 randomly sampled NYC cities.",sep = "\n")
                                     
                                   )),
                                 mainPanel(
                                   fluidRow(column(12,
                                                  plotOutput(outputId= "main_plot",width="900px",click = "plot_click")
                                                  ),
                                             column(6,
                                                    plotlyOutput("time1")
                                             ),
                                             column(6,
                                                    plotlyOutput("time2")
                                             ),
                                             column(4,
                                                    tableOutput(outputId= "summary1")
                                             ),
                                             column(4,
                                                    tableOutput(outputId= "summary2")
                                             )
                                             
                                   
                                   )
                                   )
                               
                        ),
                        
                        
                        
                        
                        #--------------------------
                        #tab panel 4 - 
                        tabPanel("Filter of Restaurents by Positive Case Rate",icon =icon("bar-chart-o"), HTML(
                          paste(
                            h5("About:",sep = "\n")
                            
                          )) ,
                                 fluidPage( 
                                   titlePanel("Restaurant"),
                                   sidebarLayout(
                                     sidebarPanel(
                                       selectInput("boro", "Choose the Borough",
                                                   choices = restaurant$BORO,
                                                   multiple = T),
                                       selectInput("cai","Select the Cuisine/Food You Like",
                                                   choices = restaurant$CUISINE, multiple = T),
                                       sliderInput("range","Covid Positive Rate",0,7,.1, value = c(0,1))
                                       
                                     ),
                                     mainPanel(
                                       
                                         leafletOutput("map_density",height = "315px"),
                                         DT::dataTableOutput("canting")
                                       
                                       
                                       
                                     )
                                   )
                                 )
                                 
                        
            ),                   ####https://fontawesome.com/icons?from=io########
            #--------------------------
            #tab panel 1 - Time tine of COVID
            tabPanel("BIASES",icon = icon("cog") ,
                     HTML(
                       paste(
                         h1("Biases:"),'<br/>'                                                        )
                     )
            )
            
  )
)
)

