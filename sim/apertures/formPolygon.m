function [M] = formPolygon(canvas_size_px, max_rel_radius, num_sides, delta_rot)

M = zeros(canvas_size_px);
theta = deg2rad(delta_rot) + linspace(0, 2*pi, num_sides + 1);
x = canvas_size_px / 2 + canvas_size_px * max_rel_radius * cos(theta);
y = canvas_size_px / 2 - canvas_size_px * max_rel_radius * sin(theta);  % minus sign converts raster->Cartesian
M = poly2mask(x, y, canvas_size_px, canvas_size_px);

end
