% Generates a default ImagescProps object configured for aperture plots. The
% object can be supplied to the plotAperture function.
%
% defaults  The default ImagescProps object configured for aperture plots.

function [defaults] = getAperturePlotDefaults
defaults = ImagescProps;
defaults.plot_title = '';
defaults.nominal_plot_size_px = [620 528];
defaults.extra_title_margin = 0.02;
defaults.field_limits = [-0.5 0.5; -0.5 0.5];
defaults.output_limits = [0 1];
defaults.h_axis_title = '{\itx}'' ({\itx}/{\itD})';
defaults.h_axis_tick_spacing = 0.1;
defaults.v_axis_title = '{\ity}'' ({\ity}/{\itD})';
defaults.v_axis_tick_spacing = 0.1;
defaults.labels = {};
defaults.show_color_bars = false;
defaults.color_maps = gray(256);
defaults.font_size_pt = 14;
end
