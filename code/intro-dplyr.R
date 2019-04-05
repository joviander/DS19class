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
  select(year, population = pop, country)
europe_table <- table(europe$country)
View(europe_table)

#working with group_by() and summarize() replace pivot tables

str(gapminder %>% group_by(continent))

#summarize gdp by continent
gdp_continent <-  gapminder %>%
  group_by(continent)%>%
  summarize(mean_gdp = mean(gdpPercap))

View(gdp_continent)

#put in chart needs help (mean_lifeExp not found)

library(ggplot2)
summary_plot <- gdp_continent %>%
  ggplot(aes(x = mean_gdp, y = mean_lifeExp)) +
  geom_point(stat = "identity") +
  theme_bw()
summary_plot

#calculate mean population for all the continents

gdp_continent <-  gapminder %>%
  group_by(continent)%>%
  summarize(mean_pop = mean(pop))


# sqrt details
gapminder %>%
  group_by(continent) %>%
  summarize(se = sd(lifeExp)/sqrt(n()))

#mutate() is my friend??? diff from summarize, add a new column, 
#to make a calculation and a new outut in your dataframe

xy <- data.frame(x = rnorm(100),
                 y = rnorm(100))
head(xy)
xyz <- xy %>%
  mutate(z = x*y)
head(xyz)
  
#add a column that gives full gdp per country and then by continent
total_gdp_country <- gapminder %>%
  mutate(totalgdp = pop*gdpPercap)
head(total_gdp_country)


gdp_per_cont <- gapminder%>%
  mutate(total_gdp = pop*gdpPercap) %>%
  group_by(continent) %>%
  summarise(cont_gdp = sum(total_gdp))
gdp_per_cont




#another way same detail as above
gdp_per_cont <- total_gdp_country %>%
  group_by(continent)  %>%
  summarise(cont_gdp = sum(total_gdp))
gdp_per_cont

  






  
