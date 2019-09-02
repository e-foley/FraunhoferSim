% Utility script that produces a formatted aperture plot, isolating the most
% common parameters for easy customization.

% Focus on below variables =====================================================

input_name = 'gaussian 50 donut 160';  % Aperture image file name less extension
aperture_title = 'Gaussian boomerang';  % Plot title

% End important variables ======================================================

input_prefix = 'apertures/';
output_prefix = 'plots/';
io_props = IoProps;
io_props.save_png = true;
io_props.save_eps = false;
io_props.png_location = [output_prefix input_name ' aperture plot.png'];
aperture = imread([input_prefix input_name '.png']);
aperture_plot_props = getAperturePlotDefaults;
aperture_plot_props.plot_title = aperture_title;
close(plotAperture(aperture, aperture_plot_props, io_props));
