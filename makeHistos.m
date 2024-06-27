%% Make the histograms for all strains:

% Strain name and dataset path: 
mutant_name = ["FL", "FL-9A", "FL-9D", "1030", "1030-9A", "1030-9D", "P1021S", "T1011A"];
mutant_type = ["cut7_phospho\FL\SS", "cut7_phospho\FL\9A", "cut7_phospho\FL\9D",...
    "cut7_phospho\1030TD\SS", "cut7_phospho\1030TD\9A", "cut7_phospho\1030TD\9D", "cut7_P1021S", "cut7_T1011A"];
lvt_dir_path = "C:\Research\Projects\Current Biology Paper\Software\BatchLVT\saved data\" + mutant_type + "\";
elong_speed_info_path = lvt_dir_path + "elong_speed_info.mat";
pre_anaphase_info_path = lvt_dir_path + "pre_anaphase_spl_info.mat";


load(elong_speed_info_path(1));
load(pre_anaphase_info_path(1));
elong_speed_FL = elong_speed_collection;
pre_anaphase_FL = pre_anaphase_spl_info;

load(elong_speed_info_path(2));
load(pre_anaphase_info_path(2));
elong_speed_9A = elong_speed_collection;
pre_anaphase_9A = pre_anaphase_spl_info;

load(elong_speed_info_path(3));
load(pre_anaphase_info_path(3));
elong_speed_9D = elong_speed_collection;
pre_anaphase_9D = pre_anaphase_spl_info;

load(elong_speed_info_path(4));
load(pre_anaphase_info_path(4));
elong_speed_1030 = elong_speed_collection;
pre_anaphase_1030 = pre_anaphase_spl_info;

load(elong_speed_info_path(5));
load(pre_anaphase_info_path(5));
elong_speed_1030_9A = elong_speed_collection;
pre_anaphase_1030_9A = pre_anaphase_spl_info;

load(elong_speed_info_path(6));
load(pre_anaphase_info_path(6));
elong_speed_1030_9D = elong_speed_collection;
pre_anaphase_1030_9D = pre_anaphase_spl_info;

load(elong_speed_info_path(7));
load(pre_anaphase_info_path(7));
elong_speed_P1021S = elong_speed_collection;
pre_anaphase_P1021S = pre_anaphase_spl_info;

load(elong_speed_info_path(8));
load(pre_anaphase_info_path(8));
elong_speed_T1011A = elong_speed_collection;
pre_anaphase_T1011A = pre_anaphase_spl_info;

%% elongation speed data: 
speed_FL = elong_speed_FL(end,1);
speed_9A = elong_speed_9A(end,1);
speed_9D = elong_speed_9D(end,1);
speed_1030 = elong_speed_1030(end,1);
speed_1030_9A = elong_speed_1030_9A(end,1);
speed_1030_9D = elong_speed_1030_9D(end,1);
speed_P1021S = elong_speed_P1021S(end, 1);
speed_T1011A = elong_speed_T1011A(end, 1);

