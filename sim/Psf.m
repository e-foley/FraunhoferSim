classdef Psf
    properties
        data  % the actual power spectrum magnitudes
        pixels_per_ld  % pixels/(lambda/D)
        ld_bounds  % limits of image in lambda/D [u_min u_max; v_min v_max]
    end
end
