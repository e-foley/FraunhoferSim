% Runner file.  Creates power-spectrum-related figures from existing
% aperture shape files.

% Change fft_scale back to 16
close all;  % Get rid of our figures
clear variables;  % Clean up our variables

% Define global propertes
telescope_diameter = 11;  % [in] Affects convolution matrix math
input_directory = '../Inputs/';
output_directory = '../Outputs/temp/';
input_extension = '.png';
aperture_extension_eps = '_aperture.eps';
aperture_extension_png = '_aperture.png';
processed_extension = '_psf.png';
scaled_extension_eps = '_scaled.eps';
scaled_extension_png = '_scaled.png';
spec_extension = '_psf_specs.txt';
imagesc_title_prefix = 'Ideal monochromatic, on-axis PSF of ';
persist_aperture = false;
save_aperture_eps = true;  % default: true
save_aperture_png = true;  % default: true
show_processed = false;
save_processed = true;  % default: true
persist_scaled = false;
save_scaled_eps = false;
save_scaled_png = true;  % default: true
save_psf_overlay = true;  % default: true
save_cut_overlay = true;  % default: true
save_combo = true;  % default: true
persist_overlay_figures = true;
generate_spec_files = true;  % default: true
figure_num = 1;

% Define formatting parameters for the aperture figure.
aperture_props = ImagescProps;
aperture_props.nominal_plot_size = [620 528];
aperture_props.h_axis_title = '{\itx}'' ({\itx}/{\itD})';
aperture_props.h_axis_tick_spacing = 0.1;
aperture_props.v_axis_title = '{\ity}'' ({\ity}/{\itD})';
aperture_props.v_axis_tick_spacing = 0.1;
aperture_props.extra_title_margin = 0.02;
aperture_props.font_size = 14;
aperture_props.color_map = gray(256);

% Define standard PSF-generation properties.
psf_props = PsfProps;
psf_props.input_scale = 1.0;  % Affects accuracy
psf_props.fft_scale = 8;  % Affects resolution (8 is fair)
% psf_props.ld_conv = [0 0 1];  % default: [0 0 1]
psf_props.ld_conv = doubleToLd(2.5, [0 7], 90, 680, telescope_diameter);
psf_props.is_coherent = false;

% Define standard cropping properties.
crop_scale_props = CropScaleProps;
crop_scale_props.ld_lim = 12;
crop_scale_props.mag_lims = [1 4];

% Define imagesc-related properties.
imagesc_props = ImagescProps;
imagesc_props.nominal_plot_size = [620 528];
imagesc_props.h_axis_title = '{\itu} [{\it\lambda}/{\itD}]';
imagesc_props.h_axis_tick_spacing = 2;
imagesc_props.v_axis_title = '{\itv} [{\it\lambda}/{\itD}]';
imagesc_props.v_axis_tick_spacing = 2;
imagesc_props.extra_title_margin = 0.5;
imagesc_props.font_size = 14;
imagesc_props.color_map = hot(256);

% Define overlay-related properties
overlay_props = OverlayProps;  % Struct defined in OverlayProps.m
overlay_props.cut_vert_lims = [-8 0];
overlay_props.cut_y_axis_spacing = 1;
overlay_props.cut_line_thickness = 2;
overlay_props.extra_title_margin_cut = 0.14;  % extra vertical margin for plot title
overlay_props.primary_color = [0 1 0];
overlay_props.show_target = true;
overlay_props.target = -2.6;  % base-10 magnitude
overlay_props.target_line_thickness = 1;
overlay_props.target_line_color = [0.4 0.4 0.4];

