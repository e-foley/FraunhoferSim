function [M] = formMultigaussian(canvas_size_px, rel_centers, rel_peak_height, std_factor, combine_as_product)

M = zeros(canvas_size_px);

for i = 1:size(rel_centers, 1)
    single = formGaussion(canvas_size_px, rel_peak_height, std_factor);
    
    pixel_shift = -round(rel_centers(i, :) .* canvas_size_px);
    for j=1:canvas_size_px
        for k=1:canvas_size_px
            
            if (j + pixel_shift(1) >= 1 && j + pixel_shift(1) <= canvas_size_px && k + pixel_shift(2) >= 1 && k + pixel_shift(2) <= canvas_size_px)
                M(j, k) = M(j, k) + single(j + pixel_shift(1), k + pixel_shift(2));
            end
        end
    end
end

for i=1:numel(M)
    if (combine_as_product && M(i) < size(rel_centers, 1))
        M(i) = 0;
    end
    M(i) = max(0, min(1, M(i)));
end

end
