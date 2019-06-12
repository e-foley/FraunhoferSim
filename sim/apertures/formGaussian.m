function [M] = formGaussian(size, rel_peak_height, std_factor)

M = ones(size);
peakheight = rel_peak_height * size / 2;
mean = size/2;
stdev = std_factor * rel_peak_height * size;
x = 1:size;

norm = (peakheight / normpdf(mean, mean, stdev)) * normpdf(x, mean, stdev);

for i=1:mean
    for j=1:size
        if i >= norm(j)
            M(mean-i+1, j) = 0;
        end
    end
end

M = M.* flipud(M);

end
