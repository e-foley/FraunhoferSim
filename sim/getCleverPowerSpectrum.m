function [xfm, reduced_size, fft_size] = getCleverPowerSpectrum(input, psf_props)

p = psf_props;  % Shorthand

% Reduce dims of the mask/aperture so FFT uses less memory after padding
reduced = imresize(input, p.input_scale);
reduced_size = size(reduced);
fft_size = p.fft_scale * reduced_size;

% Find characteristic FFT of this mask/aperture (not power spectrum yet)
xfm = fftshift(fft2(reduced, fft_size(1), fft_size(2)));

% Convolve the FFT with whatever pattern of stars, etc. we please
convmat = ldToConvMat(p.ld_conv, p.fft_scale);

% Note this is relative to xfm's scale...
xfm = conv2(xfm, convmat);

% Actually take the power spectrum
xfm = abs(xfm) .^ 2;

end
