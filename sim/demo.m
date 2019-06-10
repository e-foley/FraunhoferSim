clearvars;

% Variables used in multiple contexts.
input_prefix = '../Inputs/';
output_prefix = '../Outputs/';
standard_diameter_in = 11;  % [in]
standard_wavelength_nm = 550;  % [nm]

% Define standard formatting parameters for aperture figures.
aperture_props = ImagescProps;
aperture_props.plot_title = '';  % overwritten inside loop
aperture_props.nominal_plot_size_px = [620 528];
aperture_props.extra_title_margin = 0.02;
aperture_props.field_limits = [-0.5 0.5; -0.5 0.5];
aperture_props.output_limits = [0 1];
aperture_props.h_axis_title = '{\itx}'' ({\itx}/{\itD})';
aperture_props.h_axis_tick_spacing = 0.1;
aperture_props.v_axis_title = '{\ity}'' ({\ity}/{\itD})';
aperture_props.v_axis_tick_spacing = 0.1;
aperture_props.labels = {''};  % no label needed
aperture_props.show_color_bars = false;
aperture_props.color_maps = gray(256);
aperture_props.font_size_pt = 14;

% Define aperture plot I/O properties.
aperture_io_props = IoProps;
aperture_io_props.save_eps = false;
aperture_io_props.save_png = true;

% Define standard PSF generation properties
aperture_scale = 0.25;
fft_scale = 8;
save_psf_plain_eps = false;
save_psf_plain_png = true;

% Define standard formatting parameters for PSF figures.
col = [1 0 1];
psf_props = ImagescProps;
psf_props.plot_title = 'Power spectrum';
psf_props.nominal_plot_size_px = [660 528];
psf_props.extra_title_margin = 0.5;
psf_props.field_limits = [-12 12; -12 12];
psf_props.output_limits = [-4 -1];
psf_props.h_axis_title = '{\itu} [{\it\lambda}/{\itD}]';
psf_props.h_axis_tick_spacing = 2;
psf_props.v_axis_title = '{\itv} [{\it\lambda}/{\itD}]';
psf_props.v_axis_tick_spacing = 2;
psf_props.labels = {'Test', 'ing'};
psf_props.show_color_bars = true;
%psf_props.color_maps = hot(256);
psf_props.color_maps = {col.*gray(256) (1-col).*gray(256)};
%psf_props.color_maps = {[1 0 0].*gray(256) [0 1 0].*gray(256) [0 0 1].*gray(256)};
psf_props.font_size_pt = 14;

% Define PSF plot I/O properties.
psf_io_props = IoProps;
psf_io_props.save_eps = false;
psf_io_props.save_png = true;

% Define standard asterisms to generate star views of.
central_star = Star([0 0], 0);
close_double = asterismFromDouble(1, [0 4], 90);

% Define standard star view configurations.
sv_params = {central_star, standard_diameter_in, standard_wavelength_nm};
sv_params2 = {close_double, standard_diameter_in, standard_wavelength_nm};

% Define standard formatting parameters for star view figures.
sv_props = ImagescProps;
sv_props.plot_title = 'Image';
sv_props.nominal_plot_size_px = [620 528];
sv_props.extra_title_margin = 0.1;
sv_props.field_limits = [-3 3; -3 3];
sv_props.output_limits = [10 2];
sv_props.h_axis_title = '{\itu} [as]';
sv_props.h_axis_tick_spacing = 1;
sv_props.v_axis_title = '{\itv} [as]';
sv_props.v_axis_tick_spacing = 1;
sv_props.labels = {'Test', 'ing'};
sv_props.show_color_bars = false;
sv_props.color_maps = bone(256);
sv_props.font_size_pt = 14;

% ==============================================================================
short_name = 'c11';
long_name = 'C11 aperture';
aperture_props.plot_title = long_name;
aperture_io_props.eps_location = [output_prefix short_name ' plot.eps'];
aperture_io_props.png_location = [output_prefix short_name ' plot.png'];
psf_props.plot_title = ['Ideal monochromatic, on-axis PSF comparison'];
psf_io_props.eps_location = [output_prefix short_name ' psf plot.eps'];
psf_io_props.png_location = [output_prefix short_name ' psf plot.png'];

aperture1 = imread([input_prefix short_name '.png']);
close(plotAperture(aperture1, aperture_props, aperture_io_props));
aperture2 = imread([input_prefix 'bowtie' '.png']);
close(plotAperture(aperture2, aperture_props, aperture_io_props));
aperture3 = imread([input_prefix 'hexagon' '.png']);
close(plotAperture(aperture3, aperture_props, aperture_io_props));
[psf1, scaled_aperture_size_px, fft_size_px] = ...
    getPsf(aperture1, aperture_scale, fft_scale);
savePsfSpecs(size(aperture1), aperture_scale, scaled_aperture_size_px, ...
    fft_scale, fft_size_px, [output_prefix short_name ' psf specs.txt']); 
