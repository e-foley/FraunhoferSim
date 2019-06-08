% Generates the characteristic point spread function corresponding to a given
% aperture. The function interprets the entirety of the aperture image,
% including any opaque padding, as the aperture for the purpose of calculating
% the aperture's size.
%
% aperture        The image representing the entirety of the aperture, where
%                 white pixels indicate tansparent regions and black pixels
%                 indicate opaque areas. Grayscale values convey translucency.
% aperture_scale  The factor the function will use to scale the aperture image
%                 before the fast Fourier transform is taken. Smaller factors
%                 greatly improve speed at the cost of introducing aliasing
%                 noise into the point spread function.
% fft_scale       The dimensions the scaled aperture image will be padded to
%                 as a ratio of the scaled aperture image size. Larger fft_scale
%                 values improve point spread function resolution but
%                 significantly increase computation time.
%
% psf                 A Psf object representing the point spread function
%                     created by the aperture
% scaled_aperture_px  The dimensions of the aperture image after it was scaled
%                     scaled by aperture_scale (pixels) [height,width]
% fft_size_px         The dimensions of the fast Fourier transform output
%                     (pixels) [height,width]

function [psf, scaled_aperture_size_px, fft_size_px] = ...
    getPsf(aperture, aperture_scale, fft_scale)

psf = Psf;

% Convert to grayscale if necessary.
if (size(aperture, 3) > 1)
    aperture = rgb2gray(aperture);
end

% Scale dims of the mask/aperture. Scaling down allows FFT to use less memory.
% We rotate the matrix such that we can store the PSF with (u, v) indices.
scaled_aperture = imresize(aperture, aperture_scale);
scaled_aperture_size_px = size(scaled_aperture);
scaled_aperture = rot90(scaled_aperture, 3);
fft_size_px = fft_scale * [1 1] * max(size(scaled_aperture));

% Find FFT of this mask/aperture (not power spectrum yet), padding the FFT to
% dimensions of fft_size_px and placing zero-frequency component in the center
% of the image.
psf.data = fftshift(fft2(scaled_aperture, fft_size_px(1), fft_size_px(2)));

% Power spectrum is the square of the complex amplitude.
psf.data = abs(psf.data) .^ 2;

% With unity FFT scale, 1.0 lambda/D is lowest resolvable frequency; larger FFT
% scales give better resolution.
psf.pixels_per_ld = fft_scale;

% Calculating bounds is slightly tricky because fftshift places zero-frequency
% to lower-right of center when dimension is even.
psf.ld_bounds(:,2) = floor((fft_size_px' - 1) / 2);
psf.ld_bounds(:,1) = psf.ld_bounds(:,2) - fft_size_px' + 1;
psf.ld_bounds = psf.ld_bounds / fft_scale;

end
