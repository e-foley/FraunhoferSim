classdef StarPair
    properties
        separation  % arcseconds
        mags  % [2] stellar magnitudes
        angle  % degrees
    end
    
    methods
        function pair = StarPair(separation, mags, angle)
            pair.separation = separation;
            pair.mags = mags;
            pair.angle = angle;
        end
    end
end
