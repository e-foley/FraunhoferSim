function [ ld ] = doubleToLd(pair, wavelength, diameter)
% wavelength in nanometers
% diameter in inches

% TODO: Extend this into a multiple_to_LD function
% TODO: Think more about whether that additional division by two is
% necessary... I think it is

ld_separation = arcsecToLd(pair.separation, wavelength, diameter);
secondary_pos = [ld_separation * cosd(pair.angle-90) ld_separation * sind(pair.angle-90)];

ld = zeros(2, 3);
ld(1, :) = [0.0 0.0 10^(-pair.mags(1) / 2.5 / 2)];
ld(2, :) = [secondary_pos 10^(-pair.mags(2) / 2.5 / 2)];

end
