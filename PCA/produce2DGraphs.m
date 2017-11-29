function [covmatrix, corrmatrix, means] = produce2DGraphs(data, datacolumns, datarows, columnnames)
           
  %create an exclusions set to write unique filenames for the 2D scatter plots            
  originalspaceexclusions = {'TwoDimensionalScatterPlot'};
  
  %create an exclusions set to write unique filenames for the transformed 2D scatter plots
  transformedspaceexclusions = {'TwoDimensionalScatterPlot_Transformed'};
  
  %define the size of the markers for the scatter plots
  scatterplotmarkersize = 50;
  
  %find a vector of the means of the columns of the data
  means = mean(data);
  
  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%       SCATTER PLOTS          %%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------
  
  %start writing to the exclusions set at the second index
  exclusioncount = 2;
  
  %find the correlation b/w all columns
%   for i = 1:datacolumns
%     for j = 1:datacolumns
%       
%       covmatrix(i,j) = cov(data(:,i), data(:,j));
% 
%       corrmatrix(i,j) = corr(data(:,i), data(:,j));
%       
%     end 
%   end  
    
    covmatrix = cov(data);
    
    corrmatrix = corr(data);
  
  %we want all columns by all columns, but only once, so we run j to i
  for i = 1:datacolumns
    for j = 1:i
      
      figure; 
      scatter(data(:,i), data(:,j), scatterplotmarkersize, 'r', '.');
      xlabel(columnnames{i});
      ylabel(columnnames{j});

      [plottitle, ~] = sprintf('2D Scatter Plot: %s\nvs.\n%s',columnnames{i},columnnames{j});
      
      title(plottitle);
      %title({strcat('2D Scatter Plot:', columnnames(i,1)), ' vs.', columnnames(j,1)});

      printname = genvarname('TwoDimensionalScatterPlot', originalspaceexclusions);
      originalspaceexclusions{exclusioncount} = printname;
      exclusioncount = exclusioncount + 1;

      print(printname, '-dpng');

      close; 
      
    end  
  end
  
end