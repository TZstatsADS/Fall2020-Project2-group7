#### sample of the cities in NY to get avrage temp. ####

set.seed(1)
sample(63, 32)

#### Find temp ####
#install.packages("csv")
library(csv)
library(plyr)
library(readr)


setwd("~/ADS/Fall2020-Project2-group7/data/Weather_data")
filenames = list.files(pattern="*.csv")
dataset_weather <- read.csv(filenames[1])
for (i in 2:32){
  dataset_weather <- cbind(dataset_weather,read.csv(filenames[i]))
 dataset_weather <- dataset_weather[,-(length(dataset_weather[1,])-3)]
}


#avrage temp

avrage <- dataset_weather[,(seq(3,length(dataset_weather[1,]), 3))]
sum <- c()
Avragev_value <- c()
for (i in 1:length(avrage[,1])){
  sum <- c(sum(avrage[i,]), sum)
  Avragev_value <- c(sum/length(avrage[1,]))
  
  
}
Avrage_tem <- data.frame(cbind(dataset_weather[1], Avragev_value))
colnames(Avrage_tem) <- c("Date", "Avrage_value")
write.csv(Avrage_tem, "~/ADS/Fall2020-Project2-group7/output/Avrage_tem.csv")

#max temp

Max <- dataset_weather[,(seq(2,length(dataset_weather[1,]), 3))]
sum <- c()
Max_value <- c()
for (i in 1:length(Max[,1])){
  sum <- c(sum(Max[i,]), sum)
  Max_value <- c(sum/length(Max[1,]))
  
  
}
Max_tem <- data.frame(cbind(dataset_weather[1], Max_value))
colnames(Max_tem) <- c("Date", "Max_value")
write.csv(Max_tem, "~/ADS/Fall2020-Project2-group7/output/Max.csv")


# min temp

Min <- dataset_weather[,(seq(2,length(dataset_weather[1,]), 3))]
sum <- c()
Min_value <- c()
for (i in 1:length(Min[,1])){
  sum <- c(sum(Min[i,]), sum)
  Min_value <- c(sum/length(Min[1,]))
  
  
}
Min_tem <- data.frame(cbind(dataset_weather[1], Min_value))
colnames(Min_tem) <- c("Date", "Min_value")
write.csv(Min_tem, "~/ADS/Fall2020-Project2-group7/output/Min_tem.csv")


