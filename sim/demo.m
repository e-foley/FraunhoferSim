% Demonstration script that shows how to generate mask figures and diffraction
% pattern figure for the C11 aperture and bowtie mask. Plots will be created as
% figures and saved in Portable Network Graphics (PNG) format in a "plots"
% folder.
%
% Prerequisites: folders called "apertures" and "plots" exist in the same
% directory as this script; "apertures" folder contains at least a file called
% "bowtie.png".
%
% Script tested using MATLAB R2018a with the Image Processing Toolbox.

% Clear existing variables and figures for repeatibility reasons.
clearvars;
close all;

% Define miscellaneous input and output variables.
input_prefix = 'apertures/';
output_prefix = 'plots/';
io_props = IoProps;
io_props.save_png = true;
io_props.save_eps = false;

% Generate our aperture shapes, including the C11.
makeApertures;

% Load images corresponding to the C11 aperture and bowtie mask.
c11_aperture = imread([input_prefix 'c11.png']);
bowtie_mask = imread([input_prefix 'bowtie.png']);

% Generate plots of the C11 aperture and bowtie mask.
aperture_plot_props = getAperturePlotDefaults;
aperture_plot_props.plot_title = 'C11 aperture';
io_props.png_location = [output_prefix 'c11 aperture plot.png'];
plotAperture(c11_aperture, aperture_plot_props, io_props);
aperture_plot_props.plot_title = 'Bowtie mask';
io_props.png_location = [output_prefix 'bowtie mask plot.png'];
plotAperture(bowtie_mask, aperture_plot_props, io_props);

% Calculate PSFs for the C11 aperture and bowtie mask and store them in objects.
% (We will feed these objects into functions that plot them in different ways.)
aperture_scale = 0.25;  % Lower: faster execution, less accurate
fft_scale = 8;  % Higher: better resolution, slower processing
c11_psf = getPsf(c11_aperture, aperture_scale, fft_scale);
bowtie_psf = getPsf(bowtie_mask, aperture_scale, fft_scale);

% Plot the individual PSFs of the C11 aperture and bowtie mask.
psf_plot_props = getPsfPlotDefaults;
psf_plot_props.plot_title = 'Ideal monochromatic, on-axis PSF of C11 aperture';
io_props.png_location = [output_prefix 'c11 psf plot.png'];
psfPlot(c11_psf, psf_plot_props, io_props);
psf_plot_props.plot_title = 'Ideal monochromatic, on-axis PSF of bowtie mask';
io_props.png_location = [output_prefix 'bowtie psf plot.png'];
psfPlot(bowtie_psf, psf_plot_props, io_props);

% Plot horizontal cuts of our two PSFs.
cut_plot_props = CutProps;
cut_plot_props.labels = {'C11 aperture'};
io_props.png_location = [output_prefix 'c11 cut plot.png'];
psfCut(c11_psf, cut_plot_props, io_props);
cut_plot_props.labels = {'bowtie mask'};
io_props.png_location = [output_prefix 'bowtie cut plot.png'];
psfCut(bowtie_psf, cut_plot_props, io_props);

% Create a figure showing one PSF overlaid on the other. This is as simple as
% supplying both Psf objects and appropriate colors to psfPlot.
psf_plot_props.plot_title = 'PSF comparison';
% Show C11 in shades of fuchsia, bowtie in shades of green.
psf_plot_props.color_maps = {[1 0 1] .* gray(256), [0 1 0] .* gray(256)};
psf_plot_props.labels = {'C11 aperture', 'bowtie mask'};
io_props.png_location = [output_prefix 'c11 bowtie psf comparison plot.png'];
psfPlot([c11_psf bowtie_psf], psf_plot_props, io_props);

% Create a figure showing one PSF "cut plot" overlaid on the other. Again, this
% is as simple as supplying both Psf objects, colors and labels.
cut_plot_props.plot_title = 'PSF horizontal cut comparison';
cut_plot_props.show_color_bars = true;
cut_plot_props.color_maps = psf_plot_props.color_maps;
cut_plot_props.labels = psf_plot_props.labels;
cut_plot_props.line_colors = {[1 0 1], [0 1 0]};
io_props.png_location = [output_prefix 'c11 bowtie cut comparison plot.png'];
psfCut([c11_psf bowtie_psf], cut_plot_props, io_props);

% Create two objects that represent visualizing a binary system through the C11
% aperture and through the bowtie mask. This takes a few steps, but it's worth
% it. First, define the telescope diameter and light wavelength (so we know what
% lambda/D actually is).
telescope_diameter_in = 11;  % (inches)
wavelength_nm = 680;  % (nanometers)
% Then, define properties of our double-star system. Let's use Lambda Cygni.
% (Properties from https://en.wikipedia.org/wiki/Lambda_Cygni.)
separation_as = 0.77;  % (arcseconds)
app_vis_mags = [4.54 6.26];  % apparent visual magnitudes (not log-10)
pa_deg = 90;  % position angle (degrees) -- pretend it's 90 to align with mask
stars = asterismFromDouble(separation_as, app_vis_mags, pa_deg);
% Generate the actual StarView objects, which are used in analagous ways as Psf
% objects.
c11_sv = getStarView(stars, c11_psf, telescope_diameter_in, wavelength_nm);
bowtie_sv = getStarView(stars, bowtie_psf, telescope_diameter_in, wavelength_nm);

% Now we plot the StarView objects, setting up a few display properties first.
sv_plot_props = getStarViewPlotDefaults;
sv_plot_props.output_limits = [10 4];
sv_plot_props.plot_title = 'Monochromatic view of stars through C11 aperture';
io_props.png_location = [output_prefix 'c11 star view plot.png'];
svPlot(c11_sv, sv_plot_props, io_props);
sv_plot_props.plot_title = 'Monochromatic view of stars through bowtie mask';
io_props.png_location = [output_prefix 'bowtie star view plot.png'];
svPlot(bowtie_sv, sv_plot_props, io_props);
