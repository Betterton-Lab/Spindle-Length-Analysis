%% plot the lvt curves for all strains:

% Strain name and dataset path: 
mutant_name = ["FL", "FL-9A", "FL-9D", "1030", "1030-9A", "1030-9D", "P1021S", "T1011A"];
mutant_type = ["cut7_phospho\FL\SS", "cut7_phospho\FL\9A", "cut7_phospho\FL\9D",...
    "cut7_phospho\1030TD\SS", "cut7_phospho\1030TD\9A", "cut7_phospho\1030TD\9D", "cut7_P1021S", "cut7_T1011A"];
lvt_dir_path = "C:\Research\Projects\Current Biology Paper\Software\BatchLVT\saved data\" + mutant_type + "\";
TVA_path = lvt_dir_path + mutant_name + "_TVA.mat";
err_path = lvt_dir_path + mutant_name + "_err.mat";
lag_path = lvt_dir_path + mutant_name + "_lag_time_info.mat";

load(TVA_path(1));
load(err_path(1));
load(lag_path(1));
TVA_FL_SS = tva_matrix;
err_FL_SS = shadow_region;
lag_FL_SS = lag_time_info;

load(TVA_path(2));
load(err_path(2));
load(lag_path(2));
TVA_FL_9A = tva_matrix;
err_FL_9A = shadow_region;
lag_FL_9A = lag_time_info;

load(TVA_path(3));
load(err_path(3));
load(lag_path(3));
TVA_FL_9D = tva_matrix;
err_FL_9D = shadow_region;
lag_FL_9D = lag_time_info;

load(TVA_path(4));
load(err_path(4));
load(lag_path(4));
TVA_1030_SS = tva_matrix;
err_1030_SS = shadow_region;
lag_1030_SS = lag_time_info;

load(TVA_path(5));
load(err_path(5));
load(lag_path(5));
TVA_1030_9A = tva_matrix;
err_1030_9A = shadow_region;
lag_1030_9A = lag_time_info;

load(TVA_path(6));
load(err_path(6));
load(lag_path(6));
TVA_1030_9D = tva_matrix;
err_1030_9D = shadow_region;
lag_1030_9D = lag_time_info;

load(TVA_path(7));
load(err_path(7));
load(lag_path(7));
TVA_P1021S = tva_matrix;
err_P1021S = shadow_region;
lag_P1021S = lag_time_info;

load(TVA_path(8));
load(err_path(8));
load(lag_path(8));
TVA_T1011A = tva_matrix;
err_T1011A = shadow_region;
lag_T1011A = lag_time_info;

%% Colors:
cl_FL_SS = [0.6, 0.1, 0.2];
cl_FL_9A = [0.1, 0.3, 0.7];
cl_FL_9D = [0.85, 0.5, 0];
cl_1030_SS = [1, 0.5, 0.6];
cl_1030_9A = [0.5, 0.75, 1];
cl_1030_9D = [0.9, 0.7, 0.3];
cl_P1021S = [0.6, 0.1, 0.9];
cl_T1011A = [0.1, 0.8, 0.6];


