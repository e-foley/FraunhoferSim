% compares two power spectra
function [comp_img, r_axis, m1_axis, m2_axis, colors] = compare2(ps1, ps2, primary_color, ld_lim, fft_scale, mag_lims)

cropped1 = cropByLd(ps1, ld_lim, fft_scale);
bound1 = boundShades(cropped1, mag_lims);
cropped2 = cropByLd(ps2, ld_lim, fft_scale);
bound2 = boundShades(cropped2, mag_lims);

secondary_color = 1-primary_color;
red =   bound1 .* primary_color(1) + bound2 .* secondary_color(1);
green = bound1 .* primary_color(2) + bound2 .* secondary_color(2);
blue =  bound1 .* primary_color(3) + bound2 .* secondary_color(3);
comp_img = cat(3, red, green, blue);

mid_vert = round(size(cropped1, 1) / 2);
mid_horiz = round(size(cropped1, 2) / 2);
r_axis = ((mid_horiz:size(cropped1, 2)) - mid_horiz) / fft_scale;
m1_axis = cropped1(mid_vert, mid_horiz:end);
m2_axis = cropped2(mid_vert, mid_horiz:end);

colors = [primary_color; secondary_color];

%plot(mid_horiz:size(ps1, 2), ps1(mid_vert, mid_horiz:end), 'Color', primary_color, mid_horiz:size(ps2, 2), ps2(mid_vert, mid_horiz:end), 'Color', secondary_color);
% figure(4);
% hold on;
% h2 = plot(mid_horiz:size(ps2, 2), ps2(mid_vert, mid_horiz:end), 'Color', secondary_color);
% h1 = plot(mid_horiz:size(ps1, 2), ps1(mid_vert, mid_horiz:end), 'Color', primary_color);
% hold off;
% legend([h1 h2], ps1_name, ps2_name);

%primary_color = [0 1 0];

%tester = cat(3, red, green, blue);

%figure(2);
%imshow(tester);

end
