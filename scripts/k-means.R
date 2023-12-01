# load packages
library(tidyverse)

# read in data
root_dir <- rprojroot::find_rstudio_root_file()
data_dir <- file.path(root_dir, "data")
setwd(data_dir)
#data <- read.csv("winequalityN.csv", header = TRUE)
#data <- read.csv('data/winequalityN.csv', header = TRUE)

data <- read_csv('white.csv')
# separate predictors from response (we do not need the response variable here)
x <- select(data, -quality)

# true cluster plot
ggplot(data, aes(alcohol, pH, color = factor(quality))) +
  geom_point()
#clusters iffy
