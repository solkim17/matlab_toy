%Clear GUI, figures, and workspace
clc
clear
close all

%Edit 'master_dir' to point to /matlab_toy
master_dir = '/Users/solkim/Documents/PhD/yr_2/2018_Fall/GEOG257/matlab_toy'
cd(master_dir)
addpath(genpath(master_dir)) %Adds sub-directories as well

%Check to make sure you are in the correct directory
dir_check = pwd;
dir_check = dir_check(end-10:end);
if ~isequal(dir_check,'/matlab_toy')
    error('Please edit the variable master_dir to point to /matlab_toy')
else
    disp('Directory set correctly')
end
%%

%Data file
data_file = which('DS421_survey_responses.xlsx') %Finds file within master directory
%Load numeric and text data from sheet 'FinalTable'
[num,txt] = xlsread(data_file,'Cleaned_wComments');
%Clean text data
criteria = txt(1,2:end)'

%Make box-whisker plot for each criteria with survey data averages per paper
fig_1 = figure;
boxplot(num,criteria)
plot_axes = gca;
plot_axes.XTickLabelRotation = 45


%Make matrix of scatter plots
fig_2 = figure;
subplot_ind = 0;
for i = 1:10
    for j = 1:10
        subplot_ind = subplot_ind + 1;
        subplot(10,10,subplot_ind);
        x = num(:,i);
        y = num(:,j);
        scatter(x,y,'.');
        axis([1 5 1 5]);
        hold on
        y2 = linear_reg(x,y);
        plot(y2,x);
    end
end

function y2 = linear_reg(x,y)

%Linear regression
%Least-squares
%
%y = mx + b
%
%Using provided x and y values, calculate m and b
%Return y2 which is x fit to y=mx + b

%Check sizes
if ~isequal(size(x),size(y))
    error('Size of x and y do not match')
end

x_sum = sum(x);
y_sum = sum(y);
xy_sum = sum(x.*y);
x_sq_sum = sum(x.^2);
n = max(size(x));

m = ((n*xy_sum)-(x_sum*y_sum))/((n*x_sq_sum)-(x_sum*x_sum));
b = ((x_sq_sum*y_sum)-(x_sum*xy_sum))/((n*x_sq_sum)-(x_sum*x_sum));

y2 = m.*x+b;
end