function [rgb] = rgbFromLambda(lambda, gamma)

% per Dan Bruton's approach

rgb = [0 0 0];

if lambda >= 380 && lambda < 440
    rgb = [-(lambda - 440)/(440 - 380), 0, 1];
elseif lambda >=440 && lambda < 490
    rgb = [0, (lambda - 440)/(490 - 440), 1];
elseif lambda >= 490 && lambda < 510
    rgb = [0, 1, -(lambda - 510)/(510 - 490)];
elseif lambda >= 510 && lambda < 580
    rgb = [(lambda - 510)/(580 - 510), 1, 0];
elseif lambda >= 580 && lambda < 645
    rgb = [1, -(lambda - 645)/(645 - 580), 0];
elseif lambda >= 645 && lambda < 780
    rgb = [1, 0, 0];
end

intensity = 1;

if lambda > 700
    intensity = 0.3 + 0.7 * (780 - lambda)/(780 - 700);
elseif lambda < 420
    intensity = 0.3 + 0.7 * (lambda - 380)/(420 - 380);
end

rgb = (rgb * intensity) .^ gamma;

end
