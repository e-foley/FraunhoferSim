function [ mat ] = form_sine_grating(dims, spatfreq, phase, angle)

% Creates a sinusoid at a given spatial frequency, phase, and propogation
% angle, TREATING TOP-LEFT CORNER AS (0, 0)

mat = zeros(dims);  % creates a matrix filled with zeros of size 'dims'.

n = [-sin(angle) cos(angle)];  % finds normal unit vector for purposes of calculating distances

% loop through every element in the matrix
for i = 1:size(mat, 1)
    for j = 1:size(mat, 2)
        dist = dot([i j], n);  % perpendicular distance along direction of unit vector
        mat(i, j) = sin(2*pi*spatfreq*dist + phase);  % magnitude is related to sine of dist
    end
end

end