function [M] = formScreen(canvas_size_px, line_width, spacing)
    M = ones(canvas_size_px);
    for i = 1:line_width
        M(:,i:spacing:canvas_size_px) = 0;
    end
end
