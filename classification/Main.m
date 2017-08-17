% Sample code for augmenting datasets
% Reference:
% EigenSample: A non-iterative technique for adding samples to small datasets
% Jayadeva, Sumit Soman and Soumya Saxena
% Elsevier Applied Soft Computing (DOI: 10.1016/j.asoc.2017.08.017)
% For any clarifications please send an email to eez127509@ee.iitd.ac.in

clc;clearvars;close all;
rng default;

% Define synthetic example dataset and labels
xTrain=[-1,-1;...
        1,1;...
        1,-1;...
        -1,1];
        
 yTrain=[ones(2,1);-ones(2,1)];
 
 % Define parameters for EigenSample - these can be changed according to the dataset
 Cparam=0.1;
 epsilon=0.01;
 
 % Function call to augment dataset
 [ new_dataset, new_labels ] = AugmentDataset( xTrain, yTrain, Cparam, epsilon );
 
 % Plot data and samples
 figure;
 scatter(xTrain(yTrain==1,1),xTrain(yTrain==1,2),'ro'); hold on; grid on;
 scatter(xTrain(yTrain==-1,1),xTrain(yTrain==-1,2),'rx'); 
 scatter(new_dataset(new_labels==1,1),new_dataset(new_labels==1,2),'ro'); 
 scatter(new_dataset(new_labels==-1,1),new_dataset(new_labels==-1,2),'rx'); 
 legend('Original Points class +1', 'Original Points class -1', 'New Points class +1', 'New Points class -1');
