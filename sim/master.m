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
imagesc_title = ['Ideal monochromatic, on-axis PSF of ' ''];  %fix me
show_processed = false;
save_processed = true;
persist_scaled = false;
save_scaled_eps = false;
save_scaled_png = true;
figure_num = 1;

% Define standard PSF-generation properties
psf_props = PsfProps;
psf_props.input_scale = 0.25;
psf_props.fft_scale = 8;
psf_props.ld_conv = [0 0 1];

% Define standard cropping properties
crop_scale_props = CropScaleProps;
crop_scale_props.ld_lim = 12;
crop_scale_props.mag_lims = [1 4];

% Define imagesc-related properties
imagesc_props = ImagescProps;
imagesc_props.nominal_plot_size = [620 528];
imagesc_props.ld_u_axis_tick_spacing = 2;
imagesc_props.ld_v_axis_tick_spacing = 2;
imagesc_props.extra_title_margin = 0.5;
imagesc_props.font_size = 14;
imagesc_props.color_map = parula(256);

% Define overlay-related properties
overlay_props = OverlayProps;  % Struct defined in OverlayProps.m
overlay_props.cut_vert_lims = [-8 0];
overlay_props.cut_y_axis_spacing = 1;
overlay_props.cut_line_thickness = 2;
overlay_props.extra_title_margin_cut = 0.14;  % extra vertical margin for plot title
overlay_props.primary_color = [0 1 0];

runOverlay(overlay_props, psf_props, crop_scale_props, imagesc_props, 'gaussian-15_donut', 'items/gaussian-15_donut.png', 'Gaussian donut', 'multigaussian-15', 'items/multigaussian-15.png', 'Multi-Gaussian', figure_num);

inputs = {
%     'c11' psf_props crop_scale_props imagesc_props
%     'gaussian-15' psf_props crop_scale_props imagesc_props
};

% overlays = {
%     'gaussian-15' 'c11' psf_props,  
% };

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
    ld_bounds = reduced_size' * [-0.5 0.5];  % LD covered by whole image (`reduced_size` refers to scaled input image) 
    % TODO: Handle the arguments here better...
    [figure_num] = runImagesc(log_scaled, input{4}, ld_bounds, input{3}, imagesc_title, persist_scaled, figure_num, save_scaled_eps, scaled_path_eps, save_scaled_png, scaled_path_png);
end
