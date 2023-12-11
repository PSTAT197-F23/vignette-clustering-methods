# Final-Project

Vignette on implementing different clustering methods using California housing data; created as a class project for PSTAT197A in Fall 2023.

Contributors: Manuri Alwis, Jade Thai, Jennifer Rink, Kayla Katakis, and Kylie Maeda

Vignette abstract: Clustering is an unsupervised machine learning method of identifying and grouping similar observations in a dataset without looking at the outcome. It is typically used to classify data into groups that allows for ease in understanding and manipulating. The data used in this vignette is California Housing Data from 1990 for each district in the state. The variables include the median income, median age of houses, average number of rooms, average number of bedrooms, population, average occupants, latitude, longitude, and median house value. The objective of the vignette is to learn about different clustering methods by utilizing them on California housing data. ADD OUTCOMES

Repository contents: In this repository, we have our main vignette, which contains our data exploration and clustering methods. We also have 3 sub-folders:

-   data: contains the data used, files include `housing.csv`, and `HCLUST_bootstrap.rds` which is a bootstrapping object for the hierarchical clustering method

-   scripts: two main scripts used to carry out clustering `k-means.R` and `hierarchical.R`, as well as a drafts sub-folder

    -   drafts: contains R scripts that were later changed to be included in the final vignette

-   images: contains .png files of plots and images used in the final vignette

The repository also contains this `README.md` file, which contains the description, contributors, abstract, contents, and references for this project.

Reference list: 
[https://towardsdatascience.com/understanding-k-means-clustering-in-machine-learning-6a6e67336aa1\\](https://towardsdatascience.com/understanding-k-means-clustering-in-machine-learning-6a6e67336aa1\){.uri}

<https://www.explorium.ai/blog/machine-learning/clustering-when-you-should-use-it-and-avoid-it/#>:\~:text=Clustering

*Hierarchical Clustering*:
Bock, Tim. “What Is Hierarchical Clustering?” Displayr, 13 Sept. 2022, www.displayr.com/what-is-hierarchical-clustering/#:~:text=Hierarchical%20clustering%2C%20also%20known%20as,broadly%20similar%20to%20each%20other. 

Patlolla, Chaitanya Reddy. “Understanding the Concept of Hierarchical Clustering.” Medium, Towards Data Science, 29 May 2020, towardsdatascience.com/understanding-the-concept-of-hierarchical-clustering-technique-c6e8243758ec. 
