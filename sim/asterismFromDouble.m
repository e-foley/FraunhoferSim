function [asterism] = asterismFromDouble(separation_as, app_vis_mags, pa_deg,...
    temperature1_k, temperature2_k)

% separation_as = separation [arcseconds]
% app_vis_mags = apparent visual magnitudes
% pa_deg = position angle of second star relative to first star [deg]
% temperature1_k = temperature of star 1 (assumed to be a black body)
% temperature2_k = temperature of star 2 (assumed to be a black body)

% We ssume primary star is centered.

% We use simplified constructors in case temperatures are not provided.
if nargin >= 5
    star1 = Star([0 0], app_vis_mags(1), temperature1_k);
    star2 = Star(separation_as * [cosd(pa_deg-90) sind(pa_deg-90)], ...
        app_vis_mags(2), temperature2_k);
else
    star1 = Star([0 0], app_vis_mags(1));
    star2 = Star(separation_as * [cosd(pa_deg-90) sind(pa_deg-90)], app_vis_mags(2));
end

asterism = [star1 star2];

end
