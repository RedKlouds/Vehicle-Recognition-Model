

function scatter_plot(file_name)
    american_data = csvread('allamerican.csv',0,2);
    asian_data = csvread('allasian.csv',0,2);
    european_data = csvread('alleuropean.csv',0,2);
    
    

    %get the feature colums
    %american car data
    american_data_max_hp = american_data(:,1)
    american_data_max_trq = american_data(:,2)
    american_data_fuel_t = american_data(:,3)
    american_data_curb_w = american_data(:,4)
    american_data_top_sp = american_data(:,5)
    american_data_length = american_data(:,6)
    american_data_width = american_data(:,7);
    american_data_height = american_data(:,8);
    
    
    %get feature columns for 
    %asian car data
    asian_data_max_hp = asian_data(:,1)
    asian_data_max_trq = asian_data(:,2)
    asian_data_fuel_t = asian_data(:,3)
    asian_data_curb_w = asian_data(:,4)
    asian_data_top_sp = asian_data(:,5)
    asian_data_length = asian_data(:,6)
    asian_data_width = asian_data(:,7);
    asian_data_height = asian_data(:,8);
    
    
        %get feature columns for 
    %asian car data
    eurpean_data_max_hp = european_data(:,1)
    eurpean_data_max_trq = european_data(:,2)
    eurpean_data_fuel_t = european_data(:,3)
    eurpean_data_curb_w = european_data(:,4)
    eurpean_data_top_sp = european_data(:,5)
    eurpean_data_length = european_data(:,6)
    eurpean_data_width = european_data(:,7);
    eurpean_data_height = european_data(:,8);
    
    
    
    
    
    figure;
    %%%%%%%%%%%%%%%%%HP
   %hp wwith fuel_tank
   p1 = scatter(eurpean_data_max_hp, eurpean_data_fuel_t,'c');
   
   hold on
   p2 = scatter(asian_data_max_hp, asian_data_fuel_t,'g');
   p3 = scatter(american_data_max_hp,american_data_fuel_t,'r');
  
   legend([p1,p2,p3],'European','Asian','American')
   
%     figure;
%     
%    %hp wwith trq
%    scatter(eurpean_data_max_hp, eurpean_data_max_trq,'c');
%    hold on
%    scatter(asian_data_max_hp, asian_data_max_trq,'g');
%    scatter(american_data_max_hp,american_data_max_trq,'r');
%    
   
