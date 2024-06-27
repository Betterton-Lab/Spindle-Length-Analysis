%% Extract the spindle length and time raw data bewteen the tagging interval for each mutant: 

% mutant_name = "FL";
% mutant_type = "cut7_phospho\FL\SS";
% data_list = ["001_A","001_B","001_D","001_E","001_F","001_H","002_G","002_I","003_B"];

% mutant_name = "FL-9A";
% mutant_type = "cut7_phospho\FL\9A";
% data_list = ["001_A","001_B","002_C","002_D","002_E","002_G","003_A","003_D","003_G"];

% mutant_name = "FL-9D";
% mutant_type = "cut7_phospho\FL\9D";
% data_list = ["002_D","002_G","003_A","003_B","003_D","003_F","003_H"];

% mutant_name = "1030";
% mutant_type = "cut7_phospho\1030TD\SS";
% data_list = ["001_A","001_C","001_E","001_F","002_A","002_D","002_G","003_A","003_D","003_G","003_I"];

% mutant_name = "1030-9A";
% mutant_type = "cut7_phospho\1030TD\9A";
% data_list = ["001_C","001_D","001_E","001_F","002_B","002_E","003_B","003_E","003_H"];

% mutant_name = "1030-9D";
% mutant_type = "cut7_phospho\1030TD\9D";
% data_list = ["001_C","001_D","002_A","002_B","002_C","003_B","003_C","004_B","004_C","004_D","004_E"];

% mutant_name = "T1011A";
% mutant_type = "cut7_T1011A";
% data_list = ["001_B","001_F","001_H","002_E","003_H","003_K","004_C","004_E"];

mutant_name = "P1021S";
mutant_type = "cut7_P1021S";
data_list = ["002_A","002_B","002_D","002_E","003_A","003_D","004_B"];


lvt_dir_path = "C:\Research\Projects\Current Biology Paper\Software\BatchLVT\saved data\" + mutant_type + "\";
lvt_smooth_path = lvt_dir_path + "\" + data_list + "\" + data_list + "_lvt_smoothed.mat";
onset_time_path = lvt_dir_path + "\pre_anaphase_cell.mat";
steady_growth_path = lvt_dir_path + "\steady_growth_cell.mat";

% Load both the anaphase onset info data + steady growth start info data:
load(onset_time_path);      % pre_anaphase_lvt_cell
load(steady_growth_path);   % steady_growth_lvt_cell

% Get the frame interval info for each cell: 
pre_anaphase_begin_frames = cell2mat(pre_anaphase_lvt_cell(2:end,2));
pre_anaphase_end_frames = cell2mat(pre_anaphase_lvt_cell(2:end,5));
steady_growth_begin_frames = cell2mat(steady_growth_lvt_cell(2:end,2));
steady_growth_end_frames = cell2mat(steady_growth_lvt_cell(2:end,5));

pre_anaphase_length_data = zeros(0,0);
steady_state_growth_data = zeros(0,0);
% Exract the data from lvt_smoothed: 
for idx = 1:length(data_list)
    load(lvt_smooth_path(idx));
    pre_anaphase_first = pre_anaphase_begin_frames(idx);
    pre_anaphase_last = pre_anaphase_end_frames(idx);
    pre_anaphase_length_data = [pre_anaphase_length_data; lvt_smoothed(pre_anaphase_first:pre_anaphase_last, 2)];
    ss_growth_first = steady_growth_begin_frames(idx);
    ss_growth_last = steady_growth_end_frames(idx);
    steady_state_growth_data = [steady_state_growth_data; lvt_smoothed(ss_growth_first:ss_growth_last, 1:2)];
end

% Save data to disk: 
filename = strcat(lvt_dir_path, mutant_name, '_pre_anaphase_length_data.mat');
save(filename,"pre_anaphase_length_data");
filename = strcat(lvt_dir_path, mutant_name, '_pre_anaphase_length_data.csv');
writematrix(pre_anaphase_length_data, filename);
filename = strcat(lvt_dir_path, mutant_name, '_steady_state_growth_data.mat');
save(filename,"steady_state_growth_data");
filename = strcat(lvt_dir_path, mutant_name, '_steady_state_growth_data.csv');
writematrix(steady_state_growth_data, filename);

