
function mypdf (data, ntypes, nfeatures, typenames, featurenames, featureunits)
  
  exclusions = {'densityplot'};
  
  colors = {'r', 'g', 'c'};
  
  for i = 2:nfeatures + 1
    
    figure;
    
    for j = 1:ntypes
      
      type = data{j};
      
      mu = mean(type(:,i)); 
      st = std(type(:,i)); 
      x = linspace(mu-3*st,mu+3*st,100);
      y = normpdf(x,mu,st);
      
      hold on;
      
      plot(x,y,colors{j});
      
    end
    
    [x_label, ERRMSG] = sprintf('%s (%s)',featurenames{i - 1},featureunits{i - 1}); 
    xlabel(x_label);
    ylabel('Probability Density'); 
    
    title(featurenames{i - 1});
    
    legend(typenames, 'location', 'northoutside', 'orientation', 'horizontal');
    
    hold off;
    
    plotname = genvarname('densityplot', exclusions);
    exclusions{i} = plotname;
    print(plotname, '-dpng');
    
    close;
    
  end  
  
end
