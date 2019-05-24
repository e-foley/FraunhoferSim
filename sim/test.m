clearvars;

% aperture = imread(['../Inputs/' 'multigaussian-15' '.png']);
% aperture = imread(['../Inputs/' 'diamond_temp' '.png']);
aperture = imread(['../Inputs/' 'c11' '.png']);
% aperture = imread(['../Inputs/' 'bowtie' '.png']);

% Define formatting parameters for the aperture figure.
aperture_props = ImagescProps;
aperture_props.nominal_plot_size = [620 528];
aperture_props.plot_title = 'Aperture';
aperture_props.field_limits = [-0.5 0.5; -0.5 0.5];
aperture_props.output_limits = [0 1];
aperture_props.h_axis_title = '{\itx}'' ({\itx}/{\itD})';
aperture_props.h_axis_tick_spacing = 0.1;
aperture_props.v_axis_title = '{\ity}'' ({\ity}/{\itD})';
aperture_props.v_axis_tick_spacing = 0.1;
aperture_props.extra_title_margin = 0.02;
aperture_props.font_size = 14;
aperture_props.color_map = gray(256);

% Define output parameters for the aperture figure.
psf_io_props = ImagescIoProps;
psf_io_props.save_eps = false;
psf_io_props.save_png = false;
psf_io_props.eps_location = 'works.eps';
psf_io_props.png_location = 'works.png';

% [aperture_figure] = plotAperture(aperture, aperture_props, psf_io_props);
% close(aperture_figure);

input_scale = 0.25;  % controls accuracy of PSF
fft_scale = 16;  % controls resolution of PSF
[psf, reduced_input_size, fft_size] = ...
     getCharacteristicPsf(aperture, input_scale, fft_scale);

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
 
% Define output parameters for the PSF figure.
psf_io_props = ImagescIoProps;
psf_io_props.save_eps = false;
psf_io_props.save_png = false;
psf_io_props.eps_location = 'works2.eps';
psf_io_props.png_location = 'works2.png';
 
% [psf_figure] = psfPlot(psf, psf_props, psf_io_props);


% image = psfGetImage(psf, [-20 20; -20 20], [-4 -1]);
% figure;
% imshow(image);

% image = psfGetImage(psf, [-30 30; -24 24], [-4 -1]);
% imshow(image * 255, pink(255));
% imshow(psf.data .^ (1/5) / max(max(psf.data .^ (1/5))));

% [u, w] = psfCut(psf, [-7 7]);
% plot(u, w);


% star1 = Star;
% star1.as_pos = [0 0];
% star1.app_vis_mag = 1;
% 
% star2 = Star;
% star2.as_pos = [2 1];
% star2.app_vis_mag = 4;
% 
% stars = [star1 star2];

stars = asterismFromDouble(3, [0 3], 90);

[sv] = getStarView(stars, psf, 6, 550);
% image = svGetImage(sv, [-3 3; -3 3], [10 0]);
% imshow(image);




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

sv_io_props = ImagescIoProps;
sv_io_props.save_eps = false;
sv_io_props.save_png = true;
sv_io_props.eps_location = 'works3.eps';
sv_io_props.png_location = 'works3.png';

[sv_figure] = svPlot(sv, sv_props, sv_io_props);


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


