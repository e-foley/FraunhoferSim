% Creates an image representing a gradiated mask whose translucency varies
% sinusoidally along a specified axis at a specified spatial frequency and
% phase.
%
% canvas_size_px     Dimensions of the image to create (pixels) [height,width]
% frequency_1_px     The spacial frequency of the sinusoidal function (1/pixel)
% phase_deg          The phase of the sinusoid (degrees). The image's top-left
%                    pixel's translucency is effectively calculated using this
%                    value as its angle.
% grating_angle_deg  The orientation of the sine grating (degrees). When 0, the
%                    spatial wave "propogates" along the horizontal axis to form
%                    vertical bars. A positive value rotates the grating
%                    counterclockwise.
%
% M                  A 2D matrix representing the sine grating image, with
%                    transparent areas 1, opaque areas 0, and translucent
%                    regions somewhere between 0 and 1.

function [M] = formSineGrating(canvas_size_px, frequency_1_px, phase_deg, ...
    grating_angle_deg)
M = zeros(canvas_size_px);

% Find normal unit vector for purpose of calculating distances.
n = [-sind(grating_angle_deg) cosd(grating_angle_deg)];

% For every element in matrix, find the distance along the direction of the unit
% vector by projecting the indices onto it. Use that distance to calculate our
% progression through the sine wave.
for i=1:size(M,1)
    for j=1:size(M, 2)
        dist_px = dot([i j] - 1, n);
        M(i,j) = 0.5 + 0.5 * sind(360 * frequency_1_px * dist_px + phase_deg);
    end
end

end
