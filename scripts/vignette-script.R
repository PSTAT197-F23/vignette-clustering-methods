# Vignette Script

# K-Means Clustering

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
set.seed(777)
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
# append cluster assignments to the data (to use for plotting)
housing$cluster <- kmeans$cluster
# display the centroids of each cluster
kmeans$centers
# plot median income against population
ggplot(housing, aes(MedInc, log(Population), color = factor(cluster))) +
  geom_point() + 
  labs(title = 'Figure 1: Median Income vs. Population', color = 'Cluster')
# clusters on map of california
ggplot(housing, aes(Longitude, Latitude, color = factor(cluster))) +
  geom_point() +
  labs(title = 'Figure 2: Clusters on map of California', color = 'Cluster')

# perform PCA on the data
pca <- prcomp(housing_norm, rank. = 4)
# principal components
pcs <- pca$x
# attach first two principal components to the data frame for plotting
housing$PC1 <- pcs[,1]
housing$PC2 <- pcs[,2]
# plot clusters on first two PCs
ggplot(housing, aes(PC1, PC2, color = factor(cluster))) +
  scale_x_continuous(limits = c(-10, 5)) +
  scale_y_continuous(limits = c(-10, 5)) +
  geom_point() + 
  labs(title = 'Figure 3: Cluster plot using PCA', color = 'Cluster')


# Hierarchical Clustering

# load packages
library(MASS)
library(class)
library(scatterplot3d)
library(factoextra)
library(cluster)
library(ggplot2)
library(dendextend)
library(fpc)
# Set Directory
root_dir <- rprojroot::find_rstudio_root_file()
data_dir <- file.path(root_dir, "data")
setwd(data_dir)
# Read in data
housing <- read_csv('housing.csv')
# Pick just MedInc, Population, Latitude, and Longitude variables for simpler analysis
myvars <- c("MedInc", "Population", "Latitude", "Longitude")
subset_housing <- housing[myvars]   # subset dataset
# Normalize Data
housing_norm<-as.data.frame(scale(subset_housing))

# calculate euclidean distances
d <- dist(housing_norm, method = "euclidean") # distance matrix
# fit hierarchical clusters using Ward's D2 (squared sum of errors)
fit <- hclust(d, method="ward.D2")
plot(fit, labels=FALSE) # display dendrogram
rect.hclust(fit, k=5)   # display cutoff, subjective, we chose 5 clusters

# perform PCA on the data
pca_result <- prcomp(housing_norm[, 0:4], scale = TRUE)
pca_result
# Extract the four principal components
pc_scores <- as.data.frame(pca_result$x[, 1:4])
# Perform Hierarchical Clustering using Ward D2 metric
hc_result <- hclust(dist(pc_scores), method = "ward.D2")

# Create a combined data frame with PC scores and normalized data
combined_data <- cbind(pc_scores, housing_norm)
# Plot the principal components with color based on the Median Income
ggplot(combined_data, aes(x = PC1, y = PC2, color = MedInc)) +
  geom_point() +
  scale_color_gradient(low = "blue", high = "red") +
  theme_minimal()

# cut dendrogram
groups <- cutree(fit, k=5) 
# plot the clusters
clusplot(housing_norm, groups, color=TRUE, shade=TRUE, labels=0, lines=0)
# Create a 3D scatter plot using the first three columns of housing_norm
scatterplot3d(
  x = housing_norm$MedInc,
  y = housing_norm$Population,
  z = housing_norm$Latitude,
  color = groups,
  pch = 16,
  main = "3D Cluster Plot"
)

# Bootstrapping to Test Adequacies
clusters <- 5   # choose optimal number of clusters
# In our vignette RMD, we commented out the below code because it takes awhile to run.
# Instead we save the object as HCLUST_bootstrap.rds and restore the object to use when rendering the HTML.
clus.boot <- clusterboot(housing_norm, 
 B=50, # number of bootstrap resamples
 clustermethod=hclustCBI, # choose agglomerative clustering method
 method="ward.D2", # use the same method as in `hclust()` 
 k=clusters, # number of clusters
 count=FALSE) # display progress

# Below is the code we used to restore the object for rendering use
# bootstrapped_cluster<-readRDS(file = "data/HCLUST_bootstrap.rds")

# General Guidelines: AvgJaccard <0.6 is unstable . AvgJaccard >0.85 is highly stable
set.seed(12032023)  # set seed for reproducibility
AvgJaccard <- bootstrapped_cluster$bootmean   # save average jaccard index values
Instability <- bootstrapped_cluster$bootbrd/1000      # save instability values
Clusters <- c(1:clusters)   # 5 clusters
Eval <- cbind(Clusters, AvgJaccard, Instability)      # create evaluation table that shows each cluster's average jaccard index and stability level
Eval