function [image] = psfGetImage(psf, log_10_mag_limits, normalization_value)

% Log-normalize the power spectrum. Use the maximum value if a
% normalization value is not provided.
if nargin < 3
    normalization_value = max(max(psf.data));
end

image = log10(psf.data ./ normalization_value);

% Map the log-10 magnitude limits to [0, 1]. No clamping is applied.
mag_delta = log_10_mag_limits(2) - log_10_mag_limits(1);
image = (image - log_10_mag_limits(1)) / mag_delta;

end
