%% Clear Command Window & Clear Workspace
clc;
clear;

%% Welcome Message Box
uiwait(msgbox({'Welcome to Glucolynx v1.0';'Your Blood Glucose Level Monitoring App';'Press OK to choose your file(*.csv)'},'Glucolynx v1.0', 'help'));

%% Browse file method
[filename, pathname]=uigetfile({'*.csv'}, 'Select your NIR Blood Glucose Data File');
fullLocation = strcat(pathname,filename);
fprintf('%s\n', fullLocation);

%% Get file and transpose the data
xTestPerson = xlsread(fullLocation, 'B23:B250');
xTestPerson = xTestPerson.'; 

%% Load Pre-trained Model
load('pretrainedModel.mat');

%% Plot Blood Glucose NIR
plot(wavelength,xTestPerson);
title('Your NIR Blood Glucose');
xlabel('wavelengths(nm)');
ylabel('Absorbance(Ab)');

%% Predict BG Level from the data input
predModel2 = plspredict(xTestPerson,oneModel,2);
predBGLevel = predModel2.Ypred(:,:,2);

resultMsg = sprintf('Your predicted BG level: %.4f mmol/L\n', predBGLevel);
fprintf(resultMsg);

uiwait(msgbox(resultMsg,'Glucolynx v1.0', 'help'));
%% TEMP CODE

% A=i(21:248,2);
% importedCSV = importdata(fullLocation);
% i=importedCSV.data;
% data = readtable(fullLocation);

% [YourImage, ~, ImageAlpha] = imread('favicon.png');
% s=image(YourImage, 'AlphaData', ImageAlpha);

% ToCrop  = imread('favicon.png','Background', [1 1 1]);
% imshow(ToCrop);

% [A,map] = imread('favicon.png');
% A = imread('favicon.png');
% imshow(A);

% Run .m file
% run('./cal.m');