speed_err_FL = std(elong_speed_FL(1:end-2,1))/sqrt(length(elong_speed_FL)-2);
speed_err_9A = std(elong_speed_9A(1:end-2,1))/sqrt(length(elong_speed_9A)-2);
speed_err_9D = std(elong_speed_9D(1:end-2,1))/sqrt(length(elong_speed_9D)-2);
speed_err_1030 = std(elong_speed_1030(1:end-2,1))/sqrt(length(elong_speed_1030)-2);
speed_err_1030_9A = std(elong_speed_1030_9A(1:end-2,1))/sqrt(length(elong_speed_1030_9A)-2);
speed_err_1030_9D = std(elong_speed_1030_9D(1:end-2,1))/sqrt(length(elong_speed_1030_9D)-2);
speed_err_P1021S = std(elong_speed_P1021S(1:end-2,1))/sqrt(length(elong_speed_P1021S)-2);
speed_err_T1011A = std(elong_speed_T1011A(1:end-2,1))/sqrt(length(elong_speed_T1011A)-2);


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
% Phospho mutants elongation speed: 
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units","centimeters", "Position",[0.5, 2, 12, 9], 'YTickLabels','');
set(gcf, "Units","centimeters", "Position",[24, 2, 13, 11.5])
box on;
hold on;
% Set the barh in orders
speeds = flip([speed_FL; speed_9A; speed_9D; speed_1030; speed_1030_9A; speed_1030_9D]);
speeds_err = flip([speed_err_FL, speed_err_9A, speed_err_9D, speed_err_1030, speed_err_1030_9A, speed_err_1030_9D]);
% The horizontal bar plot:
bar_plot = barh(speeds);
bar_plot.FaceColor = 'flat';
bar_plot.CData(6,:) = cl_FL_SS;
bar_plot.CData(5,:) = cl_FL_9A;
bar_plot.CData(4,:) = cl_FL_9D;
bar_plot.CData(3,:) = cl_1030_SS;
bar_plot.CData(2,:) = cl_1030_9A;
bar_plot.CData(1,:) = cl_1030_9D;
% Plot the 1030TD again for hatches
bar_plot_1030 = barh(speeds(1:3));
bar_plot_1030.FaceColor = 'flat';
bar_plot_1030.CData(3,:) = cl_1030_SS;
bar_plot_1030.CData(2,:) = cl_1030_9A;
bar_plot_1030.CData(1,:) = cl_1030_9D;
hatchfill(bar_plot_1030,'single','HatchAngle',45,'HatchColor','w','HatchLineWidth',1);
% Adding errorbars to plot
err_bar = errorbar(speeds, 1:6, -speeds_err, +speeds_err, '.', 'horizontal');
err_bar.Color = [0 0 0];                            
err_bar.LineStyle = 'none';
err_bar.LineWidth = 1.5;
% Labels:
xlabel('Elongation speed (\mum/min)');
text_labels = flip(["FL"; "9A"; "9D"; "1030"; "1030-9A"; "1030-9D"]);
text([0.02, 0.02, 0.02, 0.02, 0.02, 0.02], 1:6, text_labels,'VerticalAlignment','middle',"FontName","Arial","FontSize",18);
xlim([0 1.05]);
ylim([0.3 6.7]);
yticks([]);
saveas(gcf, 'elong speed phospho.png');
saveas(gcf, 'elong speed phospho.svg');

% Point mutants elongation speed: 
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position",[0.5, 2, 12, 9], 'YTickLabels','');
set(gcf, "Units", "centimeters", "Position", [24, 14, 13, 11.5])
box on;
hold on;
% Set the barh in orders
speeds = flip([speed_FL; speed_P1021S; speed_T1011A]);
speeds_err = flip([speed_err_FL, speed_err_P1021S, speed_err_T1011A]);
% The horizontal bar plot:
bar_plot = barh(speeds);
bar_plot.FaceColor = 'flat';
bar_plot.CData(3,:) = cl_FL_SS;
bar_plot.CData(2,:) = cl_P1021S;
bar_plot.CData(1,:) = cl_T1011A;
% Adding errorbars to plot
err_bar = errorbar(speeds, 1:3, -speeds_err, +speeds_err, '.', 'horizontal');
err_bar.Color = [0 0 0];                            
err_bar.LineStyle = 'none';
err_bar.LineWidth = 1.5;
% Labels:
xlabel('Elongation speed (\mum/min)');
text_labels = flip(["WT"; "P1021S"; "T1011A";]);
text([0.02, 0.02, 0.02], 1:3, text_labels,'VerticalAlignment','middle',"FontName","Arial","FontSize",18);
xlim([0 1.05]);
ylim([0.3 3.7]);
yticks([]);
saveas(gcf, 'elong speed point.png');
saveas(gcf, 'elong speed point.svg');

% Phospho mutants pre-anaphase spindle length: 
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units","centimeters", "Position",[0.5, 2, 12, 9], 'YTickLabels','');
set(gcf, "Units","centimeters", "Position",[8, 2, 13, 11.5])
box on;
hold on;
% Set the barh in orders
pre_anaphase_spl = flip([pre_anaphase_FL(1); pre_anaphase_9A(1); pre_anaphase_9D(1); ...
                    pre_anaphase_1030(1); pre_anaphase_1030_9A(1); pre_anaphase_1030_9D(1)]);
