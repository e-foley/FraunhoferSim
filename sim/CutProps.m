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
        
        
        show_color_bar  % Whether to show color bars beside the plot
        color_maps  % Color maps to use for color bars {map1,map2,...,mapN}
        c_limits  % w-axis limits over which colorbar range is applied
        c_spacing  % Color bar tick spacing
        labels  % Legend entries describing plotted lines
        line_colors  % Line colors {[r1,g1,b1],[r2,g2,b2],...,[rN,gN,bN]}
        cut_line_thickness_pt  % Thickness of cut profile lines (points)
        font_size  %
        show_target
        target
        target_line_thickness_pt
        target_line_color
    end
end
