# load packages
library(tidyverse)

# read in data
housing <- read.csv('data/housing.csv', header = TRUE)
head(housing)

# normalize data
housing_norm <- scale(housing)
head(housing_norm)

# initialize list of inertias (TSS within)
inertias <- c()

# get inertias for different values of k
set.seed(888)
for (k in 1:15) {
  model <- kmeans(housing_norm, centers = k)
  inertias <- c(inertias, model$tot.withinss)
}

# plot inertia against k
ggplot() +
  geom_line(aes(x = 1:15, y = inertias)) +
  geom_point(aes(x = 1:15, y = inertias)) +
  labs(title = "Elbow Method Plot", x = "Number of Clusters (k)", y = "Inertia")

# perform k-means clustering with k = 5
kmeans <- kmeans(housing_norm, 5)

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

# perform PCA on the data