% Focus on below variables =====================================================

% 1 is base; 2 is addition
input1_name = 'bowtie';  % Aperture image file name less extension
input2_name = 'gaussian 50 donut 120';
aperture1_title = 'bowtie';  % Shows up in plot titles
aperture2_title = 'Gaussian boomerang';
aperture_scale = 0.25;  % Default: 0.25
fft_scale = 32;  % Defaults: 16 (draft), 32 (publishing)
ld_bound = 12;  % Max magnitude of u and v dimensions in PSF plots; default: 12
mag_lims_psf = [-4 -1];  % Default: [-4 -1]
mag_lims_cut = [-8 0];  % Default: [-8 0]
show_target = true;  % Default: false
labels = {aperture1_title aperture2_title};

% End important variables ======================================================

io_props = IoProps;
io_props.save_png = true;
io_props.save_eps = false;
input_prefix = 'apertures/';
output_prefix = 'plots/';
aperture1 = imread([input_prefix input1_name '.png']);
aperture2 = imread([input_prefix input2_name '.png']);
psf1 = getPsf(aperture1, aperture_scale, fft_scale);
psf2 = getPsf(aperture2, aperture_scale, fft_scale);
psf_plot_props = getPsfPlotDefaults;
psf_plot_props.plot_title = 'Point spread function comparison';
psf_plot_props.field_limits = ld_bound .* [-1 1; -1 1];
psf_plot_props.output_limits = mag_lims_psf;
psf_plot_props.color_maps = {[1 0 1] .* gray(256) [0 1 0] .* gray(256)};
psf_plot_props.labels = labels;
io_props.png_location = [output_prefix input2_name ' vs ' input1_name ' psf plot.png'];
close(psfPlot([psf1 psf2], psf_plot_props, io_props));
cut_props = CutProps;
%cut_props.plot_title = ['Horizontal PSF cut of ' aperture_title];
cut_props.plot_title = '';
cut_props.u_limits = [0 ld_bound];
cut_props.w_limits = mag_lims_cut;
cut_props.show_color_bars = true;
cut_props.color_maps = psf_plot_props.color_maps;
cut_props.c_limits = mag_lims_psf;
cut_props.show_target = show_target;
cut_props.labels = labels;
cut_props.font_size_pt = 14;
cut_props.line_colors = {cut_props.color_maps{1}(end,:) cut_props.color_maps{2}(end,:)};
io_props.png_location = [output_prefix input2_name ' vs ' input1_name ' psf cut.png'];
%close(psfCut(psf, cut_props, io_props));
psfCut([psf1 psf2], cut_props, io_props);