inputs = {
%     'apodization_0-18' aperture_props psf_props crop_scale_props imagesc_props
%     'apodizing_screen_4-16' aperture_props psf_props crop_scale_props imagesc_props
%     'beamed bowtie' aperture_props psf_props crop_scale_props imagesc_props
%     'bowtie' aperture_props psf_props crop_scale_props imagesc_props
%     'C11 and structure' aperture_props psf_props crop_scale_props imagesc_props
%     'c11' aperture_props psf_props crop_scale_props imagesc_props
%     'diamond' aperture_props psf_props crop_scale_props imagesc_props
     'full' aperture_props psf_props crop_scale_props imagesc_props
%     'Gaussian 18 donut and structure' aperture_props psf_props crop_scale_props imagesc_props
%     'gaussian-05' aperture_props psf_props crop_scale_props imagesc_props
%     'gaussian-08' aperture_props psf_props crop_scale_props imagesc_props
%     'gaussian-10' aperture_props psf_props crop_scale_props imagesc_props
%     'gaussian-15' aperture_props psf_props crop_scale_props imagesc_props
%     'gaussian-15_donut' aperture_props psf_props crop_scale_props imagesc_props
%     'gaussian-18' aperture_props psf_props crop_scale_props imagesc_props
%     'gaussian-18_donut' aperture_props psf_props crop_scale_props imagesc_props
%     'hexagon_donut1' aperture_props psf_props crop_scale_props imagesc_props
%     'hexagon_donut2' aperture_props psf_props crop_scale_props imagesc_props
%     'hexagon' aperture_props psf_props crop_scale_props imagesc_props
%     'inner' aperture_props psf_props crop_scale_props imagesc_props
%     'multigaussian-15' aperture_props psf_props crop_scale_props imagesc_props
%     'square' aperture_props psf_props crop_scale_props imagesc_props
%     'triangle' aperture_props psf_props crop_scale_props imagesc_props
};

overlays = {
%     'apodization_0-18' 'full' overlay_props psf_props crop_scale_props imagesc_props
%     'apodizing_screen_4-16' 'full' overlay_props psf_props crop_scale_props imagesc_props
%     'gaussian-15_donut' 'c11' overlay_props psf_props crop_scale_props imagesc_props
%     'gaussian-18_donut' 'c11' overlay_props psf_props crop_scale_props imagesc_props
%     'hexagon_donut1' 'c11' overlay_props psf_props crop_scale_props imagesc_props
%     'hexagon' 'triangle' overlay_props psf_props crop_scale_props imagesc_props
%     'triangle' 'full' overlay_props psf_props crop_scale_props imagesc_props
%     'diamond' 'triangle' overlay_props psf_props crop_scale_props imagesc_props
%     'c11' 'full' overlay_props psf_props crop_scale_props imagesc_props
%     'bowtie' 'multigaussian-18' overlay_props psf_props crop_scale_props imagesc_props
%     'beamed bowtie' 'bowtie' overlay_props psf_props crop_scale_props imagesc_props 
%     'multigaussian-15' 'c11' overlay_props psf_props crop_scale_props imagesc_props    
%     'multigaussian-18' 'c11' overlay_props psf_props crop_scale_props imagesc_props
%     'hexagon_donut2' 'hexagon_donut1' overlay_props psf_props crop_scale_props imagesc_props
%     'hexagon_donut1' 'c11' overlay_props psf_props crop_scale_props imagesc_props
%     'hexagon_donut2' 'c11' overlay_props psf_props crop_scale_props imagesc_props
%     'beamed bowtie' 'gaussian-18_donut' overlay_props psf_props crop_scale_props imagesc_props
};

names = {
  'apodization_0-18' 'apodizing mask'
  'apodizing_screen_4-16' 'apodizing screen'
  'beamed bowtie' 'beamed bowtie mask'
  'bowtie' 'bowtie mask'
  'C11 and structure' 'C11 with spokes'
  'c11' 'C11 aperture'
  'diamond' 'diamond aperture'
  'full' 'circular aperture'
  'Gaussian 18 donut and structure' 'Gaussian donut with spokes'
  'gaussian-05' 'Gaussian aperture'
  'gaussian-08' 'Gaussian aperture'
  'gaussian-10' 'Gaussian aperture'
  'gaussian-15' 'Gaussian aperture'
  'gaussian-15_donut' 'Gaussian donut'
  'gaussian-18' 'Gaussian aperture'
  'gaussian-18_donut' 'Gaussian donut'
  'hexagon_donut1' 'hex donut (vertex spokes)'
  'hexagon_donut2' 'hex donut (edge spokes)'
  'hexagon' 'hexagonal aperture'
  'inner' 'C11 central obstruction'
  'multigaussian-15' 'multi-Gaussian'
  'multigaussian-18' 'multi-Gaussian'
  'square' 'square aperture'
  'triangle' 'triangular aperture'
};

