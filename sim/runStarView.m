% Focus on below variables =====================================================

input_name = 'circle';
aperture_title = 'circular aperture';
aperture_scale = 0.25;  % Default: 1.0
fft_scale = 8;  % Default: 8 (use with 1.0 aperture_scale for publishing)
star_separation_as = 3.1;
star_app_mags = [0 3.0];
star_angle = 120;
aperture_diam_in = 11;
wavelength_nm = 548;
extents_as = 5;
app_vis_mag_limits = [10 2];

% End important variables ======================================================

io_props = IoProps;
io_props.save_png = true;
io_props.save_eps = false;
input_prefix = 'apertures/';
output_prefix = 'plots/';
stars = asterismFromDouble(star_separation_as, star_app_mags, star_angle);
psf = getPsf(imread([input_prefix input_name '.png']), aperture_scale, fft_scale);
sv = getStarView(stars, psf, aperture_diam_in, wavelength_nm);
img = svGetImage(sv, extents_as * [-1 1; -1 1], app_vis_mag_limits);
imshow(img);
imwrite(img, [output_prefix input_name ' sv.png']);
% imwrite(img_primary, [output_prefix 'sv primary.png']);
% imwrite(img_secondary, [output_prefix 'sv secondary.png']);
% imwrite(img_both, [output_prefix 'sv both.png']);
sv_plot_props = getStarViewPlotDefaults;
sv_plot_props.plot_title = ['Ideal monochromatic view through ' aperture_title];
sv_plot_props.field_limits = extents_as .* [-1 1; -1 1];
sv_plot_props.output_limits = app_vis_mag_limits;
io_props.png_location = [output_prefix input_name ' sv plot.png'];
svPlot(sv, sv_plot_props, io_props);
