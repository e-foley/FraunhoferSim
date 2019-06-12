% Generates a Gaussian apodization profile with transparency maximized at the
% center of the image, tapering toward opaque outward at a rate inversely
% related to a standard deviation value. Note that the Gaussian function will
% produce values greater than zero for any real input arguments, but the domain
% must be truncated to the dimensions of the canvas size within this function.
% (In other words, if this image is to be padded with opaque pixels, there will
% be discontinuities along the borders of the original canvas.)
%
% This function should not be confused with formGaussian, which utilizes the
% Gaussian function output to form a transparent region representing a normal
% distribution rather than to modify translucency in a continuous profile.
%
% canvas_size_px  Square dimension of the image to create (pixels)
% rel_std_dev     The standard deviation of the Gaussian distribution as a ratio
%                 of the canvas size
%
% M               The Gaussian apodization profile image, with transparent areas
%                 1, opaque areas 0, and intermediate values corresponding to
%                 translucent regions [2D array]

function [M] = formApodization(canvas_size_px, rel_std_dev)
    M = zeros(canvas_size_px);
    center = (canvas_size_px + 1) / 2;
    % Translucency decays as a Gaussian function of distance to image center.
    for x = 1:canvas_size_px
        for y = 1:canvas_size_px
            M(x,y) = exp(-(((x-center)^2 + (y-center)^2) / (2*(rel_std_dev*canvas_size_px)^2)));
        end
    end
end
