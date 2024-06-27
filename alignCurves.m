%% Crate the (2nDataset by max_nFrame) matrix for all lvt curves, for each mutant. 
%% Plot all lvt curves on a single plot.

mutant_name = "FL";
mutant_type = "cut7_phospho\FL\SS";
data_list = ["001_A","001_B","001_D","001_E","001_F","001_H","002_G","002_I","003_B"];

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

% mutant_name = "P1021S";
% mutant_type = "cut7_P1021S";
% data_list = ["002_A","002_B","002_D","002_E","003_A","003_D","004_B"];


lvt_dir_path = "C:\Research\Projects\Current Biology Paper\Software\BatchLVT\saved data\" + mutant_type + "\";
lvt_smooth_path = lvt_dir_path + "\" + data_list + "\" + data_list + "_lvt_smoothed.mat";
onset_time_path = lvt_dir_path + "\pre_anaphase_cell.mat";
steady_growth_path = lvt_dir_path + "\steady_growth_cell.mat";

% Collect all the smoothed arrays:
all_lvt_matrix = zeros(300, 2*length(data_list));

figure;
set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position", [2, 2, 12, 9]);
set(gcf, "Units", "centimeters", "Position", [14, 10, 14.5, 11.5])
hold on;
box on;
xlabel('Time (minutes)');
ylabel('Spindle length (\mum)');

for idx = 1:length(data_list)
    load(lvt_smooth_path(idx));
    all_lvt_matrix(1:size(lvt_smoothed,1), 2*idx-1:2*idx) = lvt_smoothed(:,1:2);
    plot(lvt_smoothed(:,1),lvt_smoothed(:,2),LineWidth=1);
end
pause(1);

% Making the time-aligned array, shifting all the time data by 
% the manually identified anaphase onset time for each cell:
all_lvt_matrix_aligned = all_lvt_matrix;
all_lvt_matrix_aligned( all_lvt_matrix_aligned == 0 ) = NaN;
load(onset_time_path);
load(steady_growth_path);

figure;
set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position", [2, 2, 12, 9]);
set(gcf, "Units", "centimeters", "Position", [14, 10, 14.5, 11.5])
hold on;
box on;
xlabel('Time (minutes)');
ylabel('Spindle length (\mum)');
xlim([-6, 12]);
ylim([0, 11]);
plot(zeros(14,1), 0:1:13, 'k--');
for idx = 1:length(data_list)
    time_shift = cell2mat(pre_anaphase_lvt_cell(idx+1,6));
    time_steady = cell2mat(steady_growth_lvt_cell(idx+1,3));
    time_differ = time_steady - time_shift;
    all_lvt_matrix_aligned(:,2*idx-1) = all_lvt_matrix_aligned(:,2*idx-1) - time_shift;
    plot(all_lvt_matrix_aligned(:,2*idx-1),all_lvt_matrix_aligned(:,2*idx),LineWidth=1);
end
% Save the plot + aligned matrix to disk: 
plot_name = strcat(lvt_dir_path, mutant_name, '_aligned_lvt_curves.png');
saveas(gcf, plot_name);
aligned_matrix_name = strcat(lvt_dir_path, mutant_name, '_lvt_aligned.mat');
save(aligned_matrix_name,"all_lvt_matrix_aligned");
pause(1);


%% Plot the average curve + shadow of errors:
% A time vs. averaged spindle length matrix 
% (format: time step, average length, length stdev, length stdom, blank space, len_1, len_2, len_3, ..., len_n)
tva_matrix = zeros(200, 100);
tva_matrix( tva_matrix == 0 ) = NaN;

time_only_matrix = all_lvt_matrix_aligned(:,1:2:size(all_lvt_matrix_aligned,2));
length_only_matrix = all_lvt_matrix_aligned(:,2:2:size(all_lvt_matrix_aligned,2));

time_window = 0.5;          % min, time resolution
time_start = -10.5;         % min, before anaphase onset
time_end = 15.5;            % min, after anaphase onset
row_counts = 0;

% Find all the time points within the window
for times = time_start:time_window:time_end
    row_counts = row_counts + 1;
    % The index matrix marks all the time points within the time window
    index_matrix = find(abs(time_only_matrix(:,:) - times) < time_window);
    % Pull the length data from length_only_matrix
    tva_matrix(row_counts, 6:size(index_matrix,1)+5) = length_only_matrix(index_matrix);
    % TVA format: time step, average length, length stdev, length stdom, blank space, len_1, len_2, len_3, ..., len_n
    tva_matrix(row_counts, 1) = times;
    tva_matrix(row_counts, 2) = mean(length_only_matrix(index_matrix),'omitnan');
    tva_matrix(row_counts, 3) = std(length_only_matrix(index_matrix),'omitnan');
    tva_matrix(row_counts, 4) = std(length_only_matrix(index_matrix),'omitnan')/sqrt(length(index_matrix));
end

% Plot the averaged curve:
set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position", [2, 2, 12, 9]);
set(gcf, "Units", "centimeters", "Position", [14, 10, 14.5, 11.5])
hold on;
box on;
plot(tva_matrix(:, 1), tva_matrix(:, 2), 'k.-', LineWidth=3);
xlabel('Time (minutes)');
ylabel('Spindle length (\mum)');
xlim([-4.5, 9.5]);
ylim([0, 11]);

% Plot the error bar shadow using area plot:
clear shadow_region;
shadow_region(1:row_counts,1) = tva_matrix(1:row_counts, 1);
shadow_region(1:row_counts,2) = tva_matrix(1:row_counts, 2) + tva_matrix(1:row_counts, 4);
shadow_region(row_counts+1:2*row_counts,1) = flip(tva_matrix(1:row_counts, 1));
shadow_region(row_counts+1:2*row_counts,2) = flip(tva_matrix(1:row_counts, 2) - tva_matrix(1:row_counts, 4));
% plot(shadow_region(:,1),shadow_region(:,2),'k',LineWidth=1);
fill(shadow_region(:,1),shadow_region(:,2),'k','FaceAlpha',0.3,'EdgeColor','None','HandleVisibility','off');

% Save the plot + aligned matrix to disk: 
plot_name = strcat(lvt_dir_path, mutant_name, '_TVA.png');
saveas(gcf, plot_name);
matrix_name = strcat(lvt_dir_path, mutant_name, '_TVA.mat');
save(matrix_name,"tva_matrix");
shadow_region_name = strcat(lvt_dir_path, mutant_name, '_err.mat');
save(shadow_region_name,"shadow_region");

pause(1);
% close all;