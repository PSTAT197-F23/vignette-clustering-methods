library(tidyverse)
library(dplyr)
root_dir <- rprojroot::find_rstudio_root_file()
data_dir <- file.path(root_dir, "data")
setwd(data_dir)
raw <- read.csv("winequalityN.csv", header = TRUE)

raw %>% 
  group_by(quality) %>% 
  summarize(count= n())


quality_low <- raw %>%
  filter(quality <= 5) %>%
  select(-quality)

quality_high <- raw %>%
  filter(quality >= 6) %>%
  select(-quality)

# Write to CSV files
write.csv(quality_low, "quality_low.csv", row.names = FALSE)
write.csv(quality_high, "quality_high.csv", row.names = FALSE)

