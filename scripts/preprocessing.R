library(tidyverse)
library(dplyr)
root_dir <- rprojroot::find_rstudio_root_file()
data_dir <- file.path(root_dir, "data")
setwd(data_dir)
raw <- read.csv("winequalityN.csv", header = TRUE)

raw %>% 
  group_by(quality) %>% 
  summarize(count= n())

#filter by low quality
quality_low <- raw %>%
  filter(quality <= 5) %>%
  select(-quality)

#filter by high quality
quality_high <- raw %>%
  filter(quality >= 6) %>%
  select(-quality)

# Write to CSV files
write.csv(quality_low, "quality_low.csv", row.names = FALSE)
write.csv(quality_high, "quality_high.csv", row.names = FALSE)

#filter for red wine
red <- raw %>% filter(type == 'red')

#filter for white wine
white <- raw %>% filter(type == 'white')

# write red and white to csv 
write.csv(red, 'red.csv', row.names = FALSE)
write.csv(white, 'white.csv', row.names = FALSE)

#wine origin data
winedata <- read.table(unz('/Users/kaylakatakis/downloads/wine.zip',
                           'wine.data'), sep = ',')
colnames(winedata) <- c('class','Alcohol', 'Malic acid', 'Ash','Alcalinity of ash',
                        'Magnesium','Total phenols','Flavanoids',
                        'Nonflavanoid phenols', 'Proanthocyanins','Color intensity',
                        'Hue','OD280/OD315 of diluted wines','Proline')