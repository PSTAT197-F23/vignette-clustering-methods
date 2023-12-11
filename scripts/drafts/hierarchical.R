# Hierarchical Clustering Script


#root_dir <- rprojroot::find_rstudio_root_file()
#data_dir <- file.path(root_dir, "data")
#setwd(data_dir)

# Add Libraries
library(MASS)
library(class)
library(tidyverse)
library(ISLR)
library(ISLR2)
library(factoextra)
library(cluster)
library(ggplot2)

# read in data
housing <- read_csv('housing.csv')
summary(housing)

# pick just MedInc, Population, Latitude, and Longitude variables for analysis
subset_housing <- select(housing, MedInc, Population, Latitude, Longitude)

# normalize Data
housing_norm<-as.data.frame(scale(subset_housing))

# Plot of California distinguised by Median Income
ggplot(housing_norm, aes(x=Latitude, y=Longitude, color=MedInc)) + 
  geom_point(size=1)


# perform hierarchical clustering using "ward.D2" metric and euclidean distance
d <- dist(housing_norm,
          method = "euclidean") # distance matrix
fit <- hclust(d, method="ward.D2")

# display dendogram
plot(fit, labels=FALSE)

# display optimal cut off
rect.hclust(fit, k=5)

# cut the dendogram
groups <- cutree(fit, k=5)

# perform additional visualization using clusplot()
library(cluster)
clusplot(housing_norm, groups, color=TRUE, shade=TRUE, labels=0, lines=0)


# performance analysis using bootstrapping
library(fpc)
clusters <- 5
clus.boot <- clusterboot(housing_norm, 
                         B=50, # Number of bootstrap resamples
                         clustermethod=hclustCBI, # for hierarchical clustering 
                         method="ward.D2", # use what we used in "hclust"
                         k=clusters, 
                         count=FALSE) # Show progress on screen?

# Save the output object to a file for future use because the function takes awhile to run
saveRDS(clus.boot, file = "~/FinalProject_Group4/data/HCLUST_bootstrap.rds")
# Restore the object
#readRDS(file = "HCLUST_bootstrap.rds")



# Rule of thumb: . Average Jaccard Index of<0.6 is unstable.
# Average Jaccard Index of >0.85 is highly stable.

# set seed for reproducibility
set.seed(12032023)
AvgJaccard <- clus.boot$bootmean
Instability <- clus.boot$bootbrd/1000
Clusters <- c(1:clusters)
Eval <- cbind(Clusters, AvgJaccard, Instability)
Eval