function [ new_dataset_high_dimension, new_labels ] = AugmentDataset( features, labels, Cparam, epsilon )
% AUGMENTDATASET 
% This function augments a dataset using the EigenSample technique.
% 
% Inputs: 
% features: Input dataset samples to be augmented with additional samples as a matrix of size samplesXfeatures
% labels: Input dataset labels as a vector of size samplesX1 with values [+1,-1] representing the classes.
% Cparam: Hyper-parameter to control reconstruction error (single numeric value).
% epsilon: Hyper-parameter controlling the tolerance of the approximation (single numeric value).
% 
% Outputs:
% new_dataset_high_dimension: Augmented dataset samples as a matrix of size samplesXfeatures
% new_labels: Labels of augmented samples as a vector of size samplesX1 with values +1/-1.
% 
% Reference:
% EigenSample: A non-iterative technique for adding samples to small datasets
% Jayadeva, Sumit Soman and Soumya Saxena
% Elsevier Applied Soft Computing (DOI: 10.1016/j.asoc.2017.08.017)
% For any clarifications please send an email to eez127509@ee.iitd.ac.in
%
% Note: This function assumes that LIBSVM is on the MATLAB path.
% The LIBSVM library can be downloaded from here: https://www.csie.ntu.edu.tw/~cjlin/libsvm/



% Compute dataset size
[N dim]=size(features);

% Compute dataset mean and standard deviation
m=mean(features);
stdev=std(features);

% Mean-centering the dataset (if it has more than 1 sample)
if (size(features,1)>1)
	data_cent = bsxfun(@minus, features, m);
else
	data_cent=features;
end


% Compute covariance matrix
covmatrix = (data_cent'*data_cent)/(N-1);

% Convert covariance matrix to correlation matrix
corelmatrix = corrcov(covmatrix);
corelmatrix(isnan(corelmatrix))=0; % Sanity check!!

% Compute eigenvalues and eigenvectors of covariance matrix
[V D]=eig(corelmatrix);

% Sort the eigenvectors in order of decreasing eigenvalues
[V1 D1]=SortEigenvalues(V, D);

% Choose the k largest eigenvalues and their corresponding eigenvectors
[ k ] = FindBestEVs( D1 );
V_selected=V1(:,1:k);

% Compute projections of the samples onto the k eigendirections
projected_dataset = features * V_selected;

% Choose number of clusters by rule of thumb
k_clusters=floor(sqrt(N/2));

% Perform k-means clustering
[IDX,C] = kmeans(projected_dataset,k_clusters);

% construct lines joining the cluster centres with each point of the
% respective cluster, and then compute the mid-points of these lines
new_dataset=[];
for i=1:k_clusters
    new_dataset=[new_dataset; ...
        FindMidPointDistancesFromClusterCenters(projected_dataset(IDX==i,:),C(i,:))];
end

% Predict labels of new points
model = svmtrain(labels, projected_dataset);
[new_labels, accuracy, decision_values] = svmpredict(ones(N,1), new_dataset, model); 

% If using MATLAB's SVM
% SVMStruct = SVMTRAIN(projected_dataset,labels);
% new_labels = SVMCLASSIFY(SVMStruct,new_dataset );

new_dataset_high_dimension=[];
% C=1; epsilon=0.05;
lb=min(features);ub=max(features);
for i=1:size(new_dataset,1)
    new_dataset_high_dimension(i,:)=GetHighDimensionDataset(new_dataset(i,:), V_selected,lb,ub,Cparam,epsilon,dim);
end

% Shift new samples by mean and variance by which original dataset was spherized
for j=1:size(new_dataset_high_dimension,1)
   new_dataset_high_dimension(j,:)=(new_dataset_high_dimension(j,:).*stdev)+m; 
end
end

