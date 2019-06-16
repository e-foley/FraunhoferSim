% Generates a default ImagescProps object configured for PSF plots. The object
% can be supplied to the psfPlot function.
%
% defaults  The default ImagescProps object configured for PSF plots.

function [defaults] = getPsfPlotDefaults
defaults = ImagescProps;
defaults.plot_title = 'Power spectrum';
defaults.nominal_plot_size_px = [660 528];
defaults.extra_title_margin = 0.5;
defaults.field_limits = [-12 12; -12 12];
defaults.output_limits = [-4 -1];
defaults.h_axis_title = '{\itu} [{\it\lambda}/{\itD}]';
defaults.h_axis_tick_spacing = 2;
defaults.v_axis_title = '{\itv} [{\it\lambda}/{\itD}]';
defaults.v_axis_tick_spacing = 2;
defaults.labels = {};
defaults.show_color_bars = true;
defaults.color_maps = {hot(256)};
defaults.font_size_pt = 14;
end
