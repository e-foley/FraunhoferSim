classdef Psf
    properties
        data  % the actual power spectrum magnitudes
        pixels_per_ld  % pixels/(lambda/diameter)
        ld_bounds  % dimensions of image in lambda/diameter [vert; horiz]
    end
end
