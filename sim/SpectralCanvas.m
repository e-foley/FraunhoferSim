classdef SpectralCanvas
    properties
        data  % the color data: dims 1, 2, 3 are v, u, and RGB
        pixels_per_as  % pixels/arcsecond
        as_bounds  % limits of image in arcseconds [v1 v2; u1 u2]
        diameter_in  % diameter of aperture in inches
        wavelength_nm  % wavelength of light in nanometers
    end
end
