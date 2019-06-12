function [M] = formScreen( img_size, line_width, spacing )
    M = ones(img_size);
    for i = 1:line_width
        M(:,i:spacing:img_size) = 0;
    end
end
