function histogram_maker(type, feature, matrix)

    featureMatrix = matrix;
  
  featureColumn = featureMatrix(:, feature + 2);


switch (type)
  case 1
    type = 'AWD';
  case 2
     regionName = 'FWD';
  otherwise
     regionName = 'RWD';
end

switch (feature)
  case 1
    featureName = 'Maximum Horsepower';
    unit = 'Brake Horse Power';
  case 2
     featureName = 'Maximum Torque';
     unit = 'lb/ft';
  case 3
     featureName = 'Fuel Tank Capacity';
     unit = 'Gallons';
  case 4
     featureName = 'Curb Weight';
     unit = 'lbs';
  case 5
     featureName = 'Top Speed';
     unit = 'MPH';
  case 6
     featureName = 'Length';
     unit = 'Inches';
  case 7
     featureName = 'Width';    
     unit = 'Inches';
  otherwise
     featureName = 'Height';
     unit = 'Inches';
end

histogramTitle = [regionName, ' ', featureName, ' Histogram'];
%displays and saves histogram
if(region == 1)
  hist(featureColumn, sqrt(length(featureColumn)), 'r')
elseif(region == 2)
  hist(featureColumn, sqrt(length(featureColumn)), 'g')
else
  hist(featureColumn, sqrt(length(featureColumn)), 'c')
end

title (histogramTitle);
xlabel (unit);
ylabel ('Frequency');
plotname = genvarname(histogramTitle);
print(plotname, '-dpng');

endfunction
