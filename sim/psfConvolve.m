function [convolved_psf] = psfConvolve(psf, ld_elements)

% ld_limits as [u1 v1 amp1; u2 v2 amp2; etc.]
% For simplicity, we keep the L/D bounds the same as the original PSF.

convolved_psf = psf;
convolved_psf.data = zeros(size(convolved_psf.data));
x_lim = size(convolved_psf.data, 1);
y_lim = size(convolved_psf.data, 2);

for i = 1:size(ld_elements, 1)
    x_shift = -round(ld_elements(i, 2) * psf.pixels_per_ld);
    y_shift =  round(ld_elements(i, 1) * psf.pixels_per_ld);
    
    for x = 1:size(psf.data, 1)
        if x + x_shift < 1 || x + x_shift > x_lim
            continue;
        end
        for y = 1:size(psf.data, 2)
            if (y + y_shift < 1 || y + y_shift > y_lim)
                continue;
            end
            convolved_psf.data(x + x_shift, y + y_shift) = ...
                convolved_psf.data(x + x_shift, y + y_shift) + ...
                ld_elements(i, 3) * psf.data(x, y);
        end
    end
end

% convolution_matrix(:,1) = ...
%     1 + round((ld_elements(:,1) - psf.ld_bounds(1)) * psf.pixels_per_ld); 
% convolution_matrix(:,2) = ...
%     1 + round((ld_elements(:,2) - psf.ld_bounds(2)) * psf.pixels_per_ld);
% 
% convolved_psf.data = conv2(psf.data, convolution_matrix, 'same');

end
