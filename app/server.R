#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#-------------------------------------------------App Server----------------------------------
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
#can run RData directly to get the necessary date for the app
#global.r will enable us to get new data everyday
#update data with automated script
#setwd("~/ADS/Fall2020-Project2-group7/app")
source("global.R") 
#load('./output/covid-19.RData')
shinyServer(function(input, output, session) {
  #----------------------------------------
  #tab panel 1 - Home Plots
  #preapare data for plot
  selected_data <- reactive({
    test <- data[data$start %in% seq(from=min(as.Date(strftime(req(input$dygraph_date_window[[1]]), "%Y-%m-%d"))),
                                     to=max(as.Date(strftime(req(input$dygraph_date_window[[2]]), "%Y-%m-%d"))), by = 0.02),]
  })
  
  output$timelineGroups <- renderTimevis({
    data_selected = selected_data()
    timevis(data = as.data.frame(data_selected) , options = list(stack = FALSE))
  })
  
  
  ## daily sales plot output 
  output$dygraph<-renderDygraph({
    dygraph(sales_data, main = "Covid-19 Daily Cases") %>% 
      dyRangeSelector(dateWindow = c("2020-02-01", "2020-09-30"))
  })
  
  output$timeline <- renderTimevis({
    timevis(data)
  })
  
})