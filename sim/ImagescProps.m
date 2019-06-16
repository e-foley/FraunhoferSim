% Properties for formatting plots created from the imagesc function.
% ImagescProps objects are used as an input to several functions that produce
% plots, including plotAperture, psfPlot, and svPlot.

classdef ImagescProps
    properties
        % Title of the plot
        plot_title
        
        % Nominal plot size (pixels) [width,height]. MATLAB may adapt the
        % numbers in unexpected ways.
        nominal_plot_size_px
        
        % Fudge factor for vertically aligning plot title 
        extra_title_margin
        
        % Bounds of plot domain--i.e. what to crop the plot to [x1,x2;y1,y2]
        field_limits
        
        % Range of dependent axis values to display [low,high]. This also
        % determines how colors are mapped to these values. 
        output_limits
        
        % Horizontal axis title and tick spacing
        h_axis_title
        h_axis_tick_spacing
        
        % Vertical axis title and tick spacing
        v_axis_title
        v_axis_tick_spacing
        
        % Legend entries describing plotted objects {label1,label2,...,labelN}
        labels

        % Whether to show color bars beside the plot
        show_color_bars
        
        % Color maps to use for plotted objects {map1,map2,...,mapN}
        color_maps

        % Font size of all text in figure (points)
        font_size_pt
    end
end
