function [tinted  = tint(img, tint)

if size(img, 3) == 1
    img = cat(3, img, img, img);
end

tinted = cat(3, tint(1)*img(:, :, 1), tint(2)*img(:, :, 2), tint(3)*img(:, :, 3));
end
