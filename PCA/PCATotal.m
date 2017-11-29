clear all;

%load the data
datasetwithtag = csvread('all_numeric.csv');

%define some constants
nfeatures = 8;
nreducedfeatures = 4;
datasetsize = size(datasetwithtag,1);

dataset = datasetwithtag(1:datasetsize, 2:nfeatures + 1);

AWDfind = datasetwithtag(:,1) == 0;
FWDfind = datasetwithtag(:,1) == 1;
RWDfind = datasetwithtag(:,1) == 2;

AWD = datasetwithtag(AWDfind,:);

FWD = datasetwithtag(FWDfind,:);

RWD = datasetwithtag(RWDfind,:);

reducedAWD = datasetwithtag(AWDfind,[2, 3, 6, 8]);

reducedFWD = datasetwithtag(FWDfind,[2, 3, 6, 8]);

reducedRWD = datasetwithtag(RWDfind,[2, 3, 6, 8]);

reduceddataset = {reducedAWD, reducedFWD, reducedRWD};

sizes(1) = size(AWD, 1);
sizes(2) = size(FWD, 1);
sizes(3) = size(RWD, 1);

%make a set of strings for the names of the axes of the scatter plots
columnnames = {'Max Horsepower','Max Torque','Fuel Tank Capacity','Curb Weight','Top Speed','Length','Width','Height'};

reducedcolumnnames = {'Max Torque','Fuel Tank Capacity','Length','Height'};

%get the size of the data, the number of columns is the number of features,
%while the number of rows is the number of observations.
[datasetrows, datasetcolumns] = size(dataset);

%produce some 2D scatter plots before we do PCA -- we also compute a covariance
%matrix, a correlation matrix, and a means vector while we have our unprocessed
%original space data.
[covmatrix, corrmatrix, means] = produce2DGraphs(dataset, datasetcolumns, datasetrows, columnnames);

%preprocess the data (mean center and scale)
[Ur, U, S, V] = prepareData(dataset, datasetcolumns, datasetrows);

%produce the scree plots, loading vectors, and 3D PC scatter plots
producePCAGraphs(Ur, U, S, V, datasetcolumns, datasetrows, columnnames, sizes);

Reduced3DPlots(reduceddataset, nreducedfeatures, datasetrows, reducedcolumnnames, sizes);

