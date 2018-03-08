function [ im_out ] = msobel( im, thresh )
%MSOBEL is a function for performing SOBEL edge detection
% im is the uint8 image provided for edge detection. 
% and thresh is the threshold used for defining edges

%% initializing
% we need to initialize the inputs if none is provided. 
% lena image and threshold = 10 are considered as default inputs.
if nargin<1
    im = imread('lena.bmp');
end

if nargin<2
    thresh = 100;
end

%% Filters
% The following filters are X and Y sobel kernels. 
% They provide horizontal and vertical derivation approximation.

hx=[...
    1 0 -1;...
    2 0 -2;...
    1 0 -1];

hy=[...
    1 2 1;...
    0 0 0;...
    -1 -2 -1];

% sx = double(mfilter2(im,hx,1));
% sy = double(mfilter2(im,hy,2));

sx = double(imfilter(im,hx,'replicate'));
sy = double(imfilter(im,hy,'replicate'));

%% Thresholding
% The output should be binary as Edge, or not Edge. 
% 
% We do this using the threshold provided above.
% 
% We evaluate pixels by comparing the following value with thresh:
%
% $G=\sqrt{G_x^2+G_y^2}$
%
% for more information go to
% <http://en.wikipedia.org/wiki/Sobel_operator SobelOperator> 

s = sqrt(sx.^2+sy.^2);
im_out = s>thresh;

% figure(3);
% subplot(1,2,1);
% imshow(im);
% title('Original');
% subplot(1,2,2);
% imshow(im_out);
% title('Edges');
end

