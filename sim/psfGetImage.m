function [image] = psfGetImage(psf, log_10_mag_limits)

% Log-normalize the power spectrum.
image = log10(psf.data ./ max(max(psf.data)));

% Map the log-10 magnitude limits to [0, 1]. No clamping is applied.
mag_delta = log_10_mag_limits(2) - log_10_mag_limits(1);
image = (image - log_10_mag_limits(1)) / mag_delta;

end
