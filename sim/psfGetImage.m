function [cropped_image] = psfGetImage(psf, new_ld_bounds, log_10_mag_limits, normalization_value)

% Log-normalize the power spectrum. Use the maximum value if a
% normalization value is not provided.
if nargin < 4
    normalization_value = max(max(psf.data));
end

image = log10(psf.data ./ normalization_value);

% Crop the spectrum as close as possible to ld_bounds.
upx_min = 1 + floor(psf.pixels_per_ld * (new_ld_bounds(1,1) - psf.ld_bounds(1,1)));
upx_max = 1 +  ceil(psf.pixels_per_ld * (new_ld_bounds(1,2) - psf.ld_bounds(1,1)));
vpx_min = 1 + floor(psf.pixels_per_ld * (new_ld_bounds(2,1) - psf.ld_bounds(2,1)));
vpx_max = 1 +  ceil(psf.pixels_per_ld * (new_ld_bounds(2,2) - psf.ld_bounds(2,1)));
cropped_image = image(upx_min:upx_max, vpx_min:vpx_max);

% Map the log-10 magnitude limits to [0, 1]. No clamping is applied.
mag_delta = log_10_mag_limits(2) - log_10_mag_limits(1);
cropped_image = (cropped_image - log_10_mag_limits(1)) / mag_delta;

% Rotate the image to same conventions as original aperture image.
cropped_image = rot90(cropped_image);

end
