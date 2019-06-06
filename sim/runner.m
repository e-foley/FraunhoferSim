clearvars;

% Variables used in multiple contexts.
input_prefix = '../Inputs/';
output_prefix = '../Outputs/';
standard_diameter_in = 11;  % [in]
standard_wavelength_nm = 550;  % [nm]

% Define standard formatting parameters for aperture figures.
aperture_props = ImagescProps;
aperture_props.nominal_plot_size = [620 528];
aperture_props.plot_title = '';  % overwritten inside loop
aperture_props.field_limits = [-0.5 0.5; -0.5 0.5];
aperture_props.output_limits = [0 1];
aperture_props.h_axis_title = '{\itx}'' ({\itx}/{\itD})';
aperture_props.h_axis_tick_spacing = 0.1;
aperture_props.v_axis_title = '{\ity}'' ({\ity}/{\itD})';
aperture_props.v_axis_tick_spacing = 0.1;
aperture_props.extra_title_margin = 0.02;
aperture_props.font_size = 14;
aperture_props.color_map = gray(256);
save_aperture_plot_eps = false;
save_aperture_plot_png = true;

% Define standard PSF generation properties
psf_input_scale = 0.25;
psf_fft_scale = 8;
save_psf_plain_eps = false;
save_psf_plain_png = true;

% Define standard formatting parameters for PSF figures.
psf_props = ImagescProps;
psf_props.nominal_plot_size = [620 528];
psf_props.plot_title = 'Power spectrum';
psf_props.field_limits = [-12 12; -12 12];
psf_props.output_limits = [-4 -1];
psf_props.h_axis_title = '{\itu} [{\it\lambda}/{\itD}]';
psf_props.h_axis_tick_spacing = 2;
psf_props.v_axis_title = '{\itv} [{\it\lambda}/{\itD}]';
psf_props.v_axis_tick_spacing = 2;
psf_props.extra_title_margin = 0.5;
psf_props.font_size = 14;
psf_props.color_map = hot(256);
save_psf_plot_eps = false;
save_psf_plot_png = true;

% Define standard asterisms to generate star views of.
central_star = Star([0 0], 0);
close_double = asterismFromDouble(1, [0 4], 90);

% Define standard star view configurations.
sv_params = {central_star, standard_diameter_in, standard_wavelength_nm};
sv_params2 = {close_double, standard_diameter_in, standard_wavelength_nm};

% Define standard formatting parameters for star view figures.
sv_props = ImagescProps;
sv_props.nominal_plot_size = [620 528];
sv_props.plot_title = 'Image';
sv_props.field_limits = [-3 3; -3 3];
sv_props.output_limits = [10 2];
sv_props.h_axis_title = '{\itu} [as]';
sv_props.h_axis_tick_spacing = 1;
sv_props.v_axis_title = '{\itv} [as]';
sv_props.v_axis_tick_spacing = 1;
sv_props.extra_title_margin = 0.1;
sv_props.font_size = 14;
sv_props.color_map = bone(256);
save_sv_plot_eps = false;
save_sv_plot_png = true;

% Name index
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
  'gaussian-15_donut_45-deg_spokes' ['Gaussian donut (45' char(176) ' spokes)']
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

% MAIN ACTION ARRAY ============================================================
% column 1 = name
% column 2 = [aperture_props ...]
% column 3 = [psf_props ...]
% column 4 = [cut_props ...]
% column 5 = {{stars, diameter, wavelength, sv_props} ...}
actions = {
    'c11' aperture_props [] [] []
    'full' aperture_props psf_props [] {[sv_params {sv_props}] [sv_params2 {sv_props}]}
};
%===============================================================================

