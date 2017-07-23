% Runner file.  Creates power-spectrum-related figures from existing
% aperture shape files.

% Define standard PSF-generation properties
psf_props = PsfProps;
psf_props.input_scale = 0.25;
psf_props.fft_scale = 10;
psf_props.ld_conv = [0 0 1];

[xfm, ~, ~] = get_clever_power_spectrum(imread('c11.png'), psf_props);

%TODO: Define other functions with parameters and loop through everything
%we need using clever arrays.  I'm actually looking forward to this...

% % Define standard properties that will be used unless otherwise specified.
% default_props = diffprops;  % Struct defined in diffprops.m
% default_props.cut_vert_lims = [-8 0];
% default_props.font_size_const = 14;  % font size to use on plots
% default_props.ld_lim = 12;
% default_props.in_scale = 1.0;
% default_props.fft_scale = 5;
% default_props.mag_lims = [1.0 4.0];  % these are base-10 limits, not stellar magnitudes
% default_props.ld_u_axis_tick_spacing = 2;  % u-axis tick spacing and tick label spacing
% default_props.ld_v_axis_tick_spacing = 2;  % v-axis tick spacing and tick label spacing
% default_props.cut_y_axis_spacing = 1;
% default_props.cut_line_thickness = 2;
% default_props.extra_title_margin_psf = 0.5;  % extra vertical margin for plot title
% default_props.extra_title_margin_cut = 0.14;  % extra vertical margin for plot title
% default_props.nominal_plot_size = [620 528];
% default_props.primary_color = [0 1 0];
% default_props.figure_num = 1;
% default_props.primary = 'gaussian-15_donut';
% default_props.secondary = 'c11';
% default_props.img_cut_name = 'Gaussian donut';
% default_props.img_rel_cut_name = 'C11 aperture';
% 
% run_diff(default_props);