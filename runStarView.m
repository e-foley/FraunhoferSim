% Focus on below variables =====================================================

input_name = 'gaussian 50 donut 160';  % Aperture image file name less extension
aperture_title = 'Gaussian boomerang';  % Shows up in plot titles
aperture_scale = 1.0;  % Default: 1.0 (can use 0.25 for draft)
fft_scale = 8;  % Default: 8
as_bound = 5;
app_vis_mag_lims = [10 2];
star_separation_as = 3.1;
star_app_mags = [0 3.0];
star_angle = 120;
aperture_diam_in = 11;
wavelength_nm = 548;

% End important variables ======================================================

input_prefix = 'apertures/';
output_prefix = 'plots/';
io_props = IoProps;
io_props.save_png = true;
io_props.save_eps = false;
io_props.png_location = [output_prefix input_name ' sv plot.png'];
stars = asterismFromDouble(star_separation_as, star_app_mags, star_angle);
psf = getPsf(imread([input_prefix input_name '.png']), aperture_scale, fft_scale);
sv = getStarView(stars, psf, aperture_diam_in, wavelength_nm);
sv_image = svGetImage(sv, as_bound * [-1 1; -1 1], app_vis_mag_lims);
imwrite(sv_image, [output_prefix input_name ' sv.png']);
sv_plot_props = getStarViewPlotDefaults;
sv_plot_props.plot_title = ['Ideal monochromatic view through ' aperture_title];
sv_plot_props.field_limits = as_bound .* [-1 1; -1 1];
sv_plot_props.output_limits = app_vis_mag_lims;
svPlot(sv, sv_plot_props, io_props);
