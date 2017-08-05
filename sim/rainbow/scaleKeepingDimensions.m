% How to handle images that are resized such that their numbers of pixels
% end up with different parities? Because centers may not match.

function [img_out] = scaleKeepingDimensions(img, scale, dims, border_shade, center)
    img_out = border_shade * ones([dims size(img, 3)], 'double');
    img = double(imresize(img, scale)) / 255;
    canvas_margin = dims - [size(img, 1) size(img, 2)];
    
    margin_top = floor(canvas_margin(1) * center(1));  % Top margin always <= bottom
    margin_left = floor(canvas_margin(2) * center(2));  % Left margin always <= right
    
    if canvas_margin(1) < 0
        % Crop the image to the proper scale
        img = img(-margin_top + (1 : dims(1)), :, :);
        margin_top = 0;
    end

    if canvas_margin(2) < 0
        % Crop the image to the proper scale
        img = img(:, -margin_left + (1 : dims(2)), :);
        margin_left = 0;
    end
    
    img_out(margin_top + (1 : size(img, 1)), margin_left + (1 : size(img, 2)), :) = img;
end
