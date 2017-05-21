function [img] = form_gaussian(size, rel_peak_height, std_factor)

img = ones(size);
peakheight = rel_peak_height * size / 2;
mean = size/2;
stdev = std_factor * rel_peak_height * size;
x = 1:size;

norm = (peakheight / normpdf(mean, mean, stdev)) * normpdf(x, mean, stdev);

for i=1:mean
    for j=1:size
        if i >= norm(j)
            img(mean-i+1, j) = 0;
        end
    end
end

img = img.* flipud(img);

end

%xfm = fftshift(fft2(padarray(img, [mean mean]))); % Adds a little bit of padding (1/2 on each side)
%pwr = abs(xfm);
%figure(2);
%imshow(pwr .^ 0.25, []);

%fitswrite(uint8(img), [strrep(num2str(factor*100), '.', '-'), '_', num2str(size), 'x', num2str(size), '.fits']);