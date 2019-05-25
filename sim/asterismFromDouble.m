function [asterism] = asterismFromDouble(separation_as, app_vis_mags, pa_deg)

% separation_as = separation [arcseconds]
% app_vis_mags = apparent visual magnitudes
% pa_deg = position angle of second star relative to first star [deg]

% Assume primary star is centered.
star1 = Star([0 0], app_vis_mags(1));
star2 = Star(separation_as * [cosd(pa_deg-90) sind(pa_deg-90)], app_vis_mags(2));

asterism = [star1 star2];

end
