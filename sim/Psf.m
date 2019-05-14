classdef Psf
    properties
        data  % the actual power spectrum magnitudes
        pixels_per_ld  % pixels/(lambda/D)
        ld_bounds  % limits of image in lambda/D [v1 v2; u1 u2]
    end
end
