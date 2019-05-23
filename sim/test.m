clearvars;

aperture = imread(['../Inputs/' 'multigaussian-15' '.png']);
% aperture = imread(['../Inputs/' 'diamond_temp' '.png']);
% aperture = imread(['../Inputs/' 'c11' '.png']);

input_scale = 1;
fft_scale = 4;
[psf, reduced_input_size, fft_size] = ...
     getCharacteristicPsf(aperture, input_scale, fft_scale);

% image = psfGetImage(psf, [-4 -1]);
 
psf_crop = psfCrop(psf, [-24 24; 0 18]);
image = psfGetImage(psf_crop, [-4 -1]);
imshow(image);
% imshow(psf.data .^ (1/5) / max(max(psf.data .^ (1/5))));

%[u, w] = psfCut(psf, [-5 5]);
%plot(u, w);

% psf_convolve = psfConvolve(psf, [0 0 1; 2 -6 0.1; -3 3 0.1]);
% imshow(psfGetImage(psf_convolve, [-4 -1]));


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


