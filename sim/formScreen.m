% Creates an image representing a mask with alternating opaque and transparent
% ridges aligned with the vertical axis. The function operates on parameters
% provided in pixels rather than as ratios of the canvas size like other
% functions, so it is best for specialized, precise use cases.
%
% canvas_size_px  Dimensions of the image to create (pixels) [height,width]
% line_width_px   Width of each opaque line (pixels)
% spacing_px      Spacing between opaque lines, including their width (pixels)
%
% M               The resulting image, with transparent regions 1 and opaque
%                 regions 0 (2D array)

function [M] = formScreen(canvas_size_px, line_width_px, spacing_px)
    M = ones(canvas_size_px, 'logical');
    for i = 1:line_width_px
        M(:,i:spacing_px:canvas_size_px) = 0;
    end
end
