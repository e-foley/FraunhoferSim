function [ canvas ] = rainbowify_lambdas(img, scales, wavelengths, brightnesses, gamma, border_shade, output_dims, center)
%scales = linspace(scale_range(1), scale_range(2), steps);
%hues = linspace(hue_range(1), hue_range(2), steps);
canvas = zeros([output_dims 3]);

i_max = numel(brightnesses);
for i = 1:i_max
    canvas = canvas + brightnesses(i) * tint(scale_dimkeep(img, scales(i), output_dims, border_shade, center), lambda2rgb(wavelengths(i), gamma));
end
end