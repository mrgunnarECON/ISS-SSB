

install.packages("xlsx")
library(xlsx)
library(tidyverse)


data <- read_excel("SBS NAMA data.xlsx", sheet=2)

data$year2013 <- as.numeric(data$year2013, na.exclude=T)
class(data$year2013)

data$year2014 <- as.numeric(data$year2014, na.exclude=T)
data$year2015 <- as.numeric(data$year2015, na.exclude=T)
data$year2016 <- as.numeric(data$year2016, na.exclude=T)
data$year2017 <- as.numeric(data$year2017, na.exclude=T)
data$year2018 <- as.numeric(data$year2018, na.exclude=T)
data$year2019 <- as.numeric(data$year2019, na.exclude=T)
data$year2020 <- as.numeric(data$year2020, na.exclude=T)




nama <- data %>%
  filter(Dataset == "NAMA") %>%
  pivot_longer(cols = starts_with("year"), names_to = "year", values_to = "value_nama")


sbs <- data %>%
  filter(Dataset== "SBS") %>%
  pivot_longer(cols = starts_with("year"), names_to = "year", values_to = "value_sbs")


            
df <- nama %>%
  left_join(sbs, by = c("Countries", "year", "Category"))


df$tot_diff <- df$value_sbs-df$value_nama

df$average_value <- df$value_nama+df$value_sbs/2


df$percentage_diff <- ((df$value_sbs - df$value_nama)/df$value_sbs)*100


df$year <- gsub(pattern = "year", 
                replacement = "",
                df$year ) 

save(df, file = "nama_sbs_comparison.rda") 

