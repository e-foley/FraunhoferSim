function [cropped_psf] = psfCrop(psf, new_ld_bounds)

% Note: cropping is subject to rounding errors.

cropped_psf = psf;

top    = 1 + floor(psf.pixels_per_ld * (new_ld_bounds(1,1) - psf.ld_bounds(1,1)));
bottom = 1 +  ceil(psf.pixels_per_ld * (new_ld_bounds(1,2) - psf.ld_bounds(1,1)));
left   = 1 + floor(psf.pixels_per_ld * (new_ld_bounds(2,1) - psf.ld_bounds(2,1)));
right  = 1 +  ceil(psf.pixels_per_ld * (new_ld_bounds(2,2) - psf.ld_bounds(2,1)));

cropped_psf.data = psf.data(top:bottom, left:right);
cropped_psf.ld_bounds = new_ld_bounds;

end
