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
library(shinydashboard)
#can run RData directly to get the necessary date for the app
#global.r will enable us to get new data everyday
#update data with automated script
#setwd("~/ADS/Fall2020-Project2-group7/app")
panel_2_data<-read.csv("../output/joined_weather_case_data.csv")
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
    dygraph(sales_data, main = "Covid-19 Daily Cases", ylab = "Daily Covid Cases", xlab = "Dates") %>% 
      dyRangeSelector(dateWindow = c("2020-02-01", "2020-09-30"))
  })
  
  output$timeline <- renderTimevis({
    timevis(data)
  })
  
  
  #----------------------------------------
  #tab panel 2 - Weather and covid-data
  # Subset data
  sub_data <- reactive({
    req(input$date)
    #validate(need(!is.na(input$date[1]) & !is.na(input$date[2]), "Error: Please provide both a start and an end date."))
    #validate(need(input$date[1] < input$date[2], "Error: Start date should be earlier than end date."))
    start = as.Date(input$date[1],format="%Y-%m-%d")
    end = as.Date(input$date[2],format="%Y-%m-%d")
    panel_2_data %>%
      mutate(Date=as.Date(Date),format="%Y-%m-%d")%>%
      filter(
        Date >=start & Date<=end
      )
  })
  
  
  
  # Create scatterplot object the plotOutput function is expecting
  output$main_plot <- renderPlot({
    data1=sub_data()
    ylim.prim<- c(1,6365)           #coronavirus cases
    ylim.sec<-c(21.7,80.3)         #temperature
    
    b <- diff(ylim.prim)/diff(ylim.sec)
    a <- b*(ylim.prim[1] - ylim.sec[1])
    
    
    plot<- ggplot(data1) +
      geom_bar(aes(x=data1$Date,  y=data1$CASE_COUNT, fill="grey"), stat = "identity", position = position_dodge(width = 1)) +
      geom_line(aes(x= data1$Date, y=a+b* (data1$Avg_temp), color="red"),group = 1, size=2)+
      scale_fill_manual(values="grey", name="Case_count")+
      scale_y_continuous(sec.axis = sec_axis(~ (. - a)/b, name = "Temperature(F)")) +
      scale_colour_manual(values="red", name="Temperature")+
      ggtitle("Covid-19 cases and Temperature in NYC")+ 
      labs(x="Date",y= "Case_count")+
      theme(axis.line.y.right = element_line(color = "red",linetype = 2), 
            #axis.ticks.y.right = element_line(color = "red"),
            #axis.text.y.right = element_text(color = "red",size=15, face=3), 
            axis.title.y.right = element_text(color = "red",size=15, face="bold"),
            plot.title= element_text(hjust = 0.5))+
      theme_light()
    plot
  })
  
  #Add summary output
  output$summary1<-renderTable({
    req(input$date)
    data2=sub_data()
    output1<-data2%>%
      select(CASE_COUNT)%>%
      summary()%>%
      as.data.frame()%>%
      select(Freq)%>%
      rename("Case_count_summary"="Freq")
  })
  output$summary2<-renderTable({
    req(input$date)
    data3=sub_data()
    output2<-data3%>%
      select(Avg_temp)%>%
      summary()%>%
      as.data.frame()%>%
      select(Freq)%>%
      rename("Temperature_summary"="Freq")
  })
  
  output$time1 <- renderPlotly({
    # d <- setNames(sub_data(), c("Date", "Case_count","Temperature"))
    # plot_ly(d) %>%
    #   add_lines(x = ~Case_count, y = ~Date,color='temperature')
    data=sub_data()
    plot2<- ggplot(data) +
      geom_bar(aes(x=Date,  y=CASE_COUNT, fill="grey"), stat = "identity",position = position_dodge(width = 1)) +
      scale_fill_manual(values="grey",name="count")+
      scale_x_date(date_labels = "%b/%d")+
      ggtitle("Covid-19 cases in NYC")+ 
      labs(x="Date",y= "Case_count")+
      theme(plot.title= element_text(hjust = 0.5))+
      theme_light()
    ggplotly(plot2)
  })
  output$time2 <- renderPlotly({
    data=sub_data()
    plot3<- ggplot(data) +
      geom_line(aes(x= Date, y=Avg_temp, color="red"),group = 1, size=2)+
      scale_colour_manual(values="red", name="Temp")+
      scale_x_date(date_labels = "%b/%d")+
      ggtitle("Daily Temperature in NYC")+ 
      labs(x="Date",y= "Temperature(F)")+
      theme(plot.title= element_text(hjust = 0.5))+
      theme_light()
    ggplotly(plot3)
  })
  #tab 3
  
  tabPanel('Restaurant & COVID',
           
           
           
           # test <- restaurant_with_covid_s[input$range[1]:input$range[2],],
           
           output$canting <- DT::renderDataTable({
             stateFilter <- subset(restaurant_with_covid_s,
                                   restaurant_with_covid_s$CUISINE == input$cai &
                                     restaurant_with_covid_s$BORO == input$boro &
                                     (restaurant_with_covid_s$POSITIVE_RATE >= min(input$range) & 
                                        restaurant_with_covid_s$POSITIVE_RATE <= max(input$range)))
             # stateFilter <- filter(stateFilter, POSITIVE_RATE %in% input$rate)
           })
           
           
           
           
  )
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
})




