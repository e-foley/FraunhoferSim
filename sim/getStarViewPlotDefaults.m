% Generates a default ImagescProps object configured for StarView plots. The
% object can be supplied to the svPlot function.
%
% defaults  The default ImagescProps object configured for StarView plots.
function [defaults] = getStarViewPlotDefaults
defaults = ImagescProps;
defaults.plot_title = 'Simulated monochromatic view';
defaults.nominal_plot_size_px = [620 528];
defaults.extra_title_margin = 0.1;
defaults.field_limits = [-5 5; -5 5];
defaults.output_limits = [10 2];
defaults.h_axis_title = '{\itu} [as]';
defaults.h_axis_tick_spacing = 1;
defaults.v_axis_title = '{\itv} [as]';
defaults.v_axis_tick_spacing = 1;
defaults.labels = {};
defaults.show_color_bars = true;
defaults.color_maps = {bone(256)};
defaults.font_size_pt = 14;
end
