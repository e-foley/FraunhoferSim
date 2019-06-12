function [M] = formMultigaussian( master_size, rel_centers, rel_peak_height, std_factor, combine_as_product )

M = zeros(master_size);

for i = 1:size(rel_centers, 1)
    single = formGaussion(master_size, rel_peak_height, std_factor);
    
    pixel_shift = -round(rel_centers(i, :) .* master_size);
    for j=1:master_size
        for k=1:master_size
            
            if (j + pixel_shift(1) >= 1 && j + pixel_shift(1) <= master_size && k + pixel_shift(2) >= 1 && k + pixel_shift(2) <= master_size)
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
