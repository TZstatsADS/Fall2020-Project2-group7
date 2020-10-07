#
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
shinyUI(navbarPage(title = 'COVID-19',
                   fluid = TRUE,
                   collapsible = TRUE,
                   #Select whichever theme works for the app 
                   theme = shinytheme("cerulean"),
                   #--------------------------
                   #tab panel 1 - Time tine of COVID
                  
                   tabPanel("Timeline of Economy",icon = icon("calendar"),
                            dygraphOutput("dygraph"),
                            fluidPage(timevisOutput("timelineGroups"))),
#--------------------------
#tab panel 2 - 
tabPanel("Cases",icon = icon("star") 
         #, fluidPage(timevisOutput("timelineGroups"))
         ),
#--------------------------
#tab panel 3 - 
tabPanel("tab3",icon = icon("home")
         #,fluidPage(timevisOutput("timeline"))
         )

))

