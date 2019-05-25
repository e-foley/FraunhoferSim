classdef Star
    properties
        pos_as  % "absolute" position of the star in arcseconds [u, v]
        app_vis_mag  % apparent visual magnitude of star (NOT log-10)
    end
    
    methods
        function star = Star(pos_as, app_vis_mag)
            star.pos_as = pos_as;
            star.app_vis_mag = app_vis_mag;
        end
    end
end
