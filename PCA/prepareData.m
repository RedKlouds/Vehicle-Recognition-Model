%mean centers and scales passed observation data
%assumes passed number of observations (rows of observation matrix) 
%and passed number of features (columns of observation matrix) are correct
function [Ur, U, S, V] = prepareData(ctotal, nfeatures, nsamples)
  
  %Gets the mean and stdv of the new total set
  means = mean(ctotal);
  stdv = std(ctotal);
  
  %Mean-center/scale each feature, X is a NORMALIZED & MEAN CENTERED� dataset
  %data for a feature observation will be 1 if it is 1 standard deviation greater than that features mean
  for i = 1:nfeatures
    for j = 1:nsamples
      
      X(j,i) = ( means(:,i) - ctotal(j,i) ) / stdv(:,i);
      
    end
  end
  
  %run svd to calculate scores matrix U, covariance matrix (diagonal) S, and loading matrix V
  [U, S, V] = svd(X, 0);
  
  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%         NORMALIZE S         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------
  %normalize S so that total the wieght of all priniciple components in S culminate to 1

  %variable for sum of all values in covariance matrix s (after each element in S has been squared)
  Ssum = 0;

  %square each element in the matrix and concurrently add it to the sum of S
  for i = 1:nfeatures
    
    S(i,i) = S(i,i)^2;
    Ssum = Ssum + S(i,i);
    
  end

  %now that the sum has of S has been calculated, 
  %normalize each element in S by divideding it by the sum of S, 
  %so that each element is a fraction of the sum total sum add they culminate to 1 
  for i = 1:nfeatures
    
    S(i,i) = S(i,i) / Ssum;
    
  end
  
  %calculates Ur after normalizing S
  Ur = U * S;
  
end