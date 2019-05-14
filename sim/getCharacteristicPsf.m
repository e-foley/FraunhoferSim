function [psf, scaled_input_size, fft_size] = ...
    getCharacteristicPsf(aperture, input_scale, fft_scale)

psf = Psf;

% Scale dims of the mask/aperture. Scaling down allows FFT to use less memory.
scaled_aperture = imresize(aperture, input_scale);
scaled_input_size = size(scaled_aperture);
fft_size = fft_scale * scaled_input_size;

% Find FFT of this mask/aperture (not power spectrum yet), padding the FFT
% to dimensions of fft_size and placing zero-frequency component in the
% center of the image.
psf.data = fftshift(fft2(scaled_aperture, fft_size(1), fft_size(2)));

% Power spectrum is the square of the complex amplitude.
psf.data = abs(psf.data) .^ 2;

% With unity FFT scale, 1.0 lambda/D is lowest resolvable frequency; larger
% FFT scales give better resolution.
psf.pixels_per_ld = fft_scale;

% Calculating bounds is slightly tricky because fftshift places
% zero-frequency to lower-right of center when dimension is even.
psf.ld_bounds(:,2) = floor((fft_size' - 1) / 2);
psf.ld_bounds(:,1) = psf.ld_bounds(:,2) - fft_size' + 1;

end
