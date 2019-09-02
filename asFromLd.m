% Calculates the factor that converts lambda/diameter into arcseconds for the
% given wavelength and aperture diameter.
%
% wavelength_nm  The wavelength of light (nanometers)
% diameter_in    The aperture diameter (inches)
%
% as             The angle (arcseconds) corresponding to 1 lambda/diameter

function [as] = asFromLd(wavelength_nm, diameter_in)
    % Convert both arguments to meters to find angle in radians. (Small
    % angle approximation is used.)
    ld_rad = (wavelength_nm / 1e9) / (diameter_in * (1/12) * (1/3.28));
    
    % Convert angle from radians to arcseconds.
    as = ld_rad * 3600 * (360/(2*pi));
end
