%% Batch generate spindle length vs time array: 
addpath(genpath('functions'));

%% Data filtering and smoothing parameters:
len_thres = 0.5;    % microns
time_smooth = 2;    % minutes

%% Cut7 Phospho Mutants
% mutant_type = "cut7_phospho\FL\SS";
% data_list = ["001_A","001_B","001_C","001_D","001_E","001_F","001_G","001_H",...
%              "002_A","002_B","002_C","002_D","002_E","002_F","002_G","002_I",...
%              "003_A","003_B","003_C","003_E"];
% data_path_mov = "C:\Research\Data\" + mutant_type + "\Segmented Cells\1199_100R_100G_25 deg_" + data_list + ".mat";

mutant_type = "cut7_phospho\FL\9A";
data_list = ["001_A","001_B","002_A","002_B","002_C","002_D","002_E","002_F","002_G",...
             "003_A","003_B","003_C","003_D","003_E","003_F","003_G","003_H","003_I","003_J","003_K"];
data_path_mov = "C:\Research\Data\" + mutant_type + "\Segmented Cells\1201_100R_100G_25 deg_" + data_list + ".mat";

% mutant_type = "cut7_phospho\FL\9D";
% data_list = ["002_B","002_C","002_D","002_E","002_F","002_G",...
%              "003_A","003_B","003_D","003_E","003_F","003_G","003_H",...
%              "004_A","004_B","004_C","004_D"];
% % data_list = "002_G";
% data_path_mov = "C:\Research\Data\" + mutant_type + "\Segmented Cells\1203_100R_100G_25 deg_" + data_list + ".mat";

% mutant_type = "cut7_phospho\1030TD\SS";
% data_list = ["001_A","001_B","001_C","001_D","001_E","001_F",...
%              "002_A","002_B","002_C","002_D","002_E","002_F","002_G",...
%              "003_A","003_B","003_C","003_D","003_E","003_F","003_G","003_H","003_I"];
% % data_list = "002_G";
% data_path_mov = "C:\Research\Data\" + mutant_type + "\Segmented Cells\1181_100R_100G_25 deg_" + data_list + ".mat";

% mutant_type = "cut7_phospho\1030TD\9A";
% data_list = ["001_A","001_B","001_C","001_D","001_E","001_F",...
%              "002_B","002_C","002_D","002_E",...
%              "003_A","003_B","003_C","003_D","003_E","003_F","003_G","003_H"];
% % data_list = "002_E";
% data_path_mov = "C:\Research\Data\" + mutant_type + "\Segmented Cells\1183_100R_100G_25 deg_" + data_list + ".mat";

% mutant_type = "cut7_phospho\1030TD\9D";
% data_list = ["001_A","001_B","001_C","001_D","001_E",...
%               "002_A","002_B","002_C","003_A","003_B","003_C",...
%               "004_B","004_C","004_D","004_E","004_F"];
% % data_list = "004_E";
% data_path_mov = "C:\Research\Data\" + mutant_type + "\Segmented Cells\1185_100R_100G_25 deg_" + data_list + ".mat";

% % % % path to load the tracked cut7 position data: 
data_path_pos = "C:\Research\Data\" + mutant_type + "\Kymographs\" + data_list + "\pos_cut7_pk.mat";

%% Cut7 Point Mutants (TS)
% mutant_type = "cut7_T1011A";
% data_list = ["001_A","001_B","001_C","001_D","001_E","001_F","001_G","001_H",...
%              "002_A","002_B","002_C","002_D","002_E","002_F",...
%              "003_A","003_B","003_C","003_D","003_E","003_F","003_G","003_H","003_I","003_J","003_K",...
%              "004_A","004_B","004_C","004_D","004_E","004_F","004_G"];
% data_path_mov = "C:\Research\Data\Cut7 Point Mutants\" + mutant_type + "\Segmented Cells\1029_100R_100G_25deg_" + data_list + ".mat";
% data_path_pos = "C:\Research\Data\Cut7 Point Mutants\" + mutant_type + "\Kymographs\" + data_list + "\pos_cut7_pk.mat";

% mutant_type = "cut7_P1021S";
% data_list = ["002_A","002_B","002_C","002_D","002_E","002_F",...
%              "003_A","003_B","003_C","003_D","003_E",...
%              "004_A","004_B","004_C","004_D","004_E","004_F"];
% data_path_mov = "C:\Research\Data\Cut7 Point Mutants\" + mutant_type + "\Segmented Cells\1097_100R_100G_25deg_" + data_list + ".mat";
% data_path_pos = "C:\Research\Data\Cut7 Point Mutants\" + mutant_type + "\Kymographs\" + data_list + "\pos_cut7_pk.mat";


% Make a separate directory to store outputs
if ~exist("saved data", 'dir')
    mkdir("saved data")
end
cd 'saved data'
mkdir(mutant_type);
cd ..

