##1 Installation

#install.packages("shiny")
library(shiny)

##2.1 Create an app
#Step 1: Store ui.R and server.R in the same folder.
runApp(getwd())

library(rsconnect)
rsconnect::setAccountInfo(name='abc',
                          token='def',
                          secret='ghi')
deployApp(account='dss')