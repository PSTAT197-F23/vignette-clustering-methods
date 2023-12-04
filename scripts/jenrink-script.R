# Jen Rink Script

#kayla was here

# try Random Samples!!

library(MASS)
library(class)
library(tidyverse)
library(ISLR)
library(ISLR2)
library(factoextra)
library(cluster)
library(ggplot2)
library(hrbrthemes)
root_dir <- rprojroot::find_rstudio_root_file()
data_dir <- file.path(root_dir, "data")
setwd(data_dir)


housing <- read_csv('housing.csv')
summary(housing)


# Remove variable `quality` because we want to do clustering for quality
#wines_removed <- subset(wines, select = -c(type, quality))
#summary(wines_removed)

# Pick just MedInc, Population, Latitude, and Longitude
subset_housing <- select(housing, MedInc, Population, Latitude, Longitude)

# Normalize Data
housing_norm<-as.data.frame(scale(subset_housing))

# Graph of California
ggplot(housing_norm, aes(x=Latitude, y=Longitude, color=MedInc)) + 
  geom_point(size=1) +
  theme_ipsum()


# Ward Hierarchical Clustering
d <- dist(housing_norm,
          method = "euclidean") # distance matrix
fit <- hclust(d, method="ward.D2")

plot(fit, cex=0.000001) # display dendogram
rect.hclust(fit, k=8)

groups <- cutree(fit, k=5)

library(cluster)
clusplot(housing_norm, groups, color=TRUE, shade=TRUE, labels=2, lines=0)

library(fpc)
clusters <- 5
clus.boot <- clusterboot(housing_norm, 
                         B=50, # Number of bootstrap resamples
                         clustermethod=hclustCBI, # for hierarchical clustering 
                         method="ward.D2", # use what we used in "hclust"
                         k=clusters, 
                         count=FALSE) # Show progress on screen?
# clus.boot

# Rule of thumb: . AvgJaccard <0.6 is unstable . AvgJaccard >0.85 is highly stable
set.seed(12032023)
AvgJaccard <- clus.boot$bootmean
Instability <- clus.boot$bootbrd/1000
Clusters <- c(1:clusters)
Eval <- cbind(Clusters, AvgJaccard, Instability)
Eval

#Clusters AvgJaccard Instability
#[1,]        1  0.8501335       0.000
#[2,]        2  0.3051210       0.005
#[3,]        3  0.7852603       0.000
#[4,]        4  0.2251899       0.005
#[5,]        5  0.9000000       0.001

