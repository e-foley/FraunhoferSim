function [canvas] = rainbowifyLambdas(img, scales, wavelengths, brightnesses, gamma, border_shade, output_dims, center)
canvas = zeros([output_dims 3]);
i_max = numel(brightnesses);
for i = 1:i_max
    canvas = canvas + brightnesses(i) * tint(scaleKeepingDimensions(img, scales(i), output_dims, border_shade, center), lambdaToRgb(wavelengths(i), gamma));
end
end
