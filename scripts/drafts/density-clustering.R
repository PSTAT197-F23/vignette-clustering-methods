#Density-Based clustering methods
library(tidyverse)
library(dbscan)
library(ggplot2)
library(cluster)
library(GGally)

data <- read.csv('../data/winequalityN.csv')

#exploring acidity
features <- data[, c("volatile.acidity", "fixed.acidity")]

#standardize
features <- scale(features)

#pair plot
pairs(features)

#run DBSCAN
dbscan_result <- dbscan(features, eps = .5, minPts = 5)

#access cluster assignments
clusters <- dbscan_result$cluster

#visualize the clusters
ggplot() +
  geom_point(aes(x = features[, 1], y = features[, 2], color = factor(clusters))) +
  labs(title = "DBSCAN Clustering of Wine Quality Dataset",
       x = "Fixed Acidity",
       y = "Volatile Acidity",
       color = "Cluster") +
  theme_minimal()

#compare wine quality across clusters
ggplot(data, aes(x = factor(clusters), fill = factor(type))) +
  geom_bar(position = "fill") +
  labs(title = "Distribution of Wine Quality Across Clusters",
       x = "Cluster",
       y = "Proportion",
       fill = "Wine Quality") +
  theme_minimal()



#trying to visualize all possible combinations at once
#remove rows with missing values
data <- na.omit(data)

#select all features
features <- data[, c("fixed.acidity", "volatile.acidity", "citric.acid", "residual.sugar", "chlorides", "free.sulfur.dioxide", "total.sulfur.dioxide", "density", "pH", "sulphates", "alcohol")]

#run dbscan and access clusters
dbscan_result <- dbscan(features, eps = 0.5, minPts = 5)
clusters <- dbscan_result$cluster

#combine features and cluster assignments into a data frame
data_with_clusters <- cbind(features, Cluster = factor(clusters))

#create a scatterplot matrix with DBSCAN cluster coloring
ggpairs(data_with_clusters, columns = 1:ncol(features), aes(color = Cluster))



