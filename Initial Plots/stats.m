%clear everything from previous runs
clear all;

%load the data
datasetwithtag = csvread('all_numeric.csv');

AWDfind = datasetwithtag(:,1) == 0;
FWDfind = datasetwithtag(:,1) == 1;
RWDfind = datasetwithtag(:,1) == 2;

AWD = datasetwithtag(AWDfind,:);

FWD = datasetwithtag(FWDfind,:);

RWD = datasetwithtag(RWDfind,:);

sizes(1) = size(AWD, 1);
sizes(2) = size(FWD, 1);
sizes(3) = size(RWD, 1);

%get the size (in number of rows) of each of the data sets
numAWD = size(AWD, 1);
numFWD = size(FWD, 1);
numRWD = size(RWD, 1);

%define some constants
nfeatures = 8;
ntypes = 3;

%define some arrays to name plots and their axes and legends
typenames = { 'AWD', 'FWD', 'RWD' };
featurenames = { 'Horsepower', 'Maximum Torque', 'Fuel Tank Capacity', 'Curb Weight', 'Top Speed', 'Length', 'Width', 'Height' };
featureunits = { 'BHP', 'lb/f', 'US gallons', 'lbs', 'MPH', 'inches', 'inches', 'inches' };

%put all three datasets into a cell matrix, so we can iterate through them
data{1} = AWD;
data{2} = FWD;
data{3} = RWD;

%plot scatter plots for all features
%scatters(data, ntypes, nfeatures, typenames, featurenames, featureunits);

%plot and print PDFs for the datasets
%mypdf(data, ntypes, nfeatures, typenames, featurenames, featureunits);

%plot and print PDFs with dot diagrams at the bottom
pdfwithdots(data, ntypes, nfeatures, typenames, featurenames, featureunits);

%create covariance matrices for the datasets
for i = 1:nfeatures
  for j = 1:nfeatures
    AWDcov(i,j) = cov(data{1}(:,i), data{1}(:,j));
  end
end

for i = 1:nfeatures
  for j = 1:nfeatures
    FWDcov(i,j) = cov(data{2}(:,i), data{2}(:,j));
  end
end

for i = 1:nfeatures
  for j = 1:nfeatures
    RWDcov(i,j) = cov(data{3}(:,i), data{3}(:,j));
  end
end

%find a population mean for each of the datasets
for i = 1:nfeatures
  AWDmean(:,i) = mean(american(:,i));
end

for i = 1:nfeatures
  FWDmean(:,i) = mean(asian(:,i));
end

for i = 1:nfeatures
  RWDmean(:,i) = mean(european(:,i));
end

%grab a random sample, using 20% of the population as a sufficiently large sample
%space to determine if CLT applies

AWDsamplesize = (20/100) * numAWD;

FWDsamplesize = (20/100) * numFWD;

RWDsamplesize = (20/100) * numRWD;

for i = 1:AWDsamplesize
  AWDsample(i,:) = american(floor(rand * numAWD + 1),:);
end

for i = 1:FWDsamplesize
  FWDsample(i,:) = asian(floor(rand * numFWD + 1),:);
end

for i = 1:RWDsamplesize
  RWDsample(i,:) = european(floor(rand * numRWD + 1),:);
end

%find the sample mean for all the datasets, based on the sample datasets we just found
for i = 1:nfeatures
  AWDsamplemean(:,i) = mean(AWDsample(1:AWDsamplesize,i));
end

for i = 1:nfeatures
  FWDsamplemean(:,i) = mean(FWDsample(1:FWDsamplesize,i));
end

for i = 1:nfeatures
  RWDsamplemean(:,i) = mean(RWDsample(1:RWDsamplesize,i));
end