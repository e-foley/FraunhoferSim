% Runner file.  Creates power-spectrum-related figures from existing
% aperture shape files.

close all;  % Get rid of our figures
clear variables;  % Clean up our variables

% Define global propertes
image_path = 'items/';
input_extension = '.png';
processed_extension = '_psf.png';
scaled_extension_eps = '_scaled.eps';
scaled_extension_png = '_scaled.png';
show_processed = true;
save_processed = true;
save_scaled_eps = false;
save_scaled_png = true;
color_map = bone(256);
figure_num = 1;

% Define standard PSF-generation properties
psf_props = PsfProps;
psf_props.input_scale = 0.25;
psf_props.fft_scale = 8;
psf_props.ld_conv = [0 0 1];

% Define standard cropping properties
crop_scale_props = CropScaleProps;
crop_scale_props.ld_lim = 12;
crop_scale_props.mag_lims = [0 4];

% Define plot-related properties
plot_props = PlotProps;
plot_props.nominal_plot_size = [640 528];
plot_props.ld_u_axis_tick_spacing = 2;
plot_props.ld_v_axis_tick_spacing = 2;
plot_props.my_title = ['Ideal monochromatic, on-axis PSF of ' ''];  %fix me
plot_props.extra_title_margin = 0.5;
plot_props.font_size = 14;

inputs = {
    'c11' psf_props crop_scale_props plot_props
    'gaussian-15' psf_props crop_scale_props plot_props
};

for i = 1:size(inputs, 1)
    input = {inputs{i, :}}; %#ok<CCAT1>
    path = [image_path inputs{i, 1} input_extension];
    processed_path = [image_path inputs{i, 1} processed_extension];
    scaled_path_eps = [image_path inputs{i, 1} scaled_extension_eps];
    scaled_path_png = [image_path inputs{i, 1} scaled_extension_png];
    [xfm, reduced_size, fft_size] = getCleverPowerSpectrum(imread(path), input{2});
    % Note for later: the convolutions should probably happen outside of power
    % spec. so that we can apply rainbow effect to each point of light...
    [processed, log_scaled, figure_num] = cropAndScale(xfm, input{2}.fft_scale, input{3}, show_processed, figure_num, save_processed, processed_path);
    ld_bounds = reduced_size' * [-0.5 0.5];
    % TODO: Handle the arguments here better...
    [figure_num] = runImagesc(log_scaled, input{4}, ld_bounds, input{3}.ld_lim, color_map, input{3}.mag_lims, figure_num, save_scaled_eps, scaled_path_eps, save_scaled_png, scaled_path_png);
end

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