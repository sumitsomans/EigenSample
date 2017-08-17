function [ sel_EVs ] = FindBestEVs( EVs )
% FINDBESTEVS 
% This function returns the number of EigenVectors to select based on the
% variance preserved in the eigenvalue spectrum.
% Inputs
% EVs: diagonal matrix of eigenvalues
% Outputs
% sel_EVs : number of eigenvalues to select (via selection of eigenvectors)


% Convert eigenvalues to vector
EVs_vec=diag(EVs);

% Compute ratio of variance preserved by eigenvalues
for i=1:length(EVs_vec)
    sum_ratio=sum(EVs_vec(1:i).^2)/sum(EVs_vec.^2);
    
    % check if variance captured is > 90%
    if (sum_ratio>=0.9)
    	% select i eigenvectors
        sel_EVs=i;
    end
end


end

