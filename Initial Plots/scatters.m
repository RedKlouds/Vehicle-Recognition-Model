function scatters(data, ntypes, nfeatures, typenames, featurenames, featureunits)
   
    %define the size of the markers for the scatter plots
    scatterplotmarkersize = 30;

    %start writing to the exclusions set at the second index
    exclusioncount = 2;
    
    exclusions = {'TwoDimensionalScatterPlot_AWD'};
    
    colors = {'r', 'g', 'c'};

    for i = 2:nfeatures + 1
        for j = 2:nfeatures + 1
            
            figure;
            
            hold on;
            
            for k = 1:ntypes

                scatter(data{k}(:,i), data{k}(:,j), scatterplotmarkersize, '.', colors{k});  

            end

            hold off;
            
            xlabel(featurenames{i - 1});

            ylabel(featurenames{j - 1});

            %[plottitle, ~] = sprintf('2D Scatter Plot: %s\nvs.\n%s',featurenames{i},featurenames{j});

            %title(plottitle);
            
            legend(typenames, 'location', 'northoutside', 'orientation', 'horizontal');

            printname = genvarname('TwoDimensionalScatterPlot', exclusions);
            exclusions{exclusioncount} = printname;
            exclusioncount = exclusioncount + 1;

            print(printname, '-dpng');

            close;
        end
    end
    
end