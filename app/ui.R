
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
#load('./output/covid-19.RData')


shinyUI(
  fluidPage(titlePanel(title="ADS Project 2")
    ,navbarPage(title = '',
                   fluid = TRUE,
                   collapsible = TRUE,
                   #Select whichever theme works for the app 
                   theme = shinytheme("cerulean"),
                #--------------------------
                #tab panel 1 - Time tine of COVID
                   tabPanel("ABOUT",icon = icon("home") ,
                            img(src = "Coronavirus.png",align = "right"),
                            HTML(
                              paste(
                                h1("This is an app about COVID -19 Facts."),'<br/>',
                                h4("Authors: Siyu D., Sneha S., Luyao S., Mengyao H., Wannian L."),'<br/>',
                                h4("Enjoy the app!")
                              )
                            )
                    ),
                   #--------------------------
                   #tab panel 2 - Time tine of COVID
                   
                   tabPanel("TIMELINE OF ECONOMIC EVENTS",icon = icon("calendar"),
                            dygraphOutput("dygraph"),
                            fluidPage(timevisOutput("timelineGroups"))),
                   #--------------------------
                   #tab panel 3 - 
                   tabPanel("Cases",icon = icon("bacterium") 
                            #, fluidPage(timevisOutput("timelineGroups"))
                   ),
                   #--------------------------
                   #tab panel 4 - 
                   tabPanel("tab3",icon = icon("star")
                            #,fluidPage(timevisOutput("timeline"))
                   ),                   ####https://fontawesome.com/icons?from=io########
                #--------------------------
                #tab panel 1 - Time tine of COVID
                tabPanel("BIASES",icon = icon("cog") ,
                         HTML(
                           paste(
                             h1("Biases:"),'<br/>'                                                        )
                         )
                )
                   
))
)
