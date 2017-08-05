clear all;

%img = imread('cat.png');
%img = imread('mario.png');
%img = imread('peacock.jpg');
%img = imread('donkey.png');
%img = imread('bridged2.png');
img = imread('target.png');
img = rgb2gray(img);

steps = 3;

lambda_low = 380;
lambda_high = 780;
wavelengths = linspace(lambda_low, lambda_high, steps);
gamma = 0.8;
output_size = [size(img, 1) size(img, 2)];


scale_range = [lambda_high/lambda_low 1.0];
%hue_range = [0 1-1/steps];

i_max = numel(wavelengths);
% for i=1:i_max
%     hsv = rgb2hsv(lambda2rgb(wavelengths(i), gamma));
%     hue_range(i) = rgb2

%hue_range = [0 0.8];
border_shade = 1.0;
brightness = steps ^ -0.75;  % Seems to be a good ratio
%brightess = 1;
%brightness = 0.25;

%tint_color = [1.0 1.0 0.0];

% tint(img, tint_color);
% imshow(img_out);

% img_red   = tint(scale_dimkeep(img, 1.0, output_size, 0.0), [1.0 0.0 0.0]);
% img_green = tint(scale_dimkeep(img, 1.0, output_size, 0.0), [0.0 1.0 0.0]);
% img_blue  = tint(scale_dimkeep(img, 1.0, output_size, 0.0), [0.0 0.0 1.0]);

%img_res = scale_dimkeep(img, 1.0, output_size, 0.5);



% imshow(img_res);

% imshow(img_red + img_green + img_blue);


% scales = linspace(1.0, 1.2, steps);
% hues = linspace(0.0, 

%tester = rainbowify(img, scale_range, hue_range, steps, output_size, border_shade, brightness);
tester = rainbowify_lambdas(img, scale_range, wavelengths, steps, output_size, border_shade, brightness);

imshow(tester);