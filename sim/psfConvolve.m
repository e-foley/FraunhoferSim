function [convolved_psf] = psfConvolve(psf, ld_elements)

% ld_limits as [u1 v1 amp1; u2 v2 amp2; etc.]
% For simplicity, we keep the L/D bounds the same as the original PSF.

convolved_psf = psf;
convolved_psf.data = zeros(size(convolved_psf.data));
x_lim = size(convolved_psf.data, 1);
y_lim = size(convolved_psf.data, 2);

% Compose the image in different slices--one slice per convolution member.
for i = 1:size(ld_elements, 1)
    x_shift = -round(ld_elements(i, 2) * psf.pixels_per_ld);
    y_shift =  round(ld_elements(i, 1) * psf.pixels_per_ld);
    slice = psf.data;
    
    if (x_shift < 0)
        slice = slice(-x_shift+1:end, :);
        slice = padarray(slice, [-x_shift 0], 'post');
    else
        slice = slice(1:end-x_shift, :);
        slice = padarray(slice, [x_shift 0], 'pre');
    end
    
    if (y_shift < 0)
        slice = slice(:,-y_shift+1:end);
        slice = padarray(slice, [0 -y_shift], 'post');
    else
        slice = slice(:, 1:end-y_shift);
        slice = padarray(slice, [0 y_shift], 'pre');
    end
    
    convolved_psf.data = convolved_psf.data + ld_elements(i, 3) * slice;
end
