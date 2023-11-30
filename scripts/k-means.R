# load packages
library(tidyverse)

# read in data
data <- read.csv('data/winequalityN.csv', header = TRUE)

# separate predictors from response (we do not need the response variable here)
x <- select(data, -quality)

# true cluster plot
ggplot(data, aes(alcohol, pH, color = factor(quality))) +
  geom_point()
