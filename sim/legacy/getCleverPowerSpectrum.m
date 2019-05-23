function [xfm, reduced_size, fft_size] = getCleverPowerSpectrum(input, psf_props)

p = psf_props;  % Shorthand

% Reduce dims of the mask/aperture so FFT uses less memory after padding.
reduced = imresize(input, p.input_scale);
reduced_size = size(reduced);
fft_size = p.fft_scale * reduced_size;

% Find characteristic FFT of this mask/aperture (not power spectrum yet).
xfm = fftshift(fft2(reduced, fft_size(1), fft_size(2)));

% Generate convolution pattern.
convmat = ldToConvMat(p.ld_conv, p.fft_scale);

if (p.is_coherent)
    % Coherent light interferes with itself regularly because it has a
    % constant phase difference, so we convolve the raw Fourier transform
    % with the light source pattern.
    xfm = conv2(xfm, convmat);
    % Actually take the power spectrum.
    xfm = abs(xfm) .^ 2;
else
    % Incoherent light interferes with itself quickly and unpredictably, so
    % we find the PSF first and convolve it to imply we're adding the light
    % together. (Is this kosher?)
    xfm = abs(xfm) .^ 2;
    % Convolve the PSF with the input pattern, effectively adding the
    % patterns together.
    xfm = conv2(xfm, convmat);
end
end
