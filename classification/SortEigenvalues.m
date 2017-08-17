function [V_sort,D_sort]=SortEigenvalues(V,D)
% SORTEIGENVALUES
% This function sorts the eigenvectors V in the decreasing order of eigenvalues D.
% Inputs
% V : Matrix of eigenvectors (where eigenvectors are columns)
% D : Diagonal matrix of eigenvalues
% Outputs
% V_sort :  Sorted matrix of eigenvectors
% D_sort :  Sorted eigenvalues in decreasing order
% Note: This function is an adaptation of the code available at 
% https://in.mathworks.com/matlabcentral/fileexchange/18904-sort-eigenvectors---eigenvalues


% sort matrix of eigenvalues
D_sort=diag(sort(diag(D),'descend')); 

% obtain indices of sorted eigenvalues
[~, sorted_indices]=sort(diag(D),'descend'); 

% arrange the eigenvectors in the order of sorted eigenvalues
V_sort=V(:,sorted_indices); 

end