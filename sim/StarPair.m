classdef StarPair
    properties
        separation_as  % separation [arcseconds]
        app_vis_mags  % apparent visual magnitudes
        angle_deg  % orientation of second relative to first [deg]
    end
    
    methods
        function pair = StarPair(separation_as, app_vis_mags, angle_deg)
            pair.separation_as = separation_as;
            pair.app_vis_mags = app_vis_mags;
            pair.angle_deg = angle_deg;
        end
    end
end
