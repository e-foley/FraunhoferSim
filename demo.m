clear all;
%close all;

% create hexagonal mask with circular obstruction and write it to disc
hex_less_circle = form_polygon(1024, 0.5, 6, 0) - form_circle(1024, 0.2);
imwrite(hex_less_circle, 'hex_less_circle.png');
% create hexagonal mask with hexagonal obstruction and write it to disc
hex_less_hex = form_polygon(1024, 0.5, 6, 0) - form_polygon(1024, 0.2, 6, 0);
imwrite(hex_less_hex, 'hex_less_hex.png');

% listing a bunch of settings (see show_fft_plus file for documentation)
in_scale = 0.2;
fft_scale = 19;  % 19 gives a good amount of resolution in the FFT
LD = [0.0 0.0 1.0];  % [0 0 1] is default: a single star
mag_lims = [0.0 4.0];  % these are base-10 limits, not stellar magnitudes
ld_lim = 12;
nominal_plot_size = [640 528];  % gets multiplied by (25/16) for some reason
color_map = hot(256);  % 'parula', 'bone', 'hot' are best; 'pink' not bad
print_mode = false;

% load hex less cicle image file and process it
% mask = imread('hex_less_circle.png');
% show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, color_map, 1, 'hex less circle aperture', 'hex_less_circle');
% load hex less hex image file and process it
mask = imread('c11.png');
show_fft_plus(mask, in_scale, fft_scale, LD, mag_lims, ld_lim, nominal_plot_size, color_map, print_mode, 4, 'C11 aperture', 'c11');