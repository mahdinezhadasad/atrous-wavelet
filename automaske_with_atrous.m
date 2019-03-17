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
            
 
                %% load the data
                %data = imread(fullFileName);
               
                
                %% main

format short g;
format compact;
fontSize = 25;
%===============================================================================

I =  imread(fullFileName);
ref = imread('C:\Users\hi\Desktop\22.jpg');
%montage({I,ref})
grayImage = imhistmatch(I,ref);

  
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
% 
subplot(1, 2, 1);
imshow(grayImage,[]);

% Threshold the image.
binaryImage1 = grayImage < 60;
% Extract the largest blob.
binaryImage1 = bwareafilt(binaryImage1, 1);
% Fill any holes.
binaryImage1 = imfill(binaryImage1, 'holes');
% Display the image.

% Burn line into image by setting it to 255 wherever the mask is true.
burnedImage = grayImage;
burnedImage(binaryImage1) = 0;
% Display the image with the mask "burned in."
subplot(1, 2, 2);
imshow(burnedImage);

%% ----------------------------------------------
% atrous
            data = double(grayImage);

            filter=[1  4 6   4  1 ; 
                  4 16 24 16  4 ;
                  6 24 36 24  6 ;
                  4 16 24 16  4 ;
                  1  4 6   4  1 ]/256;

            level = 2;
            [ Residual,D ] = a_trous_dwt2( data,level,filter );

            P1 = D(:,:,1);
            P2 = D(:,:,2);

%             figure; imshow(P2); 

                %% cizdir ve kaydet
%                 figure;
%                 imshow( burnedImage);
%                 figurename = strcat([thisFolder,'\',name, '_cropped'],'.jpg');
%                 export_fig(figurename, '-jpg');
                
                path = 'C:\Users\hi\Desktop\thesis\datalar\8male'
                savetopath = strcat([path,'\',name, '_atrousyeni'],'.jpg')
                imwrite(P2, savetopath );
                
                close all
		end
	else
		fprintf('     Folder %s has no text files in it.\n', thisFolder);
	end
end