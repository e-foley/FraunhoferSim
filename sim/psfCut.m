function [u, w] = psfCut(psf, u_ld_bounds)

upx_min = 1 + round(psf.pixels_per_ld * (u_ld_bounds(1) - psf.ld_bounds(1,1)));
upx_max = 1 + round(psf.pixels_per_ld * (u_ld_bounds(2) - psf.ld_bounds(1,1)));
v_px =    1 + round(psf.pixels_per_ld * (0 - psf.ld_bounds(1,1)));
u = psf.ld_bounds(1,1) + ((upx_min:upx_max) - 1) / psf.pixels_per_ld;
w = psf.data(upx_min:upx_max,v_px);

end
