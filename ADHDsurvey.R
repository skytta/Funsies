#Import the data
#Clean the data
#Process the data
#Visualize the data

install.packages("dplyr")
library("dplyr")
install.packages("corrplot")
library(corrplot)
install.packages("funModeling")
library(funModeling) 
library(Hmisc)

ADHDsurvey <- read.csv(file ='Downloads/SocialMediaSurvey_recode.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
view(ADHDsurvey)

basic_eda <- function(data)
{
  glimpse(data)
  print(status(data))
  freq(data) 
  print(profiling_num(data))
  plot_num(data)
  describe(data)
}

basic_eda(ADHDsurvey)
##############################

status(ADHDsurvey)
#freq(ADHDsurvey)

# plots with descriptions 
ggplot(ADHDsurvey, aes(x=SocMedMostUsed, fill=SocMedMostUsed)) + geom_bar()+
  labs(fill="SocMedMostUsed", title = "Most Used Social Media", x = "Social Media Platform", y = "Total Count")


ggplot(ADHDsurvey, aes(x=dxADHD, fill=dxADHD)) + geom_bar() +
  labs(fill="ADHD dx", title = "ADHD diagnosis by Survey", x = "Clinical Diagnosis of ADHD", y = "Total Count")

