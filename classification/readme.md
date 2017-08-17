This folder contains MATLAB code files to use EigenSample for adding synthetic samples for classification datasets.

An example is provided in the script Main.m.

A brief description of the other files is as follows:

AugmentDataset.m - function for augmenting datasets using EigenSample
FindBestEVs.m - function for finding number of eigenvectors to select based on power retained by eigenvalue spectrum
FindMidPointDistancesFromClusterCenters.m - function to add points on line joining samples to cluster centers
GetHighDimensionDataset.m - function implementing least-squares reverse projection approach
SortEigenValues.m - function for sorting eigenvalues in descending order of eigenvectors
