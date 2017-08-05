clear all;

%img = imread('dice.png');
%img = imread('cat.png');
%img = imread('mario.png');  % use center [0.27 0.415]
%img = imread('peacock.jpg');
%img = imread('donkey.png');
%img = imread('bridged3.png');
img = imread('target.png');
%img = imread('statue.jpg');  % center [0.42 0.35]
%img = imread('piano.jpeg');
%img = imread('citysmall.png');
%img = imread('city2.jpg');  % center [0.3 0.28]
%img = imread('bowtie simple psf.png');
%img = imread('bridged3.png');

mono = false;
autocrop = false;  % crops image to dimensions of smallest "slice" of spectrum (best used when centered on [0.5 0.5])
steps = 200;
lambda_low = 380;  % 380 to 670 range gives whites a little yellowy, but not bad
lambda_high = 660;  % up to 640 improves whites but makes image look green
gamma = 0.8;  % 0.8 is default
border_shade = 0.0;
scale_factor = 1;
center = [0.0 0.0];
brightness_cut = -0.8;  % larger -> brighter

scales = linspace(1.0 / (1.0 + scale_factor*(lambda_high/lambda_low - 1.0)), 1.0, steps);  % scale factor implementation may not be correct...
%scales = linspace(1.0, 1.0 + scale_factor*(lambda_high/lambda_low - 1.0), steps);
output_size = [size(img, 1) size(img, 2)];
if autocrop
    output_size = floor(min(scales) * output_size);
end
wavelengths = linspace(lambda_low, lambda_high, steps);
brightnesses = (steps ^ brightness_cut) .* ones(1, steps);

if mono
    img = rgb2gray(img);
end

tester = rainbowifyLambdas(img, scales, wavelengths, brightnesses, gamma, border_shade, output_size, center);
imshow(tester);