%    
%    %hp with curb weight
%    figure;
%    scatter(eurpean_data_max_hp, eurpean_data_curb_w,'c');
%    hold on
%    scatter(asian_data_max_hp, asian_data_curb_w,'g');
%    scatter(american_data_max_hp,american_data_curb_w,'r');
%    
%    
%       %hp with  top_sp
%    figure;
%    scatter(eurpean_data_max_hp, eurpean_data_top_sp,'c');
%    hold on
%    scatter(asian_data_max_hp, asian_data_top_sp,'g');
%    scatter(american_data_max_hp,american_data_top_sp,'r');
%    
%       %hp with Length
%    figure;
%    scatter(eurpean_data_max_hp, eurpean_data_length,'c');
%    hold on
%    scatter(asian_data_max_hp, asian_data_length,'g');
%    scatter(american_data_max_hp,american_data_length,'r');
%    
%    
%    
%    
%       %hp with curb width
%    figure;
%    scatter(eurpean_data_max_hp, eurpean_data_width,'c');
%    hold on
%    scatter(asian_data_max_hp, asian_data_width,'g');
%    scatter(american_data_max_hp,american_data_width,'r');
%    
%       %hp with curb height
%    figure;
%    scatter(eurpean_data_max_hp, eurpean_data_height,'c');
%    hold on
%    scatter(asian_data_max_hp, asian_data_height,'g');
%    scatter(american_data_max_hp,american_data_height,'r');
%    
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%    %%%%%%%%%%%%%%%%% . TRQ %%%%%%%%%%%%%%%%%%%%
%    
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%       %trq with fuel tank
%    figure;
%    scatter(eurpean_data_max_trq, eurpean_data_fuel_t,'c');
%    hold on
%    scatter(asian_data_max_trq, asian_data_fuel_t,'g');
%    scatter(american_data_max_trq,american_data_fuel_t,'r');
%    
%    
%          %trq with curb weight
%    figure;
%    scatter(eurpean_data_max_trq, eurpean_data_curb_w,'c');
%    hold on
%    scatter(asian_data_max_trq, asian_data_curb_w,'g');
%    scatter(american_data_max_trq,american_data_curb_w,'r');
%    
%    %trq with top speed
%       figure;
%    scatter(eurpean_data_max_trq, eurpean_data_top_sp,'c');
%    hold on
%    scatter(asian_data_max_trq, asian_data_top_sp,'g');
%    scatter(american_data_max_trq,american_data_top_sp,'r');
%    
%    
%       
%    %trq with length
%       figure;
%    scatter(eurpean_data_max_trq, eurpean_data_length,'c');
%    hold on
%    scatter(asian_data_max_trq, asian_data_length,'g');
%    scatter(american_data_max_trq,american_data_length,'r');
%    
%    
%          
%    %trq with width
%       figure;
%    scatter(eurpean_data_max_trq, eurpean_data_width,'c');
%    hold on
%    scatter(asian_data_max_trq, asian_data_width,'g');
%    scatter(american_data_max_trq,american_data_width,'r');
%    
%       %trq with height
%       figure;
%    scatter(eurpean_data_max_trq, eurpean_data_height,'c');
%    hold on
%    scatter(asian_data_max_trq, asian_data_width,'g');
%    scatter(american_data_max_trq,american_data_width,'r');
%    
%    
%    
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%%%%FUEL TANK%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    %Fuel Tank with curb weight
%    figure;
%    scatter(eurpean_data_fuel_t, eurpean_data_curb_w,'c');
%    hold on
%    scatter(asian_data_fuel_t, asian_data_curb_w,'g');
%    scatter(american_data_fuel_t ,american_data_curb_w,'r');
%    
%    
%    
%     %Fuel Tank with curb weight
%    figure;
%    scatter(eurpean_data_fuel_t, eurpean_data_top_sp,'c');
%    hold on
%    scatter(asian_data_fuel_t, asian_data_top_sp,'g');
%    scatter(american_data_fuel_t ,american_data_top_sp,'r');
%    
%    
%    
%        %Fuel Tank with length
%    figure;
%    scatter(eurpean_data_fuel_t, eurpean_data_length,'c');
%    hold on
%    scatter(asian_data_fuel_t, asian_data_length,'g');
%    scatter(american_data_fuel_t ,american_data_length,'r');
%    
%    
%    
%    
%    
%    
%    
%    %fuel Tank with Weidth
%    
%    figure;
%    scatter(eurpean_data_fuel_t, eurpean_data_width,'c');
%    hold on
%    scatter(asian_data_fuel_t, asian_data_width,'g');
%    scatter(american_data_fuel_t ,american_data_width,'r');
%    
%    
% %fuel tank with Height
% 
%    
%    
   
%       
%    figure;
%    scatter(eurpean_data_fuel_t, eurpean_data_height,'c');
%    hold on
%    scatter(asian_data_fuel_t, asian_data_height,'g');
%    scatter(american_data_fuel_t ,american_data_height,'r');
%    
   