for idx = 1 : length(data_list)
    disp(" ");
    disp(strcat("Currently working on:  ", data_list(idx)));
    % Loading ImageObj and cut7/MT movies
    ImageObj = ImageData.InitializeFromCell(convertStringsToChars(data_path_mov(idx)));
    % Getting spatial and temporal dimension of the data
    pixel_size = ImageObj.GetSizeVoxels;
    time_step = ImageObj.GetTimeStep;
    % Getting MT and cut7 channel movie (red/green)
    clear movie5D;
    clear ImageObj;
    % Load the cut7 position data
    load(data_path_pos(idx));
    % Save data in the appopriated folder
    cd 'Saved Data\';
    cd(mutant_type)
    mkdir(data_list(idx))
    cd(data_list(idx))
    
    %% Generate and save the raw lvt matrix: 
    lvt_raw = translateLvT(pos_cut7_pk, time_step, pixel_size);
    lvt_matrix_name = strcat(data_list(idx), '_lvt_raw.mat');
    save(lvt_matrix_name,"lvt_raw");

    %% Fit the raw lvt curve with 5th order poly to detect outliers
    lvt_fit_func = fit(lvt_raw(:,1),lvt_raw(:,2),'poly5','Robust','Bisquare');
    lvt_fitted = [lvt_raw(:,1), lvt_fit_func(lvt_raw(:,1))];
    length_diff = abs(lvt_fitted(:,2) - lvt_raw(:,2));

    % Outlier detection, using a threshold of 0.5 microns:
    bad_pts = find(length_diff > len_thres);          % Find the index of the outliers
    lvt_filtered = lvt_raw;
    lvt_filtered(bad_pts, 2)=NaN;               % Removing bad length points

    % Filling the bad points using linear interpolation of the good points in the neighborhood:
    lvt_filled = lvt_filtered;
    lvt_filled(:,2) = fillmissing(lvt_filtered(:,2),'linear','SamplePoints',lvt_filtered(:,1));

    % Smooth the filled missing curve, using a time average of 2 minutes:
    lvt_smoothed = timeAverage(lvt_filled, time_smooth);
    lvt_matrix_name = strcat(data_list(idx), '_lvt_smoothed.mat');
    save(lvt_matrix_name,"lvt_smoothed");

    %%% Demo only %%%
    figure;
    set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position", [2, 2, 12, 9]);
    set(gcf, "Units", "centimeters", "Position", [14, 14, 14.5, 11.5])
    hold on;
    box on;
    legend boxoff;
    xlabel('Time (minutes)');
    ylabel('Spindle length (\mum)');
    % lvt_raw in red: [0.75, 0, 0]
    plot(lvt_raw(:,1),lvt_raw(:,2),'.-',Color=[0.75, 0, 0],LineWidth=1);
    legend("raw",Location="northwest");
    pause(1);
    % lvt_fit in purple: [0.5, 0, 0.75]
    plot(lvt_fitted(:,1),lvt_fitted(:,2),'.-',Color=[0.5, 0, 0.75],LineWidth=1);
    legend("raw","fitted",Location="northwest");
    pause(1);
    % lvt_filtered in dark red X: [0.5, 0.0, 0]
    if ~isempty(bad_pts)
        plot(lvt_raw(bad_pts,1),lvt_raw(bad_pts,2),'x',Color=[0.5, 0, 0],MarkerSize=10,LineWidth=2);
        legend("raw","fitted","filtered",Location="northwest");
        pause(1);
    end
    % lvt_filled in orange: [0.75, 0.5, 0]
    plot(lvt_filled(:,1),lvt_filled(:,2),'o-',Color=[0.75, 0.5, 0],LineWidth=1);
    if ~isempty(bad_pts)
        legend("raw","fitted","filtered","filled",Location="northwest");
    else    % No points filtered:
        legend("raw","fitted","filled",Location="northwest");
    end
    pause(1);
    % lvt_smoothed in green: [0, 0.75, 0]
    plot(lvt_smoothed(:,1),lvt_smoothed(:,2),'.-',Color=[0.0, 0.75, 0.25],LineWidth=2);
    if ~isempty(bad_pts)
        legend("raw","fitted","filtered","filled","smoothed",Location="northwest");
    else    % No points filtered:
        legend("raw","fitted","filled","smoothed",Location="northwest");
    end
    pause(1);
    lvt_plot_name = strcat(data_list(idx), '_all_lvts.png');
    saveas(gcf, lvt_plot_name);
    close all;
    %%% Demo only %%%
    

    %% Plot the final curves: 
    figure;
    set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position", [2, 2, 12, 9]);
    set(gcf, "Units", "centimeters", "Position", [14, 14, 14.5, 11.5])
    hold on;
    box on;
    % lvt_raw in red: [0.75, 0, 0]
    plot(lvt_raw(:,1),lvt_raw(:,2),'.-',Color=[0.75, 0, 0],LineWidth=1);
    % lvt_smoothed in green: [0, 0.75, 0]
    plot(lvt_smoothed(:,1),lvt_smoothed(:,2),'.-',Color=[0.0, 0.75, 0.25],LineWidth=1);
    
    % Legends and labels:
    legend("raw","smoothed",Location="northwest");
    legend boxoff;
    xlabel('Time (minutes)');
    ylabel('Spindle length (\mum)');
    % Get a decent xy range for all the plots:
    x_range = [0, max(lvt_raw(:,1))+0.1];
    min_y = min(lvt_raw(:,2))-0.5;
    if min_y <= 0
        min_y = 0;
    end
    y_range = [min_y, max(lvt_raw(:,2))+0.5];
    xlim(x_range);
    ylim(y_range);
    pause(1);

    %% Save the plots:
    cd ..
    lvt_plot_name = strcat(data_list(idx), '_lvts.png');
    saveas(gcf, lvt_plot_name);
    cd 'C:\Research\Projects\Current Biology Paper\Software\BatchLVT\'
    
end

close all;
