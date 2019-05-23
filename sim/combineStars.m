function [sc] = combineStars(stars, psf, diameter_in, wavelength_nm)    

sc = SpectralCanvas;

% Cache (L/D -> arcsecond) factor for easy reference.
as_from_ld = asFromLd(wavelength_nm, diameter_in);

% Calculate pixel scale in pixels per arcseconds
sc.pixels_per_as = psf.pixels_per_ld / as_from_ld;

if numel(stars) == 0
    return;
end

% Precompute the bounds of the domain we'll want to fill. Since the PSF for
% each star will be the same, the result comes down to how the star
% positions expand the region.
min_star_u =  inf();
max_star_u = -inf();
min_star_v =  inf();
max_star_v = -inf();
for i = 1:numel(stars)
    star_u = stars(i).as_pos(1);
    if star_u < min_star_u
        min_star_u = star_u;
    end
    if star_u > max_star_u
        max_star_u = star_u;
    end
    
    star_v = stars(i).as_pos(2);
    if star_v < min_star_v
        min_star_v = star_v;
    end
    if star_v > max_star_v
        max_star_v = star_v;
    end
end

% Calculate padding and use this to form a canvas that can hold everything.
upx_min_pad = -round(min_star_u * sc.pixels_per_as);
upx_max_pad =  round(max_star_u * sc.pixels_per_as);
vpx_min_pad = -round(min_star_v * sc.pixels_per_as);
vpx_max_pad =  round(max_star_v * sc.pixels_per_as);
upx_total = size(psf.data, 1) + upx_min_pad + upx_max_pad;
vpx_total = size(psf.data, 2) + vpx_min_pad + vpx_max_pad;
sc.data = zeros(upx_total, vpx_total);

% Assign arcsecond bounds accordingly.
sc.as_bounds(1,1) = min_star_u + psf.ld_bounds(1,1) * as_from_ld;
sc.as_bounds(1,2) = max_star_u + psf.ld_bounds(1,2) * as_from_ld;
sc.as_bounds(2,1) = min_star_v + psf.ld_bounds(2,1) * as_from_ld;
sc.as_bounds(2,2) = max_star_v + psf.ld_bounds(2,2) * as_from_ld;

% Compose the image in different slices--one slice per convolution member.
for i = 1:numel(stars)
    upx_shift =  round(stars(i).as_pos(1) * sc.pixels_per_as);
    vpx_shift =  round(stars(i).as_pos(2) * sc.pixels_per_as);
    
    slice = zeros(size(sc.data));
    
    % Calculate the shifted domain over which to place the new star image.
    upx_range = upx_min_pad + upx_shift + (1:size(psf.data,1));
    vpx_range = vpx_min_pad + vpx_shift + (1:size(psf.data,2));
    slice(upx_range, vpx_range) = psf.data;
    
    % Amplify the star by its brightness as we add it to the convolution.
    % FIX ME: THIS ISN'T THE RIGHT APPLICATION OF BRIGHTNESS.
    sc.data = sc.data + stars(i).app_vis_mag * slice;
end

end
