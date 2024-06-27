%% Make the time to steady-state growth histograms: 

% Strain name and dataset path: 
mutant_name = ["FL", "FL-9A", "FL-9D", "1030", "1030-9A", "1030-9D", "P1021S", "T1011A"];
mutant_type = ["cut7_phospho\FL\SS", "cut7_phospho\FL\9A", "cut7_phospho\FL\9D",...
    "cut7_phospho\1030TD\SS", "cut7_phospho\1030TD\9A", "cut7_phospho\1030TD\9D", "cut7_P1021S", "cut7_T1011A"];
lvt_dir_path = "C:\Research\Projects\Current Biology Paper\Software\BatchLVT\saved data\" + mutant_type + "\";
lag_path = lvt_dir_path + mutant_name + "_lag_time_info.mat";

%% Load the data for histograms:
load(lag_path(1));
lagT_FL_SS = lag_time_info(1,2);
lagT_err_FL_SS = lag_time_info(2,2);

load(lag_path(2));
lagT_FL_9A = lag_time_info(1,2);
lagT_err_FL_9A = lag_time_info(2,2);

load(lag_path(3));
lagT_FL_9D = lag_time_info(1,2);
lagT_err_FL_9D = lag_time_info(2,2);

load(lag_path(4));
lagT_1030_SS = lag_time_info(1,2);
lagT_err_1030_SS = lag_time_info(2,2);

load(lag_path(5));
lagT_1030_9A = lag_time_info(1,2);
lagT_err_1030_9A = lag_time_info(2,2);

load(lag_path(6));
lagT_1030_9D = lag_time_info(1,2);
lagT_err_1030_9D = lag_time_info(2,2);

load(lag_path(7));
lagT_P1021S = lag_time_info(1,2);
lagT_err_P1021S = lag_time_info(2,2);

load(lag_path(8));
lagT_T1011A = lag_time_info(1,2);
lagT_err_T1011A = lag_time_info(2,2);

%% Colors:
cl_FL_SS = [0.6, 0.1, 0.2];
cl_FL_9A = [0.1, 0.3, 0.7];
cl_FL_9D = [0.85, 0.5, 0.1];
cl_1030_SS = [1, 0.5, 0.6];
cl_1030_9A = [0.5, 0.75, 1];
cl_1030_9D = [1, 0.8, 0.4];
cl_P1021S = [0.6, 0.1, 0.9];
cl_T1011A = [0.1, 0.8, 0.6];


%% Plot some histograms: 
% Phospho mutants time to steady-state growth: 
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units","centimeters", "Position",[0.5, 2, 12, 9], 'YTickLabels','');
set(gcf, "Units","centimeters", "Position",[24, 10, 13, 11.5])
box on;
hold on;
% Set the barh in orders
time2ss_growth = flip([lagT_FL_SS; lagT_FL_9A; lagT_FL_9D; lagT_1030_SS; lagT_1030_9A; lagT_1030_9D]);
time2ss_growth_err = flip([lagT_err_FL_SS, lagT_err_FL_9A, lagT_err_FL_9D, lagT_err_1030_SS, lagT_err_1030_9A, lagT_err_1030_9D]);
% The horizontal bar plot:
bar_plot = barh(time2ss_growth);
bar_plot.FaceColor = 'flat';
bar_plot.CData(6,:) = cl_FL_SS;
bar_plot.CData(5,:) = cl_FL_9A;
bar_plot.CData(4,:) = cl_FL_9D;
bar_plot.CData(3,:) = cl_1030_SS;
bar_plot.CData(2,:) = cl_1030_9A;
bar_plot.CData(1,:) = cl_1030_9D;
% Plot the 1030TD again for hatches
bar_plot_1030 = barh(time2ss_growth(1:3));
bar_plot_1030.FaceColor = 'flat';
bar_plot_1030.CData(3,:) = cl_1030_SS;
bar_plot_1030.CData(2,:) = cl_1030_9A;
bar_plot_1030.CData(1,:) = cl_1030_9D;
hatchfill(bar_plot_1030,'single','HatchAngle',45,'HatchColor','w','HatchLineWidth',1);
% Adding errorbars to plot
err_bar = errorbar(time2ss_growth, 1:6, -time2ss_growth_err, +time2ss_growth_err, '.', 'horizontal');
err_bar.Color = [0 0 0];                            
err_bar.LineStyle = 'none';
err_bar.LineWidth = 1.5;
% Labels:
xlabel('Time to steady-state growth (min)');
text_labels = flip(["FL"; "9A"; "9D"; "1030"; "1030-9A"; "1030-9D"]);
text([0.04, 0.04, 0.04, 0.07, 0.07, 0.07], 1:6, text_labels,'VerticalAlignment','middle',"FontName","Arial","FontSize",18);
xlim([0 6.5]);
ylim([0.3 6.7]);
xticks(0:1:6);
yticks([]);
saveas(gcf, 'time stead state phospho.png');
saveas(gcf, 'time stead state phospho.svg');

% Point mutants time to steady-state growth: 
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units","centimeters", "Position",[0.5, 2, 12, 9], 'YTickLabels','');
set(gcf, "Units","centimeters", "Position",[8, 10, 13, 11.5])
box on;
hold on;
% Set the barh in orders
time2ss_growth = flip([lagT_FL_SS; lagT_P1021S; lagT_T1011A]);
time2ss_growth_err = flip([lagT_err_FL_SS, lagT_err_P1021S, lagT_err_T1011A]);
% The horizontal bar plot:
bar_plot = barh(time2ss_growth);
bar_plot.FaceColor = 'flat';
bar_plot.CData(3,:) = cl_FL_SS;
bar_plot.CData(2,:) = cl_P1021S;
bar_plot.CData(1,:) = cl_T1011A;
% Adding errorbars to plot
err_bar = errorbar(time2ss_growth, 1:3, -time2ss_growth_err, +time2ss_growth_err, '.', 'horizontal');
err_bar.Color = [0 0 0];                            
err_bar.LineStyle = 'none';
err_bar.LineWidth = 1.5;
% Labels:
xlabel('Time to steady-state growth (min)');
text_labels = flip(["WT"; "P1021S"; "T1011A";]);
text([0.1, 0.1, 0.1], 1:3, text_labels,'VerticalAlignment','middle',"FontName","Arial","FontSize",18);
xlim([0 6.5]);
ylim([0.3 3.7]);
xticks(0:1:6);
yticks([]);
saveas(gcf, 'time stead state point.png');
saveas(gcf, 'time stead state point.svg');


