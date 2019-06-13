% Creates an image representing a mask with a rectangular area removed. The
% rectangle's edges are aligned to rows and columns of the matrix. No
% antialiasing is applied.
%
% canvas_size_px  Dimensions of the image to create (pixels) [height,width]
% rel_center      The coordinates of the center of the rectangle as a ratio of
%                 the larger canvas dimension [vert,horiz]
% rel_dims        The height and width of the rectangle as ratios of the larger 
%                 canvas dimension [height,width]
% 
% M               The resulting image, with transparent regions 1 and opaque
%                 regions 0 (2D array)

function [M] = formRectangle(canvas_size_px, rel_center, rel_dims)
    M = zeros(canvas_size_px);
    max_dim_px = max(canvas_size_px);
    
    % Calculate center and bounds.
    center = ((canvas_size_px + 1) / 2) + max_dim_px .* rel_center;
    top =    max(center(1) - max_dim_px * rel_dims(1) / 2, 1);
    bottom = min(center(1) + max_dim_px * rel_dims(1) / 2, canvas_size_px(1));
    left =   max(center(2) - max_dim_px * rel_dims(2) / 2, 1);
    right =  min(center(2) + max_dim_px * rel_dims(2) / 2, canvas_size_px(2));
    
    % Populate regions contained by bounds.
    M(floor(top):ceil(bottom),floor(left):ceil(right)) = 1;
end
