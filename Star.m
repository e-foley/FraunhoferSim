% Object representing a single star. Holds position and magnitude.

classdef Star
    properties
        % Angular position of the star relative to center of field of view
        % (arcseconds) [u,v]
        pos_as
        
        % Apparent visual magnitude of the star (NOT log-10). Higher numbers are
        % dimmer stars per astronomical convention.
        app_vis_mag
    end
    
    methods
        % Constructs a star with given position and apparent visual magnitude.
        %
        % pos_as       Angular position of the star relative to center of the
        %              field of view (arcseconds) [u,v]
        % app_vis_mag  Apparent visual magnitude of the star (NOT log-10)
        %
        % star         The constructed Star object
        function star = Star(pos_as, app_vis_mag)
            star.pos_as = pos_as;
            star.app_vis_mag = app_vis_mag;
        end
    end
end
