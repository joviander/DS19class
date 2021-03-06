# plotting Biketown data with base R
install.packages("tidyverse")
library(tidyverse)
library(lubridate)

biketown <- read.csv("data/biketown-2018-trips/biketown-2018-trips.csv")
str(biketown)

summary(biketown)
# convert time
# this is tidyverse
biketown$hour <- 
  hms(biketown$StartTime) %>%
  hour()
# same as this in base
table(biketown$hour)
stime <- hms(biketown$StartTime)
biketown$hour <- hours(stime)

freq_by_hour <- table(biketown$hour)

barplot(freq_by_hour)

hist(freq_by_hour)
#investigate hourly bins
hist(biketown$hour, breaks = seq(0, 24, 3))

#look at the morning peak, focus on am peak
am_peak <- subset(biketown, hour >= 7 & hour<10)

hist(am_peak$hour,breaks = seq(7, 10, 1)) #not great

barplot(table(am_peak$hour))
