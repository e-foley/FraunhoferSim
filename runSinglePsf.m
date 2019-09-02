% Focus on below variables =====================================================

input_name = 'gaussian 50 donut 160';  % Aperture image file name less extension
aperture_title = 'Gaussian boomerang';  % Shows up in plot titles
aperture_scale = 1.0;  % Default: 1.0 (can use 0.25 for draft)
fft_scale = 8;  % Default: 8
ld_bound = 12;  % Max magnitude of u and v dimensions in PSF plots; default: 12
mag_lims_psf = [-4 -1];  % Default: [-4 -1]
mag_lims_cut = [-8 0];  % Default: [-8 0]
show_target = true;  % Default: true
target = -2.8;  % Default: -2.8
labels = {aperture_title};

% End important variables ======================================================

input_prefix = 'apertures/';
output_prefix = 'plots/';
io_props = IoProps;
io_props.save_png = true;
io_props.save_eps = false;
io_props.png_location = [output_prefix input_name ' psf plot.png'];
aperture = imread([input_prefix input_name '.png']);
[psf, scaled_aperture_size_px, fft_size_px] = ...
    getPsf(aperture, aperture_scale, fft_scale);
psf_image = psfGetImage(psf, ld_bound .* [-1 1; -1 1], mag_lims_psf);
imwrite(psf_image, [output_prefix input_name ' psf.png']);
psf_plot_props = getPsfPlotDefaults;
psf_plot_props.plot_title = ['Ideal monochromatic, on-axis PSF of ' aperture_title];
psf_plot_props.field_limits = ld_bound .* [-1 1; -1 1];
psf_plot_props.output_limits = mag_lims_psf;
close(psfPlot(psf, psf_plot_props, io_props));
cut_props = CutProps;
cut_props.plot_title = ['Horizontal PSF cut of ' aperture_title];
cut_props.u_limits = [0 ld_bound];
cut_props.w_limits = mag_lims_cut;
cut_props.show_color_bars = true;
cut_props.color_maps = gray(256);
cut_props.c_limits = mag_lims_psf;
cut_props.show_target = show_target;
cut_props.target = target;
cut_props.labels = labels;
cut_props.font_size_pt = 18;
io_props.png_location = [output_prefix input_name ' psf cut.png'];
close(psfCut(psf, cut_props, io_props));
savePsfSpecs(size(aperture), aperture_scale, scaled_aperture_size_px, ...
    fft_scale, fft_size_px, [output_prefix input_name ' psf specs.txt']);
