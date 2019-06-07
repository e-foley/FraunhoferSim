% Properties related to plotting horizontal cuts through a point spread
% function.

classdef CutProps
    properties
        % Title of the plot
        plot_title = 'Horizontal PSF cut'
        
        % Nominal plot size (pixels) [width,height]. MATLAB may adapt the
        % numbers in unexpected ways.
        nominal_plot_size_px = [620 528]
        
        % Fudge factor for vertically aligning plot title
        extra_title_margin = 0.14
        
        % u-axis label, axis limits [low,high], and tick spacing
        u_title = '{\itu} [{\it\lambda}/{\itD}]'
        u_limits = [0 12]
        u_spacing = 2
        
        % w-axis label, axis limits [low,high], and tick spacing
        w_title = 'log_1_0 contrast'
        w_limits = [-8 0]
        w_spacing = 1
        
        % Whether to show color bars beside the plot
        show_color_bars = false
        
        % Color maps to use for color bars {map1,map2,...,mapN}
        color_maps = {}
        
        % w-axis limits over which colorbar range is applied
        c_limits = [-4 -1]
        
        % Color bar tick spacing
        c_spacing = 1
        
        % Legend entries describing plotted lines {label1,label2,...,labelN}
        labels = {'Aperture'}
        
        % Line colors {[r1,g1,b1],[r2,g2,b2],...,[rN,gN,bN]}
        line_colors = [0 0 0]
        
        % Thickness of cut profile lines (points)
        cut_line_thickness_pt = 2
        
        % Font size of all text in figure (points)
        font_size_pt = 14
        
        % Whether to draw a horizontal "contrast target" line on the plot
        show_target = false
        
        % The place along the w-axis to draw a contrast target line
        target = -2.6
        
        % Thickness of target line (points) and its color [r,g,b]
        target_line_thickness_pt = 1
        target_line_color = [0.4 0.4 0.4]
    end
end
