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


wines <- read_csv('winequalityN.csv')
summary(wines)

# 7 different types of quality : "6 5 7 8 4 3 9"
unique(wines$quality)

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


# Simple Hierarchy
clusters <- hclust(dist(wine_norm))
plot(clusters)
clusterCut <- cutree(clusters, 7)
table(clusterCut, wines$quality)

# Euclidean Distance (better performance than simple)
clusters_euc <- hclust(dist(wine_norm), method = 'average')
plot(clusters_euc)
clusterCut_euc <- cutree(clusters_euc, 7)
table(clusterCut_euc, wines$quality)

# Plot the clusters
ggplot(wines, aes(`fixed acidity`, alcohol, color = wines$quality)) + 
  geom_point(alpha = 0.4, size = 1) + geom_point(col = clusterCut_euc)



# Agglomerative Hierarchical Clustering
# We can perform agglomerative HC with hclust. 
# First we compute the dissimilarity values with dist and then feed these values into hclust and specify the agglomeration method to be used (i.e. “complete”, “average”, “single”, “ward.D”). We can then plot the dendrogram.

# Dissimilarity matrix
agg_dist <- dist(wine_norm, method = "euclidean")
# Hierarchical clustering using Complete Linkage
hc1 <- hclust(agg_dist, method = "complete" )
# Plot the obtained dendrogram
plot(hc1, cex = 0.6, hang = -1)


# Divisive Hierarchical Clustering
# Won't work for our data set? Because we have so many observations