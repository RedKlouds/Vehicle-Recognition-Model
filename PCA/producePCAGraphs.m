function producePCAGraphs(Ur, U, S, V, nfeatures, nsamples, featurenames, sizes)
  
  %create an exclusions set to write unique filenames for the U scatter plots
  UScatterExclusions = {'UScatterPlot'};
  
  %create an exclusions set to write unique filenames for the Ur scatter plots
  UrScatterExclusions = {'UrScatterPlot'};
  
  %create an exclusions set to write unique filenames for the loading vector plots
  LoadingVectorExclusions = {'LoadingVector'};
  
  %create an exclusions set to write unique filenames for the absolute loading vector plots
  AbsLoadingVectorExclusions = {'AbsLoadingVector'};
  
  %define the size of the markers for the scatter plots
  ScatterMarkerSize = 20;
  
  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%        SCREE PLOTS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------

  %makes S a row vector with all diagonal values, and transposes it into a column vector
  S = sum(S);
  S = transpose(S);
  
  %variable to track the culmination of the values in S, starting with the greatest value of S
  CumSSum = 0;

  %for each priniciple component wieght in S, starting with the greatest, culminate and track 
  for i = 1:nfeatures
    
    CumSSum = CumSSum + S(i);
    CumulativeS(i) = CumSSum;
    
  end

  %graphing scree plots 
  %scree plot from S
  figure; 
  plot(S,'x:b'); 
  grid; 
  title('Scree Plot');
  xlabel('Principal Component');
  ylabel('Eigenvalue');
  
  print('Scree Plot', '-dpng');
  
  close;

  %culminative scree plot from culmination tracking
  figure; 
  plot(CumulativeS,'x:r'); 
  grid; 
  title('Scree Plot Cumulative');
  xlabel('Principal Component');
  ylabel('Eigenvalue');
  
  print('Cumulative Scree Plot', '-dpng');
  
  close;
  
  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%      LOADING VECTORS        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------

  %square each element in V and assigns each element to the absolute value of itself
  for i=1:nfeatures 
      for j=1:nfeatures 
          Vsquare(i,j) = V(i,j)^2; 
          if V(i,j)<0 
              Vsquare(i,j) = Vsquare(i,j)*-1; 
          else  
              Vsquare(i,j) = Vsquare(i,j)*1; 
          end 
      end 
  end
  
  %graph loading vectors from V
  for i = 1:nfeatures
    
    figure; 
    bar(Vsquare(:,i),0.5); 
    grid; 
    ymin = min(Vsquare(:,i)) + (min(Vsquare(:,i))/10); 
    ymax = max(Vsquare(:,i)) + (max(Vsquare(:,i))/10); 
    xlabel('Feature index'); 
    ylabel('Importance of feature'); 
    [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
    title(chart_title);
    
    plotname = genvarname('LoadingVector', LoadingVectorExclusions);
    LoadingVectorExclusions{i+1} = plotname;
    print(plotname, '-dpng');
    
    close;
    
  end

  %graph absolute loading vectors from V
  for i = 1:nfeatures
    
    figure; 
    bar(abs(Vsquare(:,i)),0.5); 
    grid; 
    ymin = 0; 
    ymax = max(abs(Vsquare(:,i))) + max(abs(Vsquare(:,i))/10); 
    %axis([0 nfeatures ymin ymax]); 
    xlabel('Feature index'); 
    ylabel('Importance of feature'); 
    [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
    title(chart_title);
    
    plotname = genvarname('AbsLoadingVector', AbsLoadingVectorExclusions);
    AbsLoadingVectorExclusions{i+1} = plotname;
    print(plotname, '-dpng');
    
    close;
    
  end
  
  %-----------------------------------------------------------------------------
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%       SCATTER PLOTS         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %-----------------------------------------------------------------------------

  diminsionNames = {'PC1 ', 'PC2 ', 'PC3 ', 'PC4 ', 'PC5 ', 'PC6 ','PC7 ' ,'PC8 '};
  titleNames = {'U ', 'Ur '};

  %starting unique combination values for three of the four possible principle components  
  x = 1;
  y = 2;
  z = 3;
  i = 1;

  %loops through each unique combination of three of the four possible priniciple components 
  %for plotting observations using three of the principle components for each unique combination
  
  AWDUr = Ur(1:sizes(1),:);
  FWDUr = Ur(sizes(1):sizes(1)+sizes(2),:);
  RWDUr = Ur(sizes(1)+sizes(2):sizes(1)+sizes(2)+sizes(3),:);
   
  AWDU = U(1:sizes(1),:);
  FWDU = U(sizes(1):sizes(1)+sizes(2),:);
  RWDU = U(sizes(1)+sizes(2):sizes(1)+sizes(2)+sizes(3),:);
  
  while(x < nfeatures - 1)
    
    %plot observations for principle component combination at this point for U
    f1 = figure; 
    scatter3(AWDU(:,x), AWDU(:,y), AWDU(:,z), ScatterMarkerSize, 'r', '.');
    hold on;
    scatter3(FWDU(:,x), FWDU(:,y), FWDU(:,z), ScatterMarkerSize, 'c', '.');
    scatter3(RWDU(:,x), RWDU(:,y), RWDU(:,z), ScatterMarkerSize, 'g', '.');
    xlabel(diminsionNames(1,x));
    ylabel(diminsionNames(1,y));
    zlabel(diminsionNames(1,z));
    title(strcat(titleNames(1,1), diminsionNames(1,x), diminsionNames(1,y), diminsionNames(1,z)));
    %axis ([-1 1 -1 1 -1 1]);
    hold off;
    
    plotname = genvarname('UScatterPlot', UScatterExclusions);
    UScatterExclusions{i+1} = plotname;
    print(plotname, '-dpng');
    saveas(f1,plotname);
    
    close;
    
    %plot observations for principle component combination at this point for Ur
    f2 = figure; 
    scatter3(AWDUr(:,x), AWDUr(:,y), AWDUr(:,z), ScatterMarkerSize, 'r', '.');
    hold on;
    scatter3(FWDUr(:,x), FWDUr(:,y), FWDUr(:,z), ScatterMarkerSize, 'c', '.');
    scatter3(RWDUr(:,x), RWDUr(:,y), RWDUr(:,z), ScatterMarkerSize, 'g', '.');
    
    
    xlabel(diminsionNames(1,x));
    ylabel(diminsionNames(1,y));
    zlabel(diminsionNames(1,z));
    title(strcat(titleNames(1,2), diminsionNames(1,x), diminsionNames(1,y), diminsionNames(1,z)));
    %axis ([-1 1 -1 1 -1 1]);
    
    plotname = genvarname('UrScatterPlot', UrScatterExclusions);
    UrScatterExclusions{i+1} = plotname;
    print(plotname, '-dpng');
    saveas(f2,plotname);
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