for i = 1:size(inputs, 1)
    input = {inputs{i, :}};  %#ok<CCAT1>
    [p_row, ~] = find(strcmp(names, input{1}));
    input_location = [input_directory input{1} input_extension];
    aperture_location_eps = [output_directory input{1} aperture_extension_eps];
    aperture_location_png = [output_directory input{1} aperture_extension_png];
    output_location_png = [output_directory input{1} processed_extension];
    scaled_location_eps = [output_directory input{1} scaled_extension_eps];
    scaled_location_png = [output_directory input{1} scaled_extension_png];
    aperture_title = [names{p_row, 2}];
    imagesc_title = [imagesc_title_prefix names{p_row, 2}];
    
    mask = imread(input_location);
    [figure_num] = plotApertureNew(mask, input{2}, aperture_title, persist_aperture, figure_num, save_aperture_eps, save_aperture_png, aperture_location_eps, aperture_location_png);
    [xfm, reduced_size, fft_size] = getCleverPowerSpectrum(imread(input_location), input{3});
    % Note for later: the convolutions should probably happen outside of power
    % spec. so that we can apply rainbow effect to each point of light...
    [processed, log_scaled, figure_num] = cropAndScale(xfm, input{3}.fft_scale, input{4}, show_processed, figure_num);
    if save_processed
        imwrite(processed, output_location_png);
    end
    ld_bounds = reduced_size' * [-0.5 0.5];  % LD covered by whole image (`reduced_size` refers to scaled input image) 
    % TODO: Handle the arguments here better...
    [figure_num] = runImagesc(log_scaled, input{5}, ld_bounds, input{4}, imagesc_title, persist_scaled, figure_num, save_scaled_eps, scaled_location_eps, save_scaled_png, scaled_location_png);
    if generate_spec_files
        spec_output_location = [output_directory input{1} spec_extension];
        generatePsfSpecFile(input{3}, size(mask), reduced_size, fft_size, input{4}, size(processed), input{2}, input{5}, spec_output_location);
    end
end

for i = 1:size(overlays, 1)
    overlay = {overlays{i, :}};  %#ok<CCAT1>
    [p_row, ~] = find(strcmp(names, overlay{1}));
    [s_row, ~] = find(strcmp(names, overlay{2}));
    
    % Define I/O properties.  (Better than an outrageously long parameter
    % list, in my opinion.)
    overlay_io_props = OverlayIoProps;
    overlay_io_props.primary_input_location = [input_directory overlay{1} '.png'];
    overlay_io_props.secondary_input_location = [input_directory overlay{2} '.png'];
    overlay_io_props.save_psf_overlay = save_psf_overlay;
    overlay_io_props.psf_overlay_location_png = [output_directory overlay{1} '_vs_' overlay{2} '_psf_overlay.png'];
    overlay_io_props.psf_overlay_location_eps = [output_directory overlay{1} '_vs_' overlay{2} '_psf_overlay.eps'];
    overlay_io_props.save_cut_overlay = save_cut_overlay;
    overlay_io_props.cut_overlay_location_png = [output_directory overlay{1} '_vs_' overlay{2} '_cut_overlay.png'];
    overlay_io_props.cut_overlay_location_eps = [output_directory overlay{1} '_vs_' overlay{2} '_cut_overlay.eps'];
    overlay_io_props.save_combo = save_combo;
    overlay_io_props.combo_location_png = [output_directory overlay{1} '_vs_' overlay{2} '_side_by_side.png'];
    
    % Actually run overlay code.
    [figure_num] = runOverlay(overlay{3}, overlay{4}, overlay{5}, overlay{6}, overlay_io_props,...
        names{p_row, 2}, names{s_row, 2}, persist_overlay_figures, figure_num);
end
