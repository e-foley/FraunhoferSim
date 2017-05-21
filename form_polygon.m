function [ M ] = form_polygon( img_size, max_rel_radius, num_sides, delta_rot)

M = zeros(img_size);
theta = deg2rad(delta_rot) + linspace(0, 2*pi, num_sides + 1);
x = img_size / 2 + img_size * max_rel_radius * cos(theta);
y = img_size / 2 - img_size * max_rel_radius * sin(theta);  % minus sign converts raster->Cartesian
M = poly2mask(x, y, img_size, img_size);

end