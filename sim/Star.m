classdef Star
    properties
        pos_as  % "absolute" position of the star in arcseconds [u, v]
        app_vis_mag  % apparent visual magnitude of star (NOT log-10)
        temperature_k  % temperature of star in kelvins
    end
    
    methods
        function star = Star(pos_as, app_vis_mag, temperature_k)
            star.pos_as = pos_as;
            star.app_vis_mag = app_vis_mag;
            if (nargin >= 3)
                star.temperature_k = temperature_k;
            else
                star.temperature_k = 7000;  % default value is white-ish star
            end
        end
    end
end
