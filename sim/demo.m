clear all;
%close all;

% % create hexagonal mask with circular obstruction and write it to disc
% hex_less_circle = form_polygon(1024, 0.5, 6, 0) - form_circle(1024, 0.2);
% imwrite(hex_less_circle, 'hex_less_circle.png');
% % create hexagonal mask with hexagonal obstruction and write it to disc
% hex_less_hex = form_polygon(1024, 0.5, 6, 0) - form_polygon(1024, 0.2, 6, 0);
% imwrite(hex_less_hex, 'hex_less_hex.png');

% listing a bunch of settings (see show_fft_plus file for documentation)
file = 'bowtie.png';
comp = 'gaussian-15.png';
aperture_name = 'hexagon donut';
output_name = 'hexagon donut with spokes';
in_scale = 0.25;  % most rendered at 0.2
fft_scale = 19;  % 19 gives a good amount of resolution in the FFT
LD = [0.0 0.0 1.0];  % [0 0 1] is default: a single star
mag_lims = [0.0 4.0];  % these are base-10 limits, not stellar magnitudes
ld_lim = 12;
nominal_plot_size = [640 528];  % gets multiplied by (25/16) for some reason
color_map = hot(256);  % 'parula', 'bone', 'hot' are best; 'pink' not bad
print_mode = false;
%comp_lim_mag = 4;
%comp_lims = [-comp_lim_mag, comp_lim_mag];
comp_lims = [-2, 2];

% Contrast color bar creation
% r = [0.0 0.0 1.0 1.0];
% g = [0.5 0.0 1.0 0.5];
% b = [1.0 0.0 1.0 0.0];
% r = [0.0 0.0 0.5 1.0];
% g = [0.0 0.0 0.25 1.0];
% b = [0.0 0.5 0.0 1.0];
% r = [0.0 0.4 0.6 1.0];
% g = [0.0 0.4 0.6 1.0];
% b = [0.0 0.4 0.6 1.0];
% r = [0.0 0.3 0.5 1.0];
% g = [0.0 0.3 0.3 1.0];
% b = [0.0 0.5 0.3 1.0];
r = [0.0 0.5 0.5 1.0];
g = [0.0 0.5 0.5 1.0];
b = [0.0 0.5 0.5 1.0];
% r = [0.0 0.0 0.5 1.0];
% g = [0.0 0.0 0.5 1.0];
% b = [1.0 0.0 0.5 1.0];
split = 256 * (-comp_lims(1) / (comp_lims(2) - comp_lims(1)));

split = round(split);
rscale = [linspace(r(1), r(2), split) linspace(r(3), r(4), 256-split)];
gscale = [linspace(g(1), g(2), split) linspace(g(3), g(4), 256-split)];
bscale = [linspace(b(1), b(2), split) linspace(b(3), b(4), 256-split)];
colortest = [rscale;  gscale; bscale]';

% load hex less cicle image file and process it
% mask = imread('hex_less_circle.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, color_map, 1, 'hex less circle aperture', 'hex_less_circle');
% load hex less hex image file and process it
%figure_num = 4;
first = show_fft_plus(imread(file), in_scale, fft_scale, LD, mag_lims, ld_lim, nominal_plot_size, color_map, print_mode, 1, aperture_name, output_name);

%figure_num = figure_num + 3;
% second = show_fft_plus(imread(comp), in_scale, fft_scale, LD, mag_lims, ld_lim, nominal_plot_size, color_map, print_mode, 0, aperture_name, output_name);
% diff = plot_combined(first, second, true, fft_scale, comp_lims, ld_lim, nominal_plot_size, colortest, 1, 'DO I DO?', 'bleh.png');