%    
%    %%%%%%%%%%%%%%%%%%%%%%% CURB WEIGHT %%%%%%%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%    %curb weight to top speed
%    figure;
%    scatter(eurpean_data_curb_w, eurpean_data_top_sp,'c');
%    hold on
%    scatter(asian_data_curb_w, asian_data_top_sp,'g');
%    scatter(american_data_curb_w ,american_data_top_sp,'r');
%    
%    
%    %curb with length
%    figure;
%    scatter(eurpean_data_curb_w, eurpean_data_length,'c');
%    hold on
%    scatter(asian_data_curb_w, asian_data_length,'g');
%    scatter(american_data_curb_w ,american_data_length,'r');
%    
%   
%    %curb with width
%    figure;
%    scatter(eurpean_data_curb_w, eurpean_data_width,'c');
%    hold on
%    scatter(asian_data_curb_w, asian_data_width,'g');
%    scatter(american_data_curb_w ,american_data_width,'r');
%    
%         %curb with height
%    
%    figure;
%    scatter(eurpean_data_curb_w, eurpean_data_height,'c');
%    hold on
%    scatter(asian_data_curb_w, asian_data_height,'g');
%    scatter(american_data_curb_w ,american_data_height,'r');
%    
%    
% 
%    
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%    
%    
%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%% TOP SPEED .  %%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%    
%    
%    
%    
%    %top speed with length
%    figure;
%    scatter(eurpean_data_top_sp, eurpean_data_length,'c');
%    hold on
%    scatter(asian_data_top_sp, asian_data_length,'g');
%    scatter(american_data_top_sp ,american_data_length,'r');
%    
%    
%    
%       %top speed with width
%    figure;
%    scatter(eurpean_data_top_sp, eurpean_data_width,'c');
%    hold on
%    scatter(asian_data_top_sp, asian_data_width,'g');
%    scatter(american_data_top_sp ,american_data_width,'r');
%    
%    
%       
%    
%       %top speed with height
%    figure;
%    scatter(eurpean_data_top_sp, eurpean_data_height,'c');
%    hold on
%    scatter(asian_data_top_sp, asian_data_height,'g');
%    scatter(american_data_top_sp ,american_data_height,'r');
%    
%    
%    
%      
%    
%       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%% LENGTH .  %%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
%    
%    
%          %length with width
%    figure;
%    scatter(eurpean_data_length, eurpean_data_width,'c');
%    hold on
%    scatter(asian_data_length, asian_data_width,'g');
%    scatter(american_data_length ,american_data_width,'r');
%    
%    
%    %length with height
%       figure;
%    scatter(eurpean_data_length, eurpean_data_height,'c');
%    hold on
%    scatter(asian_data_length, asian_data_height,'g');
%    scatter(american_data_length ,american_data_height,'r');
%    
%    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    %%%%%%%%%%%%% width %%%%%%%%%%%%%
%    
%    %width with height
%    
%         figure;
%    scatter(eurpean_data_width, eurpean_data_height,'c');
%    hold on
%    scatter(asian_data_width, asian_data_height,'g');
%    scatter(american_data_width ,american_data_height,'r');
%    
%  
   
   
   %hp
% f = figure;
% p = uipanel('Parent',f,'BorderType','line');
% p.Title = 'My Supa Title';
% p.TitlePosition = 'centertop';
% p.FontSize = 13;
% p.FontWeight = 'bold';
% 
% figure;
% %%%%%% petal Length with Sepal Width
% scatter(setosaPL,setosaSW,'r');
% hold on
% scatter(versiPL, versiSW, 'k');
% scatter(virginPL, virginSW, 'b'); 
% title('Petal Length','FontSize',20);
% box on
% 
% figure;
% %%%%%% Petal Length to Sepal Length
% scatter(setosaPL,setosaSL,'r');
% hold on
% scatter(versiPL, versiSL, 'k');
% scatter(virginPL, virginSL, 'b'); 
% box on
% 
% figure;
% %%%%%% Sepal Width to Sepal Length
% scatter(setosaSW,setosaSL,'r');
% hold on
% scatter(versiSW, versiSL, 'k');
% scatter(virginSW, virginSL, 'b'); 
% title('Sepal Width','FontSize',20);
% box on

 
    
end


