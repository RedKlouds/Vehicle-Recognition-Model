%preforms singular value decomposition on Iris observations
%and graphs three types of plots for Principle Component Analysis
%assumes that iris.mat, mysvd.m, and pca.m are within directory

%clears the command history
clear all;

%loads flower observations into three matrices for each flower type: setosa, virginica, and versicolor
load('iris.mat');

%-------------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%          CONSTANTS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------------------------------------------------------------------

%define constants

%this is the original number of columns representing original features, two for petal and two for sepal
nfeatures = 4;

%we will use the fifth column for the flower type
%0 = setosa
%1 = virginica
%2 = versicolor
flowertypecolumn = 5;

%the total number of flowers, which is the sum of each flower types
nsamples = 150;

%the number of samples in one flower type
oneflower = 50;  


%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%            SETUP            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------

%add a column to all the flowers to indicate what type it is
%as noted before:
%0 = setosa
%1 = virginica
%2 = versicolor
%additionally, add a number in another column with a random number so we can
%simply sort the flowers by that column and select the first 'randomsamples' samples
for i = 1:oneflower
    
  setosa(i,flowertypecolumn) = 0;
  %setosa(i,randnumbercolumn) = rand*nsamples;
   
  virginica(i,flowertypecolumn) = 1;
  %virginica(i,randnumbercolumn) = rand*nsamples;
    
  versicolor(i,flowertypecolumn) = 2;
  %versicolor(i,randnumbercolumn) = rand*nsamples;
  
end
  
  
%concatenate all the flowers into one matrix
allflowers = cat(1, setosa, virginica, versicolor);


%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%        PREPARE DATA         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------

%prepares the data by centering and scaling data
X = prepareData(allflowers(1:nsamples, 1:nfeatures), nfeatures, nsamples);

%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%            SVD              %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------
  
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
for i = 1:4
  
  S(i,i) = S(i,i)^2;
  Ssum += S(i,i);
  
end

%now that the sum has of S has been calculated, 
%normalize each element in S by divideding it by the sum of S, 
%so that each element is a fraction of the sum total sum add they culminate to 1 
for i = 1:4
  
  S(i,i) = S(i,i) / Ssum;
  
end

%calculates Ur after normalizing S
Ur = U * S;

%makes S a row vector with all diagonal values, and transposes it into a column vector
S = sum(S);
S = transpose(S);



%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%        SCREE PLOTS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------

%variable to track the culmination of the values in S, starting with the greatest value of S
CumSSum = 0;

%for each priniciple component wieght in S, starting with the greatest, culminate and track 
for i = 1:nfeatures
  
  CumSSum += S(i);
  CumulativeS(i) = CumSSum;
  
end

%graphing scree plots 
%scree plot from S
figure; 
plot(S,'x:b'); 
grid; 
title('Scree Plot');

%culminative scree plot from culmination tracking
figure; 
plot(CumulativeS,'x:r'); 
grid; 
title('Scree Plot Cummulative');

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
  axis([0 nfeatures ymin ymax]); 
  xlabel('Feature index'); 
  ylabel('Importance of feature'); 
  [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
  title(chart_title);
end

%-----------------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%       SCATTER PLOTS         %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------------------------------------------------

%gets each of the classes from U
%class1 for Setosa, Class2 for virginica, and class3 for versicolor
uClass1 = U(1:50, 1:4);
uClass2 = U(51:100, 1:4);
uClass3 = U(101:150, 1:4);

urClass1 = Ur(1:50, 1:4);
urClass2 = Ur(51:100, 1:4);
urClass3 = Ur(101:150, 1:4);


diminsionNames = {'PC1 ', 'PC2 ', 'PC3 ', 'PC4 '};
titleNames = {'U ', 'Ur '}

%starting unique combination values for three of the four possible principle components  
x = 1;
y = 2;
z = 2;

%loops through each unique combination of three of the four possible priniciple components 
%for plotting observations using three of the principle components for each unique combination
%principle component combinations used for plotting are in the order (principle componets numbered by column number of U)
%1st, 2nd, and 3rd principle components
%1st, 2nd, and 4th principle components
%1st, 3rd, and 4th principle components
%2nd, 3rd, and 4th principle componets
while(x != 2)
  
  %increments through each unique principle component combination
  if(z !=4)
    z++;
  elseif(y != 3)
    y++;
  else
    x++;
  endif  
  
  %plot observations for principle component combination at this point for U
  figure; 
  scatter3(uClass1(:,x), uClass1(:,y), uClass1(:,z), 'r', '^'); 
  hold on; 
  scatter3(uClass2(:,x), uClass2(:,y), uClass2(:,z), 'b', '*'); 
  scatter3(uClass3(:,x), uClass3(:,y), uClass3(:,z), 'g');
  legend('Setosa', 'Virginica', 'Versicolor');
  xlabel(diminsionNames(1,x));
  ylabel(diminsionNames(1,y));
  zlabel(diminsionNames(1,z));
  title(strcat(titleNames(1,1), diminsionNames(1,x), diminsionNames(1,y), diminsionNames(1,z)));
  
  %plot observations for principle component combination at this point for Ur
  figure; 
  scatter3(urClass1(:,x), urClass1(:,y), urClass1(:,z), 'r', '^'); 
  hold on; 
  scatter3(urClass2(:,x), urClass2(:,y), urClass2(:,z), 'b', '*'); 
  scatter3(urClass3(:,x), urClass3(:,y), urClass3(:,z), 'g');
  legend('Setosa', 'Virginica', 'Versicolor');
  xlabel(diminsionNames(1,x));
  ylabel(diminsionNames(1,y));
  zlabel(diminsionNames(1,z));
  title(strcat(titleNames(1,2), diminsionNames(1,x), diminsionNames(1,y), diminsionNames(1,z)));
  
endwhile


%plot observations for principle component combination at this point for Ur
figure; 
scatter3(setosa(:,1), setosa(:,3), setosa(:,4), 'r', '^'); 
hold on; 
scatter3(virginica(:,1), virginica(:,3), virginica(:,4), 'b', '*'); 
scatter3(versicolor(:,1), versicolor(:,3), versicolor(:,4), 'g');
legend('Setosa', 'Virginica', 'Versicolor');
xlabel('petal width');
ylabel('sepal width');
zlabel('sepal length');
title('After PCA');