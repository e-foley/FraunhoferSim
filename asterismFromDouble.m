% Converts information describing a double star system into an array of Star
% objects for use in other functions. The primary star will be placed at
% (u, v) = (0, 0); the secondary star will be placed according to the separation
% and position angle arguments.
%
% separation_as  The angular separation of the stars (arcseconds)
% app_vis_mags   Apparent visual magnitudes of the stars [m1,m2]. Larger numbers
%                correspond to dimmer stars.
% pa_deg         Position angle of second star relative to first star (degrees).
%                Angles of 0, 90, 180, 270 degrees will place second star along
%                -v, +u, +v, and -u.
%
% asterism       Star objects representing the system [Star1,Star2]

function [asterism] = asterismFromDouble(separation_as, app_vis_mags, pa_deg)

% Construct the Star objects. 90-degree offsets within trig functions align us
% with astronomical conventions for star placement, with 0 degrees being north
% (down), 90 degrees being east (right), and so forth.
star1 = Star([0 0], app_vis_mags(1));
star2 = Star(separation_as * [cosd(pa_deg-90) sind(pa_deg-90)], app_vis_mags(2));

asterism = [star1 star2];

end
