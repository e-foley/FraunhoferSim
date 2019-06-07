classdef ImagescProps
    properties
        % Title of the plot
        plot_title = 'Power spectrum'
        
        % Nominal plot size (pixels) [width,height]. MATLAB may adapt the
        % numbers in unexpected ways.
        nominal_plot_size_px = [660 528]
        
        % Fudge factor for vertically aligning plot title 
        extra_title_margin = 0.5
        
        % Bounds of plot domain--i.e. what to crop the plot to [x1,x2;y1,y2]
        field_limits = [-12 12; -12 12]
        
        % Range of dependent axis values to display [low,high]. This also
        % determines how colors are mapped to these values. 
        output_limits = [-4 -1]
        
        % Horizontal axis title and tick spacing
        h_axis_title = '{\itu} [{\it\lambda}/{\itD}]'
        h_axis_tick_spacing = 2
        
        % Vertical axis title and tick spacing
        v_axis_title = '{\itv} [{\it\lambda}/{\itD}]'
        v_axis_tick_spacing = 2
        
        % Legend entries describing plotted objects {label1,label2,...,labelN}
        labels = {'Aperture'}

        % Whether to show color bars beside the plot
        show_color_bars = true
        
        % Color maps to use for plotted objects {map1,map2,...,mapN}
        color_maps = {hot(256)}

        % Font size of all text in figure (points)
        font_size_pt = 14
    end
end
