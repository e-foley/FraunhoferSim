clear all;
%close all;
%map_type = 'hot';  % parula, bone, hot are best; pink not bad
in_scale = 0.25;
fft_scale = 4;
mag_scale = 4;
ld_max = 64;

% mask = imread('bowtie.png');
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Bowtie mask', 'bowtie mask');
% 
% mask = imread('mask1.png');
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Double Gaussian mask', 'double Gaussian mask');
% 
mask = imread('items/gaussian-15.png');
R = show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 'hot', 1, 'iht', 'iht');
G = show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 'hot', 1, 'iht', 'iht');
%R = show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 'hot', 1, 'iht', 'iht');

%R = (log10(R/max(max(R))));
%G = (log10(G/max(max(G))));

R = 1 / (max(max(R)) - min(min(R))) .* R - min(min(R));
G = 1 / (max(max(G)) - min(min(G))) .* G - min(min(G));
combo = cat(3, R .^ 0.25, G .^ 0.25, G .^ 0.20);

imshow(combo, [0 1]);

%img = cat(3, R, G, zeros(size(R,1)));
%imshow(img);
%mask = [form_circle(250, 0.25) form_circle(250, 0.25); form_circle(250, 0) form_circle(250, 0)];
%mask(500, 500) = 1;

% mask = form_circle(500, 0.5);
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Circular aperture', 'circular aperture');

% mask = form_gaussian(500, 1, 0.15);
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Gaussian mask', 'Gaussian mask');