%% Codes for AUT-Multimedia 2016 Course
% Lecture 3: Designing Filters for Audio Signals
% 
% Taught by: Nima Mahmoudi -- nima_mahmoudi@aut.ac.ir
% 
% This code is released under the GPLv3 license for non-commercial
% use only. For other types of license please contact me.

%% State list of images
% Some of the images stated here are not in the folder.
% MATLAB has a lot of test images prebuilt into it. you could use any of
% them without stating the exact location, it is already in it's path.
ims={'lena.bmp','cameraman.tif','circuit.tif','tire.tif','coins.png','moon.tif'};

% while(1)
    %% Listing and Getting the Image Selection
    
    % get a clear screen
    clc
    % you could use sprintf like this, it is a great tool, just like it was
    % when we used C++.
    text = sprintf('Enter your choice:\n\n0) Quit\n\n');
    
    % List all the images specified with their number and name.
    % Attention: Read About MATLAB Cell arrays!
    for i=1:length(ims)
        tmp = sprintf('%d) %s\n',i,ims{i});
        text = [text tmp];
    end
    
    % disp shows a test you give it and adds a new line in the end.
    disp(text);
    
    % input will ask a question and give you the answer as the result.
    inp = input('what is your selection?');
%     inp = 1;
    
    %% The Main Image Processing
    
    % wanted to know how to use a swtich - case? here's how...
    switch inp
        case 0
            close all;
            clear all;
            clc;
%             break;
        otherwise
            % reading the image, again!
            im = imread(ims{inp});
            
            % Showing the original image
            figure(1);
            subplot(2, 2, 1);
            imshow(im);
            title('original');
            
            
            % Perform the averaging filter to the image
            h = fspecial('average', 11);
            im_out1 = imfilter(im,h,'replicate');
            figure(1)
            subplot(2, 2, 2);
            imshow(im_out1);
            title('Average');
            
            % Sobel Edge Detector! read msobel funtion for more detail.
            im_out2 = msobel(im);
            figure(1)
            subplot(2, 2, 3);
            imshow(im_out2);
            title('Sobel');
            
            % Prewitt Edge Detector, perform the filter and threshold to
            % get edges.
            h = fspecial('prewitt');
            Px = double(imfilter(im,h,'replicate'));
            h = h';
            Py = double(imfilter(im,h,'replicate'));
            P = sqrt(Px .^ 2 + Py .^ 2);
            im_out3 = P > 100;
            figure(1)
            subplot(2, 2, 4);
            imshow(im_out3);
            title('Prewitt');
    end
% end

