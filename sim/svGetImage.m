% Generates a graphical representation of stars viewed with diffraction effects
% as encoded by a StarView object. The image is plotted on a specified angular
% domain with specified magnitude limits.
%
% sv                  The StarView object to visualize
% new_as_bounds       The angular bounds of the region to visualize (arcseconds)
%                     [umin,umax;vmin,vmax]
% app_vis_mag_limits  The apparent visual magnititude limits--not log-10
%                     limits--that define black and white pixels. Because larger
%                     apparent visual magnitudes correspond to dimmer objects,
%                     the bounds are listed in desending magnitude order as
%                     [max,min].
%
% image               The generated StarView image as a matrix of grayscale
%                     values

function [image] = svGetImage(sv, new_as_bounds, app_vis_mag_limits)

% Calculate apparent visual magnitude in existing StarView data.
image = -2.5 * log10(sv.data);

% Crop the field as close as possible to as_bounds.
upx_min = 1 + floor(sv.pixels_per_as * (new_as_bounds(1,1) - sv.as_bounds(1,1)));
upx_max = 1 +  ceil(sv.pixels_per_as * (new_as_bounds(1,2) - sv.as_bounds(1,1)));
vpx_min = 1 + floor(sv.pixels_per_as * (new_as_bounds(2,1) - sv.as_bounds(2,1)));
vpx_max = 1 +  ceil(sv.pixels_per_as * (new_as_bounds(2,2) - sv.as_bounds(2,1)));
image = image(upx_min:upx_max, vpx_min:vpx_max);

% Map the apparent visual magnitude limits to [0, 1]. No clamping is applied.
mag_delta = app_vis_mag_limits(2) - app_vis_mag_limits(1);
image = (image - app_vis_mag_limits(1)) / mag_delta;

% Rotate the image to same conventions as original aperture image.
image = rot90(image);

end
