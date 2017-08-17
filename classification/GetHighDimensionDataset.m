function [ datapoint_high ] = GetHighDimensionDataset( datapoint_low, G, lb, ub, C, epsilon, N )
%GETHIGHDIMENSIONDATASET 
% This function maps a data point in the projected lower-dimensional
% subspace (K) to the original high dimensional subspace (N). The input
% parameters are:
% datapoint_low: The data point in K dimensions (1XK)
% G: The transformation matrix of size (NXK)
% lb: Lower bound - row vector of minimum of features in N-space (1XN).
% ub: Upper bound - row vector of maximum of features in N-space (1XN).
% C: scalar parameter determining tradeoff between approximation error and
% norm of solution vector.
% epsilon: scalar hyperparameter controlling tolerance of approximation
% N: scalar representing original high dimensional subspace (N)
% The function outputs the N-dimensional data point.
% Sumit Soman, 7 September 2016


K=size(datapoint_low,2);

% Compute \lambda and \mu
A=[-(G'*G + C *eye(K)), G'*G , G', -G';...
    G'*G, -(G'*G + C *eye(K)), -G', G'];
B=[datapoint_low'+epsilon*ones(K,1);-datapoint_low'+epsilon*ones(K,1)];
sol_vec=pinv(A)*B;
lambda=sol_vec(1:K,1);
mu=sol_vec(K+1:2*K,:);
gamma=sol_vec(2*K+1:2*K+N,:);
delta=sol_vec(2*K+N+1:end,:);

datapoint_high=(G*(lambda-mu))+ (gamma-delta);
end