[psf2, ~, ~] = getPsf(aperture2, aperture_scale, fft_scale);
[psf3, ~, ~] = getPsf(aperture3, aperture_scale, fft_scale);
%close(psfPlot(psf1, psf_props, psf_io_props));
%psfPlot([psf1 psf2], psf_props, psf_io_props);
%psfPlot([psf1 psf2 psf3], psf_props, psf_io_props);

% Define cut properties
cut_props = CutProps;
cut_props.plot_title = 'Horizontal PSF cut';
cut_props.nominal_plot_size_px = [620 528];
cut_props.extra_title_margin = 0.14;  % extra vertical margin for plot title
cut_props.u_title = '{\itu} [{\it\lambda}/{\itD}]';
cut_props.u_limits = [0 psf_props.field_limits(1,2)];
cut_props.u_spacing = 2;
cut_props.w_title = 'log_1_0 contrast';
cut_props.w_limits = [-8 0];
cut_props.w_spacing = 1;
cut_props.show_color_bars = true;
cut_props.color_maps = {col.*gray(256) (1-col).*gray(256)};
cut_props.c_limits = [-4 -1];
cut_props.c_spacing = 1;
cut_props.labels = {'C11', 'double Gaussian'};
cut_props.line_colors = {col, 1-col};
cut_props.cut_line_thickness_pt = 2;
cut_props.font_size_pt = 14;
cut_props.show_target = true;
cut_props.target = -2.6;  % base-10 magnitude
cut_props.target_line_thickness_pt = 1;
cut_props.target_line_color = [0.4 0.4 0.4];

cut_io_props = IoProps;
cut_io_props.save_eps = false;
cut_io_props.save_png = true;
cut_io_props.eps_location = [output_prefix short_name ' cut plot.eps'];
cut_io_props.png_location = [output_prefix short_name ' cut plot.png'];

c11 = imread([input_prefix 'c11.png']);
c11_psf = getPsf(c11, aperture_scale, fft_scale);
gaussian_donut = imread([input_prefix 'gaussian-18_donut.png']);
gaussian_donut_psf = getPsf(gaussian_donut, aperture_scale, fft_scale);
psf_props.labels = {'C11', 'double Gaussian'};
gaussian_donut_psf_plot = psfPlot([c11_psf gaussian_donut_psf], psf_props, psf_io_props);
cut_plot = psfCut([c11_psf gaussian_donut_psf], cut_props, cut_io_props);

%[my_figure] = psfCut(psf1, cut_props, cut_io_props);
%[my_figure] = psfCut([psf1 psf2], cut_props, cut_io_props);

% [my_figure] = plotCut(cutu, cutw, cut_props, cut_io_props);

% plot(cutu, cutw);

% stars = asterismFromDouble(2, [0 4], 90);
% sv = getStarView(stars, psf2, 6, 550);
% image = svGetImage(sv, [-6 6; -6 6], [10 0]);
% imshow(image);


