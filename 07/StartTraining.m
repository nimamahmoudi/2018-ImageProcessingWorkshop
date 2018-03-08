%% Codes for AUT Image Processing Workshop 2018
% Lecture 7: Traingin Cascade Detectors in MATLAB
% 
% Taught by: Nima Mahmoudi -- nima_mahmoudi@aut.ac.ir, nmahmoud@ualberta.ca
% 
% This code is released under the GPLv3 license for non-commercial
% use only. For other types of license please contact me.

%% Some must-knows
% We must be aware of different outcomes of a detector:
% * True Positive
% * False Positive
% * True Negative
% * False Negative
% 
% <<traincascadeobjectdetector_overview.png>>
% 
% Keep in mind that you can train new detectors using Image Labeler App.
% 
% <<traincascadeobjectdetector_negativeimages.png>>
% 
% 

%% Initialize the Detector
% Load the positive samples data from a MAT file. The file contains a table 
% specifying bounding boxes for several object categories. The table was 
% exported from the Training Image Labeler app.

%%
% Load positive samples.
load('stopSignsAndCars.mat');
%%
% Select the bounding boxes for stop signs from the table.
positiveInstances = stopSignsAndCars(:,1:2);
%%
% Add the image directory to the MATLAB path.
imDir = fullfile(matlabroot,'toolbox','vision','visiondata',...
    'stopSignImages');
addpath(imDir);
%%
% Specify the foler for negative images.
negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata',...
    'nonStopSigns');
%%
% Create an |imageDatastore| object containing negative images.
negativeImages = imageDatastore(negativeFolder);
%%
% Train a cascade object detector called 'stopSignDetector.xml'
% using HOG features.
% NOTE: The command can take several minutes to run.
trainCascadeObjectDetector('stopSignDetector.xml',positiveInstances, ...
    negativeFolder,'FalseAlarmRate',0.1,'NumCascadeStages',5);
%%
% Use the newly trained classifier to detect a stop sign in an image.
detector = vision.CascadeObjectDetector('stopSignDetector.xml');
%%
% Read the test image.
img = imread('stopSignTest.jpg');
%%
% Detect a stop sign.
bbox = step(detector,img); 
%%
% Insert bounding box rectangles and return the marked image.
 detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'stop sign');
%%
% Display the detected stop sign.
figure; imshow(detectedImg);
%%
% Remove the image directory from the path.
rmpath(imDir); 