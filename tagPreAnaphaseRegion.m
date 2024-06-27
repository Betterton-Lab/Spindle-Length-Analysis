%% Manually identifying region of interest by clicking two points on the lvt curve:
%  i.e. used for defining region of pre-anaphase length, region of steady growth. 
% 
% mutant_type = "cut7_phospho\FL\SS";
% data_list = ["001_A","001_B","001_D","001_E","001_F","001_H","002_G","002_I","003_B"];

% mutant_type = "cut7_phospho\FL\9A";
% data_list = ["001_A","001_B","002_C","002_D","002_E","002_G","003_A","003_D","003_G"];

% mutant_type = "cut7_phospho\FL\9D";
% data_list = ["002_D","002_G","003_A","003_B","003_D","003_F","003_H"];

% mutant_type = "cut7_phospho\1030TD\SS";
% data_list = ["001_A","001_C","001_E","001_F","002_A","002_D","002_G","003_A","003_D","003_G","003_I"];

% mutant_type = "cut7_phospho\1030TD\9A";
% data_list = ["001_C","001_D","001_E","001_F","002_B","002_E","003_B","003_E","003_H"];
% 
% mutant_type = "cut7_phospho\1030TD\9D";
% data_list = ["001_C","001_D","002_A","002_B","002_C","003_B","003_C","004_B","004_C","004_D","004_E"];


% mutant_type = "cut7_T1011A";
% data_list = ["001_B","001_F","001_H","002_E","003_H","003_K","004_C","004_E"];

mutant_type = "cut7_P1021S";
data_list = ["002_A","002_B","002_D","002_E","003_A","003_D","004_B"];

lvt_dir_path = "C:\Research\Projects\Current Biology Paper\Software\BatchLVT\saved data\" + mutant_type + "\";
lvt_raw_path = lvt_dir_path + "\" + data_list + "\" + data_list + "_lvt_raw.mat";
lvt_smooth_path = lvt_dir_path + "\" + data_list + "\" + data_list + "_lvt_smoothed.mat";
% Initialize an empty cell arry to store user input data:
pre_anaphase_lvt_cell = cell(length(data_list)+1, 7);
pre_anaphase_lvt_cell(1,1:7) = {'Cell ID', 'Frames', 'Time', 'Length', 'Frames', 'Time', 'Length'};
% Initialize an empty arry to collect data within the time window of pre-anaphase spindle:
pre_anaphase_len_collection = zeros(length(data_list), 100);
pre_anaphase_len_collection( pre_anaphase_len_collection == 0 ) = NaN;

for idx = 1 : length(data_list)
    disp(" ");
    disp(strcat("Currently working on:  ", data_list(idx)));
    load(lvt_raw_path(idx));
    load(lvt_smooth_path(idx));
    % Plot and Tag:
    figure;
    set(gcf, "Units", "centimeters", "Position", [4, 12, 16, 12])
    plot(lvt_smoothed(:,1),lvt_smoothed(:,2),'.-',color=[0,0.75,0]);
    hold on;
    plot(lvt_raw(:,1),lvt_raw(:,2),'.-',color=[0.75,0,0]);
    xlabel('Time (minutes)');
	ylabel('Spindle length (\mum)');
    disp('Click two points that define the pre-anaphase region on the curve:')
    % Wait for user inputs: 
    user_click_curve = ginput(2);
    plot(user_click_curve(1,1),user_click_curve(1,2),'kx',MarkerSize=10, LineWidth=1);
    plot(user_click_curve(2,1),user_click_curve(2,2),'kx',MarkerSize=10, LineWidth=1);
    % Find the nearest real data point of the click (golden dot):
    nearest_idx = dsearchn(lvt_raw,user_click_curve);
    plot(lvt_raw(nearest_idx(1),1),lvt_raw(nearest_idx(1),2),color=[0.9, 0.5, 0], Marker=".", MarkerSize=20, LineWidth=1);
    plot(lvt_raw(nearest_idx(2),1),lvt_raw(nearest_idx(2),2),color=[0.9, 0.5, 0], Marker=".", MarkerSize=20, LineWidth=1);
    % Save the tagged plot: 
    plot_name = strcat(lvt_dir_path, 'pre_anaphase_region_', data_list(idx), '.png');
    exportgraphics(gcf, plot_name);
    pause(1);
    close all;
    % Store the user input to variable: 
    pre_anaphase_lvt_cell(idx+1,1) = {data_list(idx)};
    pre_anaphase_lvt_cell(idx+1,2) = {nearest_idx(1)};
    pre_anaphase_lvt_cell(idx+1,3) = {lvt_raw(nearest_idx(1),1)};
    pre_anaphase_lvt_cell(idx+1,4) = {lvt_raw(nearest_idx(1),2)};
    pre_anaphase_lvt_cell(idx+1,5) = {nearest_idx(2)};
    pre_anaphase_lvt_cell(idx+1,6) = {lvt_raw(nearest_idx(2),1)};
    pre_anaphase_lvt_cell(idx+1,7) = {lvt_raw(nearest_idx(2),2)};
    % Collect the spindle length info: 
    pre_anaphase_len_collection(idx,1:1+nearest_idx(2)-nearest_idx(1)) = lvt_raw(nearest_idx(1):nearest_idx(2),2);
end

% Pre-anaphase spindle length information matrix: (avg, std, stdom, data num)
pre_anaphase_spl_info = [mean(pre_anaphase_len_collection(:),"omitnan"), ...
                         std(pre_anaphase_len_collection(:),"omitnan"),...
                         std(pre_anaphase_len_collection(:),"omitnan")/sqrt(sum(~isnan(pre_anaphase_len_collection),"all")),...
                         sum(~isnan(pre_anaphase_len_collection),"all")];

% Save the variable to disk:
cd (lvt_dir_path);
save pre_anaphase_cell.mat  pre_anaphase_lvt_cell;
writecell(pre_anaphase_lvt_cell, 'pre_anaphase_cell.csv');
matrix_name = strcat(lvt_dir_path, 'pre_anaphase_spl_info.mat');
save(matrix_name,"pre_anaphase_spl_info");
