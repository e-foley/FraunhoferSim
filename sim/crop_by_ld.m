% Assumes LD=(0,0) is at center of image
function [cropped] = crop_by_ld(original, ld_lim, px_per_ld)

%ld_spans = (size(xfm) / fft_scale);
%ld_bounds = (ld_spans ./ 2)' * [-1 1];  % the range of lambda/D shown over whole image

% frame_top =    round(1 + (size(original, 1) * (0.5 + 0.5 * ld_lim / ld_bounds(1, 1))));
% frame_bottom = round(1 + (size(original, 1) * (0.5 + 0.5 * ld_lim / ld_bounds(1, 2))));
% frame_left =   round(1 + (size(original, 2) * (0.5 + 0.5 * ld_lim / ld_bounds(2, 1))));
% frame_right =  round(1 + (size(original, 2) * (0.5 + 0.5 * ld_lim / ld_bounds(2, 2))));

ld_bounds = [-ld_lim ld_lim; -ld_lim ld_lim];

frame_top =    round(1 + 0.5 * size(original, 1) + ld_bounds(1, 1) * px_per_ld);
frame_bottom = round(1 + 0.5 * size(original, 1) + ld_bounds(1, 2) * px_per_ld);
frame_left =   round(1 + 0.5 * size(original, 2) + ld_bounds(2, 1) * px_per_ld);
frame_right =  round(1 + 0.5 * size(original, 2) + ld_bounds(2, 2) * px_per_ld);

% round(1 + (size(original, 1) * (0.5 + 0.5 * ld_lim / ld_bounds(1, 1))));
% frame_bottom = round(1 + (size(original, 1) * (0.5 + 0.5 * ld_lim / ld_bounds(1, 2))));
% frame_left =   round(1 + (size(original, 2) * (0.5 + 0.5 * ld_lim / ld_bounds(2, 1))));
% frame_right =  round(1 + (size(original, 2) * (0.5 + 0.5 * ld_lim / ld_bounds(2, 2))));

cropped = original(frame_top:frame_bottom, frame_left:frame_right);

end