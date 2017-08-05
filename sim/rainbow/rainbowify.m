function [canvas] = rainbowify(img, scale_range, hue_range, steps, output_dims, border_shade, brightness)
scales = linspace(scale_range(1), scale_range(2), steps);
hues = linspace(hue_range(1), hue_range(2), steps);
canvas = zeros([output_dims 3]);
for i = 1:steps  
    canvas = canvas + brightness * tint(scale_dimkeep(img, scales(i), output_dims, border_shade), hsv2rgb([hues(i) 1.0 1.0]));
end
end
