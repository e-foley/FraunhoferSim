function [ ld ] = doubleToLd(separation, mags, angle, wavelength, diameter)
% separation in arcseconds
% angle in degrees
% wavelength in nanometers
% diameter in inches

% TODO: Extend this into a multiple_to_LD function
% TODO: Think more about whether that additional division by two is
% necessary... I think it is

ld_separation = arcsec_to_LD(separation, wavelength, diameter);
secondary_pos = [LD_separation * cosd(angle-90) ld_separation * sind(angle-90)];

ld = zeros(2, 3);
ld(1, :) = [0.0 0.0 10^(-mags(1) / 2.5 / 2)];
ld(2, :) = [secondary_pos 10^(-mags(2) / 2.5 / 2)];

end
