# load packages
library(tidyverse)

# read in data
housing <- read.csv('data/housing.csv', header = TRUE)
head(housing)

# normalize data
housing_norm <- scale(housing)
head(housing_norm)

# perform k-means clustering with k = 3
kmeans <- kmeans(housing_norm, 3)

## HERE: make SSwithin plots to tune k

# append cluster assignments to the data
housing$cluster <- kmeans$cluster

# display the cluster assignments
print(kmeans$cluster)

# display the centroids of each cluster
print(kmeans$centers)

# cluster plots
ggplot(housing, aes(MedInc, log(Population), color = factor(cluster))) +
  geom_point()
ggplot(housing, aes(MedHouseVal, MedInc, color = factor(cluster))) +
  geom_point()

# clusters on map of california
ggplot(housing, aes(Longitude, Latitude, color = factor(cluster))) +
  geom_point()
