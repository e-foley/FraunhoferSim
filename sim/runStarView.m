% Focus on below variables =====================================================

input_name = 'gaussian 35 donut with beam';
aperture_scale = 1.0;  % Default: 1.0
fft_scale = 8;  % Default: 8 (use with 1.0 aperture_scale for publishing)
star_separation_as = 9.4;
star_app_mags = [0 6.5];
star_angle = 90;
aperture_diam_in = 11;
wavelength_nm = 548;
extents_as = 20;
app_vis_mag_limits = [10 5];

% End important variables ======================================================

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