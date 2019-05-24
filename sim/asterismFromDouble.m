function [asterism] = asterismFromDouble(separation_as, app_vis_mags, pa_deg)

% separation_as = separation [arcseconds]
% app_vis_mags = apparent visual magnitudes
% pa_deg = position angle of second star relative to first star [deg]

star1 = Star;
star1.pos_as = [0 0];  % assume primary star is centered
star1.app_vis_mag = app_vis_mags(1);

star2 = Star;
star2.pos_as = separation_as * [cosd(pa_deg-90) sind(pa_deg-90)];
star2.app_vis_mag = app_vis_mags(2);

asterism = [star1 star2];

end