% % Name index
% names = {
%   'apodization_0-18' 'apodizing mask'
%   'apodizing_screen_4-16' 'apodizing screen'
%   'beamed bowtie' 'beamed bowtie mask'
%   'bowtie' 'bowtie mask'
%   'C11 and structure' 'C11 with spokes'
%   'c11' 'C11 aperture'
%   'diamond' 'diamond aperture'
%   'full' 'circular aperture'
%   'Gaussian 18 donut and structure' 'Gaussian donut with spokes'
%   'gaussian-05' 'Gaussian aperture'
%   'gaussian-08' 'Gaussian aperture'
%   'gaussian-10' 'Gaussian aperture'
%   'gaussian-15' 'Gaussian aperture'
%   'gaussian-15_donut' 'Gaussian donut'
%   'gaussian-15_donut_45-deg_spokes' ['Gaussian donut (45' char(176) ' spokes)']
%   'gaussian-18' 'Gaussian aperture'
%   'gaussian-18_donut' 'Gaussian donut'
%   'hexagon_donut1' 'hex donut (vertex spokes)'
%   'hexagon_donut2' 'hex donut (edge spokes)'
%   'hexagon' 'hexagonal aperture'
%   'inner' 'C11 central obstruction'
%   'multigaussian-15' 'multi-Gaussian'
%   'multigaussian-18' 'multi-Gaussian'
%   'square' 'square aperture'
%   'triangle' 'triangular aperture'
% };
% 
% % MAIN ACTION ARRAY ============================================================
% % column 1 = name
% % column 2 = [aperture_props ...]
% % column 3 = [psf_props ...]
% % column 4 = [cut_props ...]
% % column 5 = {{stars, diameter, wavelength, sv_props} ...}
% actions = {
%     'c11' aperture_props [] [] []
%     'full' aperture_props psf_props [] {[sv_params {sv_props}] [sv_params2 {sv_props}]}
% };
% %===============================================================================
% 
% for i=1:size(actions, 1)
%     action = actions(i,:);
%     short_name = actions{i,1};
%     [n_row, ~] = find(strcmp(names, short_name));
%     long_name = names{n_row, 2};
%     
%     %name = names(find(strcmp(names, action{1}));
%     
%     aperture = imread(['../Inputs/' short_name '.png']);
%     
%     % Aperture plotting actions
%     for j=1:numel(action{2})
%         props = action{2}(j);
%         props.plot_title = long_name;
%         aperture_io_props = IoProps;
%         aperture_io_props.save_eps = save_aperture_plot_eps;
%         aperture_io_props.save_png = save_aperture_plot_png;
%         aperture_io_props.eps_location = [output_prefix short_name ' plot ' num2str(j) '.eps'];
%         aperture_io_props.png_location = [output_prefix short_name ' plot ' num2str(j) '.png'];
%         [aperture_figure] = plotAperture(aperture, props, aperture_io_props);
%         close(aperture_figure);
%     end
%     
%     % PSF calculation actions
%     [psf, reduced_input_size, fft_size] = ...
%         getPsf(aperture, psf_input_scale, psf_fft_scale);
% 
%     % PSF plotting actions
%     for j=1:numel(action{3})
%         % Formatted plot
%         props = action{3}(j);
%         props.plot_title = ['Ideal, monochromatic, on-axis PSF of ' long_name];
%         aperture_io_props = IoProps;
%         aperture_io_props.save_eps = save_psf_plot_eps;
%         aperture_io_props.save_png = save_psf_plot_png;
%         aperture_io_props.eps_location = [output_prefix short_name ' psf plot ' num2str(j) '.eps'];
%         aperture_io_props.png_location = [output_prefix short_name ' psf plot ' num2str(j) '.png'];
%         [psf_figure] = psfPlot(psf, props, aperture_io_props);
%         close(psf_figure);
%         
%         % Plain plot
%         image = psfGetImage(psf, props.field_limits, props.output_limits);
%         if (save_psf_plain_eps)
%             imwrite(image, [output_prefix short_name ' psf plain ' num2str(j) '.eps']);
%         end
%         if (save_psf_plain_png)
%             imwrite(image, [output_prefix short_name ' psf plain ' num2str(j) '.png']);
%         end
%     end
%     
%     % Cut plotting actions
%     % TODO: FINISH ME
%     
%     % Star view calculation/plotting actions
%     for j=1:numel(action{5})
%         params = action{5}{j}(1:3);
%         props = action{5}{j}{4};
%         props.plot_title = '';  % TODO: Enter something.
%         aperture_io_props = IoProps;
%         aperture_io_props.save_eps = save_sv_plot_eps;
%         aperture_io_props.save_png = save_sv_plot_png;
%         aperture_io_props.eps_location = [output_prefix short_name ' sv ' num2str(j) '.eps'];
%         aperture_io_props.png_location = [output_prefix short_name ' sv ' num2str(j) '.png'];
%         sv = getStarView(params{1}, psf, params{2}, params{3});
%         [sv_figure] = svPlot(sv, props, aperture_io_props);
%         close(sv_figure);
%     end 
% end
% 
% 
% 
% 
%  
% % [psf_figure] = psfPlot(psf, psf_props, psf_io_props);
% 
% 
% % image = psfGetImage(psf, [-20 20; -20 20], [-4 -1]);
% % figure;
% % imshow(image);
% 
% % image = psfGetImage(psf, [-30 30; -24 24], [-4 -1]);
% % imshow(image * 255, pink(255));
% 
% % [u, w] = psfCut(psf, [-7 7]);
% % plot(u, w);
% 
% 
% % [sv] = getStarView(stars, psf, 6, 550);
% % image = svGetImage(sv, [-3 3; -3 3], [10 0]);
% % imshow(image);
% 
% 
% 
% 
% 
% 
% % [sv_figure] = svPlot(sv, sv_props, sv_io_props);
% 
% 
% % img = [0 1 2 3 4; 5 6 7 8 9; 10 11 12 13 14; 15 16 17 18 19] / 19.0;
% % img = fftshift(img);
% % imshow(img);
% % 
% % line = [-1 1 -1 1 -1 1 -1];
% % testing = fft(line);
% % testing = abs(testing) .^ 2;
% % plot(testing);
% 
% % aperture_props = ImagescProps;
% % aperture_props.nominal_plot_size_px = [620 528];
% % aperture_props.h_axis_title = '{\itx}'' ({\itx}/{\itD})';
% % aperture_props.h_axis_tick_spacing = 0.1;
% % aperture_props.v_axis_title = '{\ity}'' ({\ity}/{\itD})';
% % aperture_props.v_axis_tick_spacing = 0.1;
% % aperture_props.extra_title_margin = 0.02;
% % aperture_props.font_size_pt = 14;
% % aperture_props.color_maps = gray(256);
% % 
% % aperture_title = 'test';
% % persist_aperture = true;
% % figure_num = 1;
% % save_aperture_eps = false;
% % save_aperture_png = false;
% % aperture_location_eps = '';
% % aperture_location_png = '';
% % 
% % plotAperture(mask, aperture_props, aperture_title, persist_aperture,...
% %     figure_num, save_aperture_eps, save_aperture_png,...
% %     aperture_location_eps, aperture_location_png);


