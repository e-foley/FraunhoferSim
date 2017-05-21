clear all;
%close all;
%map_type = 'hot';  % parula, bone, hot are best; pink not bad
in_scale = 0.20;
fft_scale = 18;  % should be able to do 0.20 and 20
mag_lims = [1.0 4.0];  % these are base-10 limits
ld_lim = 12;

%LD = [0.0 0.0 1.0; 7.0 0.0 0.25];
LD = [0.0 0.0 1.0];  % default--a single star

% http://www.skyandtelescope.com/observing/pretty-double-stars-for-everyone/
%LD = double_to_LD(1.0, [5.5 5.9], 90, 700, 11); % 36 And, P.A. 315
%LD = double_to_LD(9.1, [0.1 6.8], 270, 700, 11);  % Rigel, P.A. 203
%LD_gauss = double_to_LD(3.4, [0.0 10.0], 90, 700, 11);  % contrived to show off Gaussian relative to circular (use mag lims [0 5.0])
LD_gauss = double_to_LD(4.0, [0.0 8.0], 90, 700, 11);  % better attempt at above
%LD = double_to_LD(0.83, [0.0 4.0], 92, 700, 11);  % attempt to show off bowtie relative to circular (use mag lims [0 3.0]) 
% LD = [0.0 0.0 LD(1, 3);
%       1.5 0.0 LD(2, 3)];

% mask = imread('full.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 1, 'circular aperture', 'full');
% mask = imread('inner.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 1, 'small circular aperture', 'inner');
% mask = imread('C11.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 1, 'C11 aperture', 'C11');
% mask = imread('multigaussian-15.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 1, 'multi-Gaussian aperture', 'multigaussian-15');
% mask = imread('multigaussian-18.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 1, 'multi-Gaussian aperture', 'multigaussian-18');
% mask = imread('multigaussian-15.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim + 4, 'hot', 1, 'multi-Gaussian aperture', 'multigaussian-15_wider');
% mask = imread('multigaussian-18.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim + 4, 'hot', 1, 'multi-Gaussian aperture', 'multigaussian-18_wider');

% mask = imread('C11_gaussian-15.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 1, 'Gaussian aperture on C11', 'C11_gaussian-15');

mask = imread('gaussian-18_donut.png');
show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 4, 'Gaussian donut aperture', 'gaussian-18_donut');

% GAUSSIAN APERTURE DEMO (TWO BELOW)
% mask = imread('C11.png');
% show_fft_plus(mask, in_scale, fft_scale, LD_gauss, [1.0 4.0], ld_lim, 'hot', 1, 'Gaussian donut aperture', 'gaussian_demo/C11');
% mask = imread('gaussian-18_donut.png');
% show_fft_plus(mask, in_scale, fft_scale, LD_gauss, [1.0 4.0], ld_lim, 'hot', 4, 'Gaussian donut aperture', 'gaussian_demo/gaussian-18_donut');

% mask = imread('circle.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 1, 'circular aperture', 'circular aperture');
% mask = imread('donut.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 1, 'C11 aperture', 'C11 aperture');
% mask = imread('bowtie.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, 'hot', 4, 'bowtie mask', 'bowtie mask');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\gaussian-15.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 4, 'Gaussian mask', 'Gaussian mask');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\multigaussian-15.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 7, 'multi-Gaussian mask', 'multi-Gaussian mask');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\gaussian-18_donut.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 7, 'Gaussian donut mask 2', 'Gaussian donut mask 2');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\fun_donut 2.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 7, 'fun donut mask', 'fun donut mask');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\C11_gaussian-15.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 7, 'C11 Gaussian mask', 'C11 Gaussian mask');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\cont-bridge.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 4, 'cont donut', 'cont donut');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\fun_donut B.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 7, 'donut B mask-deep', 'donut B mask-deep');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\cont-bridge test.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 4, 'cont donut test', 'cont donut test');
% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\curious.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 4, 'curious', 'curious');

% mask = imread('C:\Users\melab2\Desktop\MASTER MASK IMAGES\square.png');
% show_fft_plus(mask, in_scale, fft_scale, LD,  mag_lims, ld_lim, 'hot', 7, 'square', 'square');

%testing = getfield(load('bowtie mask raw PSF.mat'), 'xfm');

% mask = imread('triangle.png');
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 'hot', 4, 'Triangular mask', 'triangular mask');
 
% mask = imread('bowtie.png');
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Bowtie mask', 'bowtie mask');
% 
% mask = imread('mask1.png');
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Double Gaussian mask', 'double Gaussian mask');
% 
% mask = form_circle(1000, 0.5);
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Unaltered C11 aperture', 'unaltered C11 aperture');

%mask = [form_circle(250, 0.25) form_circle(250, 0.25); form_circle(250, 0) form_circle(250, 0)];
%mask(500, 500) = 1;

% mask = form_circle(500, 0.5);
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Circular aperture', 'circular aperture');

% mask = form_gaussian(500, 1, 0.15);
% show_fft_plus(mask, in_scale, fft_scale, mag_scale, ld_max, 1, 'Gaussian mask', 'Gaussian mask');