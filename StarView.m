% Represents the convolution of stars with point spread functions for a
% particular wavelength and a specific telescope diameter. Importantly, a
% StarView object differs from a Psf object in that its dimensions are not
% normalized to lambda/diameter: instead, they are in arcseconds.

classdef StarView
    properties
        % A 2-D matrix of values proportional to the power density at known
        % angular coordinates. First index is values of u spanning
        % as_bounds(1,:); second index is values of v spanning as_bounds(2,:).
        % Proportionality constant has no concise definition.
        data
        
        % Spatial resolution of the data in pixels per arcsecond (pixels/as)
        pixels_per_as
        
        % Angular bounds of data (arcseconds) [umin,umax;vmin,vmax]
        as_bounds
        
        % Diameter of aperture "viewing" the StarView (inches)
        diameter_in
        
        % Wavelength of light captured in this StarView (nanometers)
        wavelength_nm
    end
end
