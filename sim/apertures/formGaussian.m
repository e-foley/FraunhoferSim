function [M] = formGaussian(canvas_size_px, rel_peak_height, std_factor)

M = ones(canvas_size_px);
peakheight = rel_peak_height * canvas_size_px / 2;
mean = canvas_size_px/2;
stdev = std_factor * rel_peak_height * canvas_size_px;
x = 1:canvas_size_px;

norm = (peakheight / normpdf(mean, mean, stdev)) * normpdf(x, mean, stdev);

for i=1:mean
    for j=1:canvas_size_px
        if i >= norm(j)
            M(mean-i+1, j) = 0;
        end
    end
end

M = M.* flipud(M);

end
