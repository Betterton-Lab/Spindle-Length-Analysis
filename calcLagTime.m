%% Calcuate the time to steady-state growth from anaphase onset for each mutant:

% mutant_name = "FL";
% mutant_type = "cut7_phospho\FL\SS";
% data_list = ["001_A","001_B","001_D","001_E","001_F","001_H","002_G","002_I","003_B"];

% mutant_name = "FL-9A";
% mutant_type = "cut7_phospho\FL\9A";
% data_list = ["001_A","001_B","002_C","002_D","002_E","002_G","003_A","003_D","003_G"];

% mutant_name = "FL-9D";
% mutant_type = "cut7_phospho\FL\9D";
% data_list = ["002_D","002_G","003_A","003_B","003_D","003_F","003_H"];
% 
% mutant_name = "1030";
% mutant_type = "cut7_phospho\1030TD\SS";
% data_list = ["001_A","001_C","001_E","001_F","002_A","002_D","002_G","003_A","003_D","003_G","003_I"];
% 
% mutant_name = "1030-9A";
% mutant_type = "cut7_phospho\1030TD\9A";
% data_list = ["001_C","001_D","001_E","001_F","002_B","002_E","003_B","003_E","003_H"];
% 
% mutant_name = "1030-9D";
% mutant_type = "cut7_phospho\1030TD\9D";
% data_list = ["001_C","001_D","002_A","002_B","002_C","003_B","003_C","004_B","004_C","004_D","004_E"];
% 
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

ana_onset_time = cell2mat(pre_anaphase_lvt_cell(2:end,6));
ss_growth_time = cell2mat(steady_growth_lvt_cell(2:end,3));
ss_growth_length = cell2mat(steady_growth_lvt_cell(2:end,4));
lag_time_info = ss_growth_time - ana_onset_time;

% Average lag time stored at (1,3) in the lag_time matrix: 
lag_time_info(1,2) = mean(lag_time_info(:,1));
% Standard deviation stored at (2,3) in the lag_time matrix:
lag_time_info(2,2) = std(lag_time_info(:,1));

% Spindle length at the start of steady-state growth:
lag_time_info(:,3) = ss_growth_length;
% Average spindle length at the beginning of steady-state growth:
lag_time_info(1,4) = mean(lag_time_info(:,3));
%  Standard deviation of spindle length at the beginning of steady-state growth:
lag_time_info(2,4) = std(lag_time_info(:,3));


filename = strcat(lvt_dir_path, mutant_name, '_lag_time_info.mat');
save(filename,"lag_time_info");
filename = strcat(lvt_dir_path, mutant_name, '_lag_time_info.csv');
writematrix(lag_time_info(:,1:2), filename);
