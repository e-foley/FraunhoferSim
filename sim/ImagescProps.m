classdef ImagescProps
    properties
        plot_title
        nominal_plot_size_px  % Plot size (pixels) [width,height]
        extra_title_margin
        field_limits  % [x1 x2; y1 y2]
        output_limits
        h_axis_title
        h_axis_tick_spacing
        v_axis_title
        v_axis_tick_spacing
        labels
        show_color_bar
        color_maps  % Color maps to use on plotted objects {map1,map2,...,mapN}
        font_size
    end
end