for i=1:size(actions, 1)
    action = actions(i,:);
    short_name = actions{i,1};
    [n_row, ~] = find(strcmp(names, short_name));
    long_name = names{n_row, 2};
    
    %name = names(find(strcmp(names, action{1}));
    
    aperture = imread(['../Inputs/' short_name '.png']);
    
    % Aperture plotting actions
    for j=1:numel(action{2})
        props = action{2}(j);
        props.plot_title = long_name;
        io_props = ImagescIoProps;
        io_props.save_eps = save_aperture_plot_eps;
        io_props.save_png = save_aperture_plot_png;
        io_props.eps_location = [output_prefix short_name ' plot ' num2str(j) '.eps'];
        io_props.png_location = [output_prefix short_name ' plot ' num2str(j) '.png'];
        [aperture_figure] = plotAperture(aperture, props, io_props);
        close(aperture_figure);
    end
    
    % PSF calculation actions
    [psf, reduced_input_size, fft_size] = ...
        getCharacteristicPsf(aperture, psf_input_scale, psf_fft_scale);

    % PSF plotting actions
    for j=1:numel(action{3})
        % Formatted plot
        props = action{3}(j);
        props.plot_title = ['Ideal, monochromatic, on-axis PSF of ' long_name];
        io_props = ImagescIoProps;
        io_props.save_eps = save_psf_plot_eps;
        io_props.save_png = save_psf_plot_png;
        io_props.eps_location = [output_prefix short_name ' psf plot ' num2str(j) '.eps'];
        io_props.png_location = [output_prefix short_name ' psf plot ' num2str(j) '.png'];
        [psf_figure] = psfPlot(psf, props, io_props);
        close(psf_figure);
        
        % Plain plot
        image = psfGetImage(psf, props.field_limits, props.output_limits);
        if (save_psf_plain_eps)
            imwrite(image, [output_prefix short_name ' psf plain ' num2str(j) '.eps']);
        end
        if (save_psf_plain_png)
            imwrite(image, [output_prefix short_name ' psf plain ' num2str(j) '.png']);
        end
    end
    
    % Cut plotting actions
    % TODO: FINISH ME
    
    % Star view calculation/plotting actions
    for j=1:numel(action{5})
        params = action{5}{j}(1:3);
        props = action{5}{j}{4};
        props.plot_title = '';  % TODO: Enter something.
        io_props = ImagescIoProps;
        io_props.save_eps = save_sv_plot_eps;
        io_props.save_png = save_sv_plot_png;
        io_props.eps_location = [output_prefix short_name ' sv ' num2str(j) '.eps'];
        io_props.png_location = [output_prefix short_name ' sv ' num2str(j) '.png'];
        sv = getStarView(params{1}, psf, params{2}, params{3});
        [sv_figure] = svPlot(sv, props, io_props);
        close(sv_figure);
    end 
end




 
% [psf_figure] = psfPlot(psf, psf_props, psf_io_props);


% image = psfGetImage(psf, [-20 20; -20 20], [-4 -1]);
% figure;
% imshow(image);

% image = psfGetImage(psf, [-30 30; -24 24], [-4 -1]);
% imshow(image * 255, pink(255));

% [u, w] = psfCut(psf, [-7 7]);
% plot(u, w);


% [sv] = getStarView(stars, psf, 6, 550);
% image = svGetImage(sv, [-3 3; -3 3], [10 0]);
% imshow(image);






% [sv_figure] = svPlot(sv, sv_props, sv_io_props);


% img = [0 1 2 3 4; 5 6 7 8 9; 10 11 12 13 14; 15 16 17 18 19] / 19.0;
% img = fftshift(img);
% imshow(img);
% 
% line = [-1 1 -1 1 -1 1 -1];
% testing = fft(line);
% testing = abs(testing) .^ 2;
% plot(testing);

% aperture_props = ImagescProps;
% aperture_props.nominal_plot_size = [620 528];
% aperture_props.h_axis_title = '{\itx}'' ({\itx}/{\itD})';
% aperture_props.h_axis_tick_spacing = 0.1;
% aperture_props.v_axis_title = '{\ity}'' ({\ity}/{\itD})';
% aperture_props.v_axis_tick_spacing = 0.1;
% aperture_props.extra_title_margin = 0.02;
% aperture_props.font_size = 14;
% aperture_props.color_map = gray(256);
% 
% aperture_title = 'test';
% persist_aperture = true;
% figure_num = 1;
% save_aperture_eps = false;
% save_aperture_png = false;
% aperture_location_eps = '';
% aperture_location_png = '';
% 
% plotAperture(mask, aperture_props, aperture_title, persist_aperture,...
%     figure_num, save_aperture_eps, save_aperture_png,...
%     aperture_location_eps, aperture_location_png);


