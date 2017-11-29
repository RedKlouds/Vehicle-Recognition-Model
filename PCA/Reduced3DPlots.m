function Reduced3DPlots(dataset, nfeatures, nsamples, featurenames, sizes)
  
  %create an exclusions set to write unique filenames
  exclusions = {'NewFeature3DScatterPlots'};
  
  %define the size of the markers for the scatter plots
  ScatterMarkerSize = 20;

  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%       SCATTER PLOTS         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------
  
  %starting unique combination values for three of the four possible principle components  
  x = 1;
  y = 2;
  z = 3;
  i = 1;

  %loops through each unique combination of three of the four possible priniciple components 
  %for plotting observations using three of the principle components for each unique combination
  
  while(x < nfeatures - 1)
    
    %plot observations for principle component combination at this point for U
    f1 = figure; 
    scatter3(dataset{1}(:,x), dataset{1}(:,y), dataset{1}(:,z), ScatterMarkerSize, 'r', '.');
    hold on;
    scatter3(dataset{2}(:,x), dataset{2}(:,y), dataset{2}(:,z), ScatterMarkerSize, 'c', '.');
    scatter3(dataset{3}(:,x), dataset{3}(:,y), dataset{3}(:,z), ScatterMarkerSize, 'g', '.');
    xlabel(featurenames(1,x));
    ylabel(featurenames(1,y));
    zlabel(featurenames(1,z));
    title(strcat(featurenames(1,x), '/', featurenames(1,y), '/',  featurenames(1,z)));
    hold off;
    
    plotname = genvarname('NewFeature3DScatterPlots', exclusions);
    exclusions{i+1} = plotname;
    print(plotname, '-dpng');
    saveas(f1,plotname);
    
    close;
    
    i = i + 1;
    
      if(z == nfeatures)
    if(y == nfeatures - 1)
      x = x + 1;
      y = x + 1;
      z = y + 1;
    else 
       y = y + 1;
       z = y + 1;
       
    end
  else
    z = z + 1;
    
    end

  end
  
end  
