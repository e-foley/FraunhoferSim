function [cropped_psf] = psfCrop(psf, new_ld_bounds)

% Note: cropping is subject to rounding errors.

cropped_psf = psf;

upx_min = 1 + floor(psf.pixels_per_ld * (new_ld_bounds(1,1) - psf.ld_bounds(1,1)));
upx_max = 1 +  ceil(psf.pixels_per_ld * (new_ld_bounds(1,2) - psf.ld_bounds(1,1)));
vpx_min = 1 + floor(psf.pixels_per_ld * (new_ld_bounds(2,1) - psf.ld_bounds(2,1)));
vpx_max = 1 +  ceil(psf.pixels_per_ld * (new_ld_bounds(2,2) - psf.ld_bounds(2,1)));

cropped_psf.data = psf.data(upx_min:upx_max, vpx_min:vpx_max);
cropped_psf.ld_bounds = new_ld_bounds;

end
