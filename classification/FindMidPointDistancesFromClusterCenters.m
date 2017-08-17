function [ output_dataset ] = FindMidPointDistancesFromClusterCenters( input_dataset, cluster_center )
%FINDMIDPOINTDISTANCESFROMCLUSTERCENTERS 
% This function adds samples to the input dataset along the line joining the samples to the cluster center
% Inputs
% input_dataset : input samples as a matrix of size samplesXfeatures
% cluster_center : cluster center as a vector of size featuresX1
% Output
% output_dataset :  output samples as a matrix of size samplesXfeatures

% Compute size of dataset
[N D]=size(input_dataset);

% Initialize output dataset matrix
output_dataset=[];

% Iterate over samples
for i=1:N
	 % compute the sample as the mid point of the line joining the sample with the corresponding cluster center
     output_dataset(i,:)=(input_dataset(i,:)+cluster_center)./2;
     
     % The following line may be un-commented in order to add a point other than the mid-point
     % As an example, this line adds a point which divides the line in the ratio 9:1
	 % output_dataset(i,:)=(0.9*input_dataset(i,:))+(0.1*cluster_center);
end

end

