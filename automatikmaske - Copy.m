clc
clear all
%%
userpathstr = regexprep(userpath,';','');
pathstring = fullfile(userpathstr,'\exportfig\');
addpath(pathstring);

%export_fig filename.png -q1001 -transparent
%% DESCRIPTION

% spiralleri x ve y ;elinde ayirark square matrikse cevirip cizdirme
%%
% Define a starting folder wherever you want
start_path = fullfile('C:\');
% Ask user to confirm or change.
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
	return;
end
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)

% Process all text files in those folders.
for k = 1 : numberOfFolders
	% Get this folder and print it out.
	thisFolder = listOfFolderNames{k};
	fprintf('Processing folder %s\n', thisFolder);
	
	% Get filenames of all TXT files.
	filePattern = sprintf('%s/*.jpg', thisFolder);
	baseFileNames = dir(filePattern);
	numberOfFiles = length(baseFileNames);
	% Now we have a list of all text files in this folder.
	
	if numberOfFiles >= 1
		% Go through all those text files.
		for f = 1 : numberOfFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
			fprintf('     Processing jpeg file %s\n', fullFileName);
         
            [filepath,name,ext] = fileparts(fullFileName);
        end
            
 
                %% load the data
                data = imread(fullFileName);
               
                
                %% main

  % Close all figures (except those of imtool.)
% Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format short g;
format compact;
fontSize = 25;
%===============================================================================
% Read in a standard MATLAB gray scale demo image.
folder = pwd;
%baseFileName = 'C:\Users\okosis\Documents\MATLAB\mehdi\2.jpg';


I =  imread(fullFileName);
ref = imread('C:\Users\hi\Desktop\22.jpg');
%montage({I,ref})
baseFileName = imhistmatch(I,ref);
figure;
imshow(I, []);
figure;
imshow(baseFileName, []);

% Get the full filename, with path prepended.
fullFileName = (baseFileName);

grayImage = (fullFileName);

% Get the dimensions of the image.  
% numberOfColorChannels should be = 1 for a gray scale image, and 3 for an RGB color image.
[rows, columns, numberOfColorChannels] = size(grayImage);
if numberOfColorChannels > 1
	% It's not really gray scale like we expected - it's color.
	% Use weighted sum of ALL channels to create a gray scale image.
	grayImage = rgb2gray(grayImage); 
	% ALTERNATE METHOD: Convert it to gray scale by taking only the green channel,
	% which in a typical snapshot will be the least noisy channel.
	% grayImage = grayImage(:, :, 2); % Take green channel.
end
% n = 2;  
% Idouble = im2double(grayImage); 
% avg = mean2(Idouble);
% sigma = std2(Idouble);
% J = imadjust(grayImage,[0.1, 0.7],[]);
%grayImage1=imadjust(grayImage,[0.01 0.02],[]);
% Display the image.
subplot(2, 3, 1);
imshow(grayImage, []);
imshow(grayImage,[]);
title('Original Grayscale Image', 'FontSize', fontSize, 'Interpreter', 'None');
%------------------------------------------------------------------------------
% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off') 
% Plot the histogram.
subplot(2, 3, 2);
histogram(grayImage);
grid on;
title('Histogram of original image', 'FontSize', fontSize, 'Interpreter', 'None');
% Threshold the image.
binaryImage1 =grayImage <40;
% Extract the largest blob.
binaryImage1 = bwareafilt(binaryImage1, 1);
% Fill any holes.
binaryImage1 = imfill(binaryImage1, 'holes');
% Display the image.
subplot(2, 3, 3);
imshow(binaryImage1, []);
axis on;
caption = sprintf('Binary Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
hp = impixelinfo();
drawnow;


% Calculate the area, in pixels, that they drew.
numberOfPixels1 = sum(binaryImage1(:))
% Another way to calculate it that takes fractional pixels into account.
numberOfPixels2 = bwarea(binaryImage1)
% Get coordinates of the boundary of the freehand drawn region.
structBoundaries = bwboundaries(binaryImage1);
xy=structBoundaries{1}; % Get n by 2 array of x,y coordinates.
x = xy(:, 2); % Columns.
y = xy(:, 1); % Rows.
subplot(2, 3, 1); % Plot over original image.
hold on; % Don't blow away the image.
plot(x, y, 'LineWidth', 2);
drawnow; % Force it to draw immediately.
% Burn line into image by setting it to 255 wherever the mask is true.
burnedImage = grayImage;
burnedImage(binaryImage1) = 0;
I=burnedImage;
% Display the image with the mask "burned in."
subplot(2, 3, 4);
imshow(I);

                
                
%                 [a , b]= size(data);
% 
%                 I = imcrop(data,[0.1*b (a-0.7*a) (b-b*0.2) (a)]);


                %% cizdir ve kaydet
                figure;
                imshow( I);
                figurename = strcat([thisFolder,'\',name, '_cropped'],'.jpg');
                export_fig(figurename, '-jpg');
                
                close all
		end
	else
		fprintf('     Folder %s has no text files in it.\n', thisFolder);
	end
end