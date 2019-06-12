function [M] = formSineGrating(canvas_size_px, spatfreq, phase, angle)

% Creates a sinusoid at a given spatial frequency, phase, and propogation
% angle, TREATING TOP-LEFT CORNER AS (0, 0)

M = zeros(canvas_size_px);  % creates a matrix filled with zeros of size 'canvas_size_px'.

n = [-sin(angle) cos(angle)];  % finds normal unit vector for purposes of calculating distances

% loop through every element in the matrix
for i = 1:size(M, 1)
    for j = 1:size(M, 2)
        dist = dot([i j], n);  % perpendicular distance along direction of unit vector
        M(i, j) = sin(2*pi*spatfreq*dist + phase);  % magnitude is related to sine of dist
    end
end

end