pre_anaphase_spl_err = flip([pre_anaphase_FL(3); pre_anaphase_9A(3); pre_anaphase_9D(3); ...
                    pre_anaphase_1030(3); pre_anaphase_1030_9A(3); pre_anaphase_1030_9D(3)]);
% The horizontal bar plot:
bar_plot = barh(pre_anaphase_spl);
bar_plot.FaceColor = 'flat';
bar_plot.CData(6,:) = cl_FL_SS;
bar_plot.CData(5,:) = cl_FL_9A;
bar_plot.CData(4,:) = cl_FL_9D;
bar_plot.CData(3,:) = cl_1030_SS;
bar_plot.CData(2,:) = cl_1030_9A;
bar_plot.CData(1,:) = cl_1030_9D;
% Plot the 1030TD again for hatches
bar_plot_1030 = barh(pre_anaphase_spl(1:3));
bar_plot_1030.FaceColor = 'flat';
bar_plot_1030.CData(3,:) = cl_1030_SS;
bar_plot_1030.CData(2,:) = cl_1030_9A;
bar_plot_1030.CData(1,:) = cl_1030_9D;
hatchfill(bar_plot_1030,'single','HatchAngle',45,'HatchColor','w','HatchLineWidth',1);
% Adding errorbars to plot
err_bar = errorbar(pre_anaphase_spl, 1:6, -pre_anaphase_spl_err, +pre_anaphase_spl_err, '.', 'horizontal');
err_bar.Color = [0 0 0];                            
err_bar.LineStyle = 'none';
err_bar.LineWidth = 1.5;
% Labels:
xlabel('Pre-anaphase spindle length (\mum)');
text_labels = flip(["FL"; "9A"; "9D"; "1030"; "1030-9A"; "1030-9D"]);
text([0.04, 0.04, 0.04, 0.05, 0.05, 0.05], 1:6, text_labels,'VerticalAlignment','middle',"FontName","Arial","FontSize",18);
xlim([0 3]);
ylim([0.3 6.7]);
xticks(0:0.5:3);
xtickangle(0);
yticks([]);
saveas(gcf, 'pre-anaphase phospho.png');
saveas(gcf, 'pre-anaphase phospho.svg');

% Point mutants pre-anaphase spindle length: 
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units","centimeters", "Position",[0.5, 2, 12, 9], 'YTickLabels','');
set(gcf, "Units","centimeters", "Position",[8, 14, 13, 11.5])
box on;
hold on;
% Set the barh in orders
pre_anaphase_spl = flip([pre_anaphase_FL(1); pre_anaphase_P1021S(1); pre_anaphase_T1011A(1)]);
pre_anaphase_spl_err = flip([pre_anaphase_FL(3); pre_anaphase_P1021S(3); pre_anaphase_P1021S(3)]);
% The horizontal bar plot:
bar_plot = barh(pre_anaphase_spl);
bar_plot.FaceColor = 'flat';
bar_plot.CData(3,:) = cl_FL_SS;
bar_plot.CData(2,:) = cl_P1021S;
bar_plot.CData(1,:) = cl_T1011A;
% Adding errorbars to plot
err_bar = errorbar(pre_anaphase_spl, 1:3, -pre_anaphase_spl_err, +pre_anaphase_spl_err, '.', 'horizontal');
err_bar.Color = [0 0 0];                            
err_bar.LineStyle = 'none';
err_bar.LineWidth = 1.5;
% Labels:
xlabel('Pre-anaphase spindle length (\mum)');
text_labels = flip(["WT"; "P1021S"; "T1011A";]);
text([0.05, 0.05, 0.05], 1:3, text_labels,'VerticalAlignment','middle',"FontName","Arial","FontSize",18);
xlim([0 3]);
ylim([0.3 3.7]);
xticks(0:0.5:3);
xtickangle(0);
yticks([]);
saveas(gcf, 'pre-anaphase point.png');
saveas(gcf, 'pre-anaphase point.svg');

