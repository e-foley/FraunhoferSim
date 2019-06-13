% Creates an mask with a regular-polygonal-shaped transparent region at its
% center. The size, number of sides, and orientation of the polygon can be
% configured along with the size of the image.
%
% canvas_size_px  Dimensions of the image to create (pixels) [height,width]
% max_rel_radius  The radius of the circle circumscribing the polygon as a ratio
%                 of the greater dimension of the canvas
% num_sides       The number of sides the polygon has
% rot_deg         The angle at which the first vertex is placed relative to the
%                 origin (degrees)
%
% M               The resulting image, with transparent regions 1 and opaque
%                 regions 0 (2D array)

function [M] = formPolygon(canvas_size_px, max_rel_radius, num_sides, rot_deg)
max_dim_px = max(canvas_size_px);

% Mark vertices along the circumfrence of the bounding circle. We first
% calculate the angles at which these vertices will appear, then do basic trig
% to find the (x,y) coordinates.
theta = deg2rad(rot_deg) + linspace(0, 2*pi, num_sides + 1);

% Minus sign below converts raster coordinates to Cartesian coordinates.
v = (1 + canvas_size_px(1)) / 2 - max_dim_px * max_rel_radius * sin(theta);
h = (1 + canvas_size_px(2)) / 2 + max_dim_px * max_rel_radius * cos(theta);

% MATLAB's poly2mask function does all the heavy lifting. The function's x and y
% parameters act in Cartesian space unlike most MATLAB functions.
M = poly2mask(h, v, canvas_size_px(1), canvas_size_px(2));

end
