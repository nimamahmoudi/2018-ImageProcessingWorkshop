%% Codes for AUT-Multimedia 2016 Course
% Lecture 2: Introduction to Images Processing: Hand Detection Example
% 
% Taught by: Nima Mahmoudi
% 
% This code is released under the GPLv3 license for non-commercial
% use only. For other types of license please contact me.

%% initialization
% Here we initialize the webcam and its configuration (image size)

% get list of cameras
camList = webcamlist

% open camera
cam = webcam(1)
cam.Resolution = '640x480';

%% initiating detector

% Use the newly trained classifier to detect a hand in image
detector = vision.CascadeObjectDetector('handDetector(0.5 lbp no error 15).xml');

% Creating a video player object to show the Video
videoPlayer = vision.VideoPlayer;

%% processing the image

% Here we get the start time to set out a timeout for the application
startTime = tic;
while(toc(startTime) < 30)
    img = snapshot(cam);
    
    bbox = step(detector, img);
    % Insert bounding boxes and return marked image.
    detectedImg = insertObjectAnnotation(img, 'rectangle', bbox, 'Hand');
    
    step(videoPlayer,detectedImg);
end

%% closing camera
clear cam;