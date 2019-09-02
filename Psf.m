% Represents a point spread function. Contains information about the 
% intensity of the electromagnetic field at discrete angular positions (which
% correspond to known ratios of light wavelength to aperture diameter).

classdef Psf
    properties
        % Matrix with values proportional to the intensity (square of complex 
        % amplitude) of the electromagnetic field at discrete angles. First
        % index is values of u spanning ld_bounds(1,:); second index is values
        % of v spanning ld_bounds(2,:).
        data
        
        % Number of pixels per ratio of light wavelength to aperture diameter
        % (pixels/(L/D))
        pixels_per_ld
        
        % The angular domain of the PSF data (L/D) [umin,umax;vmin,vmax]
        ld_bounds
    end
end
