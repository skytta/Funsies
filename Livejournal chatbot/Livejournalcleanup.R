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

Livejournal11 <- read.csv(file ='Downloads/laleche-2001-11.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal10 <- read.csv(file ='Downloads/laleche-2001-10.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal9 <- read.csv(file ='Downloads/laleche-2001-9.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal8 <- read.csv(file ='Downloads/laleche-2001-8.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal7 <- read.csv(file ='Downloads/laleche-2001-7.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal6 <- read.csv(file ='Downloads/laleche-2001-6.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal5 <- read.csv(file ='Downloads/laleche-2001-5.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal4 <- read.csv(file ='Downloads/laleche-2001-4.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal3 <- read.csv(file ='Downloads/laleche-2001-3.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal2 <- read.csv(file ='Downloads/laleche-2001-2.csv', fileEncoding="UTF-8-BOM", na.strings = '..')
Livejournal12 <- read.csv(file ='Downloads/laleche-2001-12.csv', fileEncoding="UTF-8-BOM", na.strings = '..')

Livejournal2

lj<- rbind(Livejournal8,Livejournal9)
lj1<-rbind(lj, Livejournal10)
lj2<-rbind(lj1, Livejournal11)
lj3<-rbind(lj2, Livejournal12)

# save new dataframe
write.csv(lj3, "Downloads/lj2001.csv", row.names=FALSE)

basic_eda <- function(data)
{
  glimpse(data)
  print(status(data))
  freq(data) 
  print(profiling_num(data))
  plot_num(data)
  describe(data)
}

basic_eda(lj3)

