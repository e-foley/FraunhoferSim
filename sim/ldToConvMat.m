function [convmat] = ldToConvMat(LD, fft_scale)

pixels_per_LD = fft_scale;

coords = zeros(size(LD, 1), 2);
for i=1:size(LD, 1)
    % raw pixel coords--can be negative for the moment
    coords(i, 1) = round(-pixels_per_LD * LD(i, 2));  % raster "x" (vert)
    coords(i, 2) = round( pixels_per_LD * LD(i, 1));  % raster "y" (horiz)
end

% below transformations ensure odd-numbered dimensions
height = 2 * (max(max(coords(:, 1)), -min(coords(:, 1)))) + 1;
width =  2 * (max(max(coords(:, 2)), -min(coords(:, 2)))) + 1;

% TEMPORARY!
% two lines below seem to preserve aspect ratio during imagesc step...
height = max(height, width);
width = height;

convmat = zeros(height, width);

horiz_shift = round((width - 1) / 2 + 1);  % should already be an integer, but round for assurance
vert_shift = round((height - 1) / 2 + 1);  % should already be an integer, but round for assurance

for i=1:size(LD, 1)
    convmat(vert_shift + coords(i, 1), horiz_shift + coords(i, 2)) = LD(i, 3);
end

end