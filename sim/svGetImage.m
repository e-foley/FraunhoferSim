function [image] = svGetImage(sv, new_as_bounds, app_vis_mag_limits)

% Do we need to normalize here??
image = -2.5 * log10(sv.data);

% Crop the field as close as possible to ld_bounds.
upx_min = 1 + floor(sv.pixels_per_as * (new_as_bounds(1,1) - sv.as_bounds(1,1)));
upx_max = 1 +  ceil(sv.pixels_per_as * (new_as_bounds(1,2) - sv.as_bounds(1,1)));
vpx_min = 1 + floor(sv.pixels_per_as * (new_as_bounds(2,1) - sv.as_bounds(2,1)));
vpx_max = 1 +  ceil(sv.pixels_per_as * (new_as_bounds(2,2) - sv.as_bounds(2,1)));
image = image(upx_min:upx_max, vpx_min:vpx_max);

% Map the log-10 magnitude limits to [0, 1]. No clamping is applied.
mag_delta = app_vis_mag_limits(2) - app_vis_mag_limits(1);
image = (image - app_vis_mag_limits(1)) / mag_delta;

% Rotate the image to same conventions as original aperture image.
image = rot90(image);

end
