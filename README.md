# K-Means and Hierarchical Clustering Techniques

Vignette on implementing K-Means and Hierarchical clustering methods using California housing data; created as a class project for PSTAT197A in Fall 2023.

## Contributors

Manuri Alwis, Jade Thai, Jennifer Rink, Kayla Katakis, and Kylie Maeda

## Vignette Abstract

Clustering is an unsupervised machine learning method of identifying and grouping similar observations in a dataset without looking at the outcome. It is typically used to classify data into groups that allows for ease in understanding and manipulating. The data used in this vignette is California Housing Data from 1990 for each district in the state. The variables include the median income, median age of houses, average number of rooms, average number of bedrooms, population, average occupants, latitude, longitude, and median house value. The objective of the vignette is to learn about different clustering methods by utilizing them on California housing data. In this project, two types of clustering: k-means and hierarchical. With k-means, the data is partitioned into *k* clusters in an attempt to minimize variance within each cluster, while hierarchical abstractly clusters by similarity. In this analysis, it was discovered that hierarchical clustering is not conducive to large datasets even when employing the dimensionality-reducing technique Principle Component Analysis. Many clusters were overlapping and difficult to distinguish in the 2 Dimensional space. With k-means, the clusters formed were representative of existing economic and geographic regions of California. For example, a cluster focused on coastal regions of the Bay Area, Los Angeles, and San Diego had the most expensive houses and highest median income. Overall, clustering methods are a highly valuable tool in data analysis when used in the right scenarios, and an in-depth analysis of these methods are the basis of this vignette.

## Repository Contents

In this repository, we have our main vignette, which contains our data exploration and clustering methods. We also have 3 sub-folders:

-   data: contains the data used, files include `housing.csv`, and `HCLUST_bootstrap.rds` which is a bootstrapping object for the hierarchical clustering method

-   scripts: one script `vignette-script.R` that contains all the code used in the vignette markdown with line annotations

    -   drafts: two scripts used to carry out clustering techniques `k-means.R` and `hierarchical.R`

-   images: contains .png files of plots and images used in the final vignette

The repository also contains this `README.md` file, which contains the description, contributors, abstract, contents, and references for this project.

## Reference List

**California Housing Dataset**: https://www.kaggle.com/datasets/camnugent/california-housing-prices

**K-Means Clustering**:

(LEDU), Education Ecosystem. "Understanding K-Means Clustering in Machine Learning." Medium, Towards Data Science, 12 Sept. 2018, https://towardsdatascience.com/understanding-k-means-clustering-in-machine-learning-6a6e67336aa1

"ML Clustering: When to Use Cluster Analysis, When to Avoid It." Explorium, 6 Aug. 2023, www.explorium.ai/blog/machine-learning/clustering-when-you-should-use-it-and-avoid-it/#.

**Hierarchical Clustering**:

Bock, Tim. "What Is Hierarchical Clustering?" Displayr, 13 Sept. 2022, www.displayr.com/what-is-hierarchical-clustering/#:\~:text=Hierarchical%20clustering%2C%20also%20known%20as,broadly%20similar%20to%20each%20other.

Patlolla, Chaitanya Reddy. "Understanding the Concept of Hierarchical Clustering." Medium, Towards Data Science, 29 May 2020, https://towardsdatascience.com/understanding-the-concept-of-hierarchical-clustering-technique-c6e8243758ec

## Further Readings

**Density-Based Clustering: DBSCAN**:

Yildirim, Soner. "DBSCAN Clustering - Explained." Medium, Towards Data Science, 22 Apr. 2020, https://towardsdatascience.com/dbscan-clustering-explained-97556a2ad556#:\~:text=DBSCAN%20stands%20for%20density%2Dbased,many%20points%20from%20that%20cluster.

**Balanced Iterative Reducing and Clustering Using Hierarchies: BIRCH**:

Benzer, Noel Job. "Balanced Iterative Reducing and Clustering Using Heirarchies (BIRCH)." Medium, Medium, 25 May 2022, https://medium.com/@noel.cs21/balanced-iterative-reducing-and-clustering-using-heirachies-birch-5680adffaa58
