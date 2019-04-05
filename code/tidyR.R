library(tidyr)
library(tidyverse)
library(ggplot2)
library(readr)

bikenet <- read_csv("data/bikenet-change.csv")
head(bikenet)

#how are the amounts of different types of facilities
#change over time

summary(factor(bikenet$facility2013))

#let's tidy the table and show how to use the functions
#gather the facility columns into a single layer
#each row will have facility type and year

colnames(bikenet)
bikenet_long <- bikenet %>%
  gather(key="year", value="facility",
         facility2008: facility2013, na.rm = T) %>%
  mutate(year = stringr::str_sub(year,start = -4))
head(bikenet_long)

#collase/unit street and suffix to one value
bikenet_long <- bikenet_long %>%
  unite(col="street", c("name", "ftype"),sep = " ")
head(bikenet_long)


#NOT WORKING FOR ME.  VERIFY
#to seperate street and suffix back to two values
bikenet_long <- bikenet_long %>%
  seperate(street, c("name", "suffix"))
head(bikenet_long)

bikenet_long %>% filter(bikeid == 139730)

#filter and sum meters and miles by facility types
fac_lengths <- bikenet_long %>%
  filter(facility %in% c("BKE-LANE", "BKE-BLVD","BKE-BUFF",
                         "BKE-TRAK", "PTH-REMU")) %>%
  group_by(year,facility) %>%
  summarize(metres = sum(length_m)) %>%
  mutate(miles = metres/1609)
fac_lengths
  



