#--------------------------------------------------------------------
###############################Install Related Packages #######################
if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}
if (!require("tibble")) {
  install.packages("tibble")
  library(tibble)
}
if (!require("tidyverse")) {
  install.packages("tidyverse")
  library(tidyverse)
}
if (!require("shinythemes")) {
  install.packages("shinythemes")
  library(shinythemes)
}

if (!require("sf")) {
  install.packages("sf")
  library(sf)
}
if (!require("RCurl")) {
  install.packages("RCurl")
  library(RCurl)
}
if (!require("tmap")) {
  install.packages("tmap")
  library(tmap)
}
if (!require("rgdal")) {
  install.packages("rgdal")
  library(rgdal)
}
if (!require("leaflet")) {
  install.packages("leaflet")
  library(leaflet)
}
if (!require("shiny")) {
  install.packages("shiny")
  library(shiny)
}
if (!require("shinythemes")) {
  install.packages("shinythemes")
  library(shinythemes)
}
if (!require("plotly")) {
  install.packages("plotly")
  library(plotly)
}
if (!require("ggplot2")) {
  install.packages("ggplot2")
  library(ggplot2)
}
if (!require("viridis")) {
  install.packages("viridis")
  library(viridis)
}
if (!require("timevis")) {
  install.packages("timevis")
  library(timevis)
}
if (!require("shinyWidgets")) {
  install.packages("shinyWidgets")
  library(shinyWidgets)
}
if (!require("lubridate")) {
  install.packages("lubridate")
  library(lubridate)
}
if (!require("DT")) {
  install.packages("DT")
  library(DT)
}
if (!require("jsonlite")) {
  install.packages("jsonlite")
  library(jsonlite)
}
if (!require("plotly")) {
  install.packages("plotly")
  library(plotly)
}
if (!require("xts")) {
  install.packages("xts")
  library(xts)
}
if (!require("dygraphs")) {
  install.packages("dygraphs")
  library(dygraphs)
}


#--------------------------------------------------------------------
#setwd("~/ADS/Fall2020-Project2-group7/data")

data <- read.csv("../data/Events.csv")
View(data)
colnames(data) <- c("id", "start","end","content")
data$start <- as.Date(data$start,"%m/%d/%Y")
data <- data.frame(
  content = data$content,
  start   = data$start
)

sales_data = read.csv('../data/case-hosp-death.csv')
date <- as.Date(sales_data$DATE_OF_INTEREST,"%m/%d/%Y")
cases <- as.numeric(sales_data$CASE_COUNT)
<<<<<<< HEAD
sales_data <- xts(cases,date)
=======
sales_data <- xts(cases,date)

>>>>>>> 014180c6b4f48651b7f5485d3af1911701f3d20d
