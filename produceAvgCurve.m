% Produce an averaged curve from multiple aligned curves:

addpath(genpath('functions'));

% % mutant_name = "FL";
% % mutant_type = "cut7_phospho\FL\SS";

lvt_dir_path = "C:\Research\Projects\Current Biology Paper\Software\BatchLVT\saved data\" + mutant_type + "\";
align_matrix_path = lvt_dir_path + mutant_name + "_lvt_aligned.mat";

load(align_matrix_path);

% A time vs. averaged spindle length matrix 
% (format: time step, average length, length stdev, length stdom, blank space, len_1, len_2, len_3, ..., len_n)
tva_matrix = zeros(200, 50);
tva_matrix( tva_matrix == 0 ) = NaN;

time_only_matrix = all_lvt_matrix_aligned(:,1:2:size(all_lvt_matrix_aligned,2));
length_only_matrix = all_lvt_matrix_aligned(:,2:2:size(all_lvt_matrix_aligned,2));

time_window = 0.25;         % min, time resolution
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
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position", [2, 2, 12, 9]);
set(gcf, "Units", "centimeters", "Position", [14, 14, 14.5, 11.5])
hold on;
box on;
plot(zeros(12,1), 0:1:11, 'k--');
xlabel('Time (minutes)');
ylabel('Spindle length (\mum)');
xlim([-5, 9]);
ylim([0, 11]);
plot(tva_matrix(:, 1), tva_matrix(:, 2), 'k.-', LineWidth=3);

% Plot the error bar shadow using area plot:
clear shadow_region;
shadow_region(1:row_counts,1) = tva_matrix(1:row_counts, 1);
shadow_region(1:row_counts,2) = tva_matrix(1:row_counts, 2) + tva_matrix(1:row_counts, 4);
shadow_region(row_counts+1:2*row_counts,1) = flip(tva_matrix(1:row_counts, 1));
shadow_region(row_counts+1:2*row_counts,2) = flip(tva_matrix(1:row_counts, 2) - tva_matrix(1:row_counts, 4));
% plot(shadow_region(:,1),shadow_region(:,2),'k',LineWidth=1);
fill(shadow_region(:,1),shadow_region(:,2),'k','FaceAlpha',0.3,'EdgeColor','None','HandleVisibility','off');

% Save the plot + aligned matrix to disk: 
plot_name = strcat(lvt_dir_path, mutant_name, '_average_lvt_curves.png');
saveas(gcf, plot_name);
matrix_name = strcat(lvt_dir_path, mutant_name, '_TVA.mat');
save(matrix_name,"tva_matrix");
shadow_region_name = strcat(lvt_dir_path, mutant_name, '_err.mat');
save(shadow_region_name,"shadow_region");


