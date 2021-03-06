%% Clear Command Window & Clear Workspace
clc;

%% Welcome Message Box
uiwait(msgbox({'Welcome to Glucolynx v1.0';'Your Blood Glucose Level Monitoring App';'Press OK to choose your file(*.csv)'},'Glucolynx v1.0', 'help'));

%% Browse file method
[filename, pathname]=uigetfile({'*.csv'}, 'Select your NIR Blood Glucose Data File');
fullLocation = strcat(pathname,filename);
fprintf('%s\n', fullLocation);
assignin('base', 'filename', filename);

%% Get file and transpose the data
xTestPerson = xlsread(fullLocation, 'B23:B250');
xTestPerson = xTestPerson.'; 
xTP_Intensity = xlsread(fullLocation, 'D23:D250');
xTP_Intensity = xTP_Intensity.';

%% Load Pre-trained Model
load('pretrainedModel.mat');

%% Plot Blood Glucose NIR (Absorbance)
figure(1);
plot(wavelength,xTestPerson,'r');
title('Your NIR Blood Glucose (Ab)');
xlabel('wavelengths(nm)');
ylabel('Absorbance(Ab)');

% Figure 1 Positioning
pos1 = get(gcf,'Position'); % get position of Figure(1) 
set(gcf,'Position', pos1 - [pos1(3)/2,0,0,0]) % Shift position of Figure(1) 

%% Plot Blood Glucose NIR (Intensity)
figure(2)
plot(wavelength,xTP_Intensity, 'color', [0.3010 0.7450 0.9330]);
title('Your NIR Blood Glucose (I)');
xlabel('wavelengths(nm)');
ylabel('Intensity(I)');

% Figure 2 Positioning
set(gcf,'Position', get(gcf,'Position') + [0,0,150,0]); % When Figure(2) is not the same size as Figure(1)
pos2 = get(gcf,'Position');  % get position of Figure(2) 
set(gcf,'Position', pos2 + [pos1(3)/2,0,0,0]) % Shift position of Figure(2)

%% Predict BG Level from the data input
predModel2 = plspredict(xTestPerson,oneModel,2);
predBGLevel = predModel2.Ypred(:,:,2);
assignin('base', 'predBGLevel', predBGLevel);

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