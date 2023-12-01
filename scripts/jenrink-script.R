# Jen Rink Script

#kayla was here

library(MASS)
library(class)
library(tidyverse)
library(ISLR)
library(ISLR2)
library(factoextra)
library(cluster)
root_dir <- rprojroot::find_rstudio_root_file()
data_dir <- file.path(root_dir, "data")
setwd(data_dir)

# 7 different types of quality : "6 5 7 8 4 3 9"
unique(wines$quality)

wines <- read_csv('winequalityN.csv')
summary(wines)

# Remove variable `quality` because we want to do clustering for quality
wines_removed <- subset(wines, select = -c(type, quality))
summary(wines_removed)

# Normalize Data
normalization<-function(x){
  return((x-mean(x))/sd(x))
}

wine_norm<-wines_removed %>%
  mutate(fixed.acidity=normalization(`fixed acidity`),
         volatile.acidity=normalization(`volatile acidity`),
         citric.acid=normalization(`citric acid`),
         residual.sugar=normalization(`residual sugar`),
         chlorides=normalization(chlorides),
         free.sulfur.dioxide=normalization(`free sulfur dioxide`),
         total.sulfur.dioxide=normalization(`total sulfur dioxide`),
         density=normalization(density),
         pH=normalization(pH),
         sulphates=normalization(sulphates),
         alcohol=normalization(alcohol))

summary(wine_norm)

clusters <- hclust(dist(wine_norm))
plot(clusters)

clusterCut <- cutree(clusters, 7)
table(clusterCut, wines$quality)
