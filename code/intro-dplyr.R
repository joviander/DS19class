# intro to dplyr
library(dplyr)

gapminder <- read.csv("data/gapminder_data.csv", stringsAsFactors = F)

#factors mean they are characters or factors 
gapminder$continent <-  as.factor(gapminder$continent)

mean (gapminder[gapminder$continent == "Africa", "gdpPercap"])

#this is a pipe %>%
# functions we will learn today in dplyr:
#1. select()
#2. Filter ()
#3. group_by ()
#4. summarize ()
#5. mutate ()

#what attributes in gapminder:

subset_1 <- gapminder %>%
  select(country, continent, lifeExp)

#select three attributes from gapminder:

subset_2 <- gapminder %>%
  select(-lifeExp, -pop)
str(subset_2)

#select some attributes but rename a few of them for clarity
subset_3 <- gapminder %>%
  select(country, population = pop, lifeExp, gdp = gdpPercap)
str (subset_3)

#using filter()
africa <- gapminder %>%
  filter(continent == "Africa") %>%
  select(country, population = pop, lifeExp)

#did not use pipe
africa <- filter(gapminder, continent == "Africa")
africa <- select(africa,country, population = pop, lifeExp)

#select year, population, country, for europe
europe <- gapminder %>%
    filter(continent == "Europe") %>%
  select(year,population = pop, country)
europe_table <- table(europe$country)
View(europe_table)