% All phospho mutant curves: 
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position", [2, 2, 12, 9]);
set(gcf, "Units", "centimeters", "Position", [8, 8, 14.5, 11.5])
box on;
hold on;
plot(TVA_FL_SS(:,1),TVA_FL_SS(:,2),"-",color=cl_FL_SS,LineWidth=2);
fill(err_FL_SS(:,1),err_FL_SS(:,2),cl_FL_SS,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(TVA_FL_9A(:,1),TVA_FL_9A(:,2),"-",color=cl_FL_9A,LineWidth=2);
fill(err_FL_9A(:,1),err_FL_9A(:,2),cl_FL_9A,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(TVA_FL_9D(:,1),TVA_FL_9D(:,2),"-",color=cl_FL_9D,LineWidth=2);
fill(err_FL_9D(:,1),err_FL_9D(:,2),cl_FL_9D,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(TVA_1030_SS(:,1),TVA_1030_SS(:,2),"-.",color=cl_1030_SS,LineWidth=2);
fill(err_1030_SS(:,1),err_1030_SS(:,2),cl_1030_SS,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(TVA_1030_9A(:,1),TVA_1030_9A(:,2),"-.",color=cl_1030_9A,LineWidth=2);
fill(err_1030_9A(:,1),err_1030_9A(:,2),cl_1030_9A,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(TVA_1030_9D(:,1),TVA_1030_9D(:,2),"-.",color=cl_1030_9D,LineWidth=2);
fill(err_1030_9D(:,1),err_1030_9D(:,2),cl_1030_9D,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(zeros(12,1), 0:1:11, 'k--');
% Plot the steady state growth onset marker: 
plot(lag_FL_SS(1,2),lag_FL_SS(1,4),"|",color=cl_FL_SS, LineWidth=2, MarkerSize=12);
plot(lag_FL_9A(1,2),lag_FL_9A(1,4),"|",color=cl_FL_9A, LineWidth=2, MarkerSize=12);
plot(lag_FL_9D(1,2),lag_FL_9D(1,4),"|",color=cl_FL_9D, LineWidth=2, MarkerSize=12);
plot(lag_1030_SS(1,2),lag_1030_SS(1,4),"|",color=cl_1030_SS, LineWidth=2, MarkerSize=12);
plot(lag_1030_9A(1,2),lag_1030_9A(1,4),"|",color=cl_1030_9A, LineWidth=2, MarkerSize=12);
plot(lag_1030_9D(1,2),lag_1030_9D(1,4),"|",color=cl_1030_9D, LineWidth=2, MarkerSize=12);
xlabel('Time (minutes)');
ylabel('Spindle length (\mum)');
xlim([-4.5, 9.5]);
ylim([0, 11]);
legend("FL","9A","9D","1030","1030-9A","1030-9D","Anaphase onset",Location="northwest");
legend box off;
saveas(gcf, 'phos_mutants_lvt.png');
saveas(gcf, 'phos_mutants_lvt.svg');

% Point mutant curves vs. WT: 
figure;
set(gca, "FontName","Arial", "FontSize",18, "Units", "centimeters", "Position", [2, 2, 12, 9]);
set(gcf, "Units", "centimeters", "Position", [24, 8, 14.5, 11.5])
box on;
hold on;
plot(TVA_FL_SS(:,1),TVA_FL_SS(:,2),"-",color=cl_FL_SS,LineWidth=2);
fill(err_FL_SS(:,1),err_FL_SS(:,2),cl_FL_SS,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(TVA_P1021S(:,1),TVA_P1021S(:,2),"-",color=cl_P1021S,LineWidth=2);
fill(err_P1021S(:,1),err_P1021S(:,2),cl_P1021S,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(TVA_T1011A(:,1),TVA_T1011A(:,2),"-",color=cl_T1011A,LineWidth=2);
fill(err_T1011A(:,1),err_T1011A(:,2),cl_T1011A,'FaceAlpha',0.5,'EdgeColor','None','HandleVisibility','off');
plot(zeros(12,1), 0:1:11, 'k--');
% Plot the steady state growth onset marker: 
plot(lag_FL_SS(1,2),lag_FL_SS(1,4),"|",color=cl_FL_SS, LineWidth=2, MarkerSize=12);
plot(lag_P1021S(1,2),lag_P1021S(1,4),"|",color=cl_P1021S, LineWidth=2, MarkerSize=12);
plot(lag_T1011A(1,2),lag_T1011A(1,4),"|",color=cl_T1011A, LineWidth=2, MarkerSize=12);
xlabel('Time (minutes)');
ylabel('Spindle length (\mum)');
xlim([-4.5, 9.5]);
ylim([0, 11]);
legend("WT","P1021S","T1011A","Anaphase onset",Location="northwest");
legend box off;
saveas(gcf, 'point_mutant_lvt.png');
saveas(gcf, 'point_mutant_lvt.svg');

