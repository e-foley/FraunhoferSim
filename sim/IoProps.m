% Holds properties related to the saving of figures to disc.

classdef IoProps
    properties
        % Whether and where to save a portable network graphics (PNG) file
        save_png = true;
        png_location = 'output.png';
        
        % Whether and where to save an encapsulated postscript (EPS) file
        save_eps = false;
        eps_location = 'output.eps';
    end
end
