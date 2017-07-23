%show_fft_plus(img_in, img_in_scale, fft_scale, LD, mag_lims, LD_lim, nominal_plot_size, color_map, print_mode, figure_num, mask_name, filename_string)
function [ logdiff ] = plot_difference(absmat, absmat_rel, normalized, combined, fft_scale, mag_lims, LD_lim, nominal_plot_size, color_map, figure_num, figure_title, filename_string)
font_size_const = 14;  % font size to use on plots
LD_u_axis_tick_spacing = 2;  % u-axis tick spacing and tick label spacing
LD_v_axis_tick_spacing = 2;  % v-axis tick spacing and tick label spacing
extra_title_margin = 0.5;  % extra vertical margin for plot title

absmat = single(absmat);
absmat_rel = single(absmat_rel);

if normalized
    absmat = absmat ./ max(max(absmat));
    absmat_rel = absmat_rel ./ max(max(absmat_rel));
end 

ld_spans = (size(absmat) / fft_scale);
ld_bounds = (ld_spans ./ 2)' * [-1 1]; % the range of lambda/D shown over whole image

if ~combined
    logdiff = log10(absmat) - log10(absmat_rel);
else
    logdiff = cat(3, log10(absmat), zeros(size(absmat)), log10(absmat_rel));
end
clear absmat absmat_rel  % don't need these anymore

imshow(logdiff);

%figure(figure_num);
%imshow(logdiff);
%colormap(color_map);
%caxis([mag_lims(1), mag_lims(2)]);  % bound color axis
%h = colorbar;
%ylabel(h, 'log_1_0 contrast');
%axis on;
%title(figure_title);

% Take the log to roughly obtain a brightness
% log_scaled = log10(xfm ./ max(max(xfm)));  % entries are nonpositive now 

% TODO: Find whether the flipud is actually necessary

scaled_fig = figure(figure_num + 2);
set(scaled_fig, 'Position', [0 0 nominal_plot_size]);
imagesc(ld_bounds(1,:), ld_bounds(2,:), flipud(logdiff));  % actually plot result; flip makes coords agree with convolution
% colormap(figure_num + 2, color_map);
% caxis([mag_lims(1), mag_lims(2)]);  % bound color axis
h = colorbar;
% bar.label.String = 'Base ten magnitude relative to max';
ylabel(h, 'log_1_0 contrast');
axis on;
% these seem redundant, but performance consistent only with them all
axis square;
axis equal;
xlim([-LD_lim, LD_lim]);
ylim([-LD_lim, LD_lim]);
set(gca, 'XTick', -LD_lim:LD_u_axis_tick_spacing:LD_lim);
set(gca, 'YTick', -LD_lim:LD_v_axis_tick_spacing:LD_lim);
set(gca, 'YDir', 'normal');
set(gca, 'TickDir', 'out');  % draw ticks outside of PSF area
xlabel('u [\lambda/D]');
ylabel('v [\lambda/D]');
my_title = title(['Ideal monochromatic, on-axis PSF of ' figure_title]);
title_pos = get(my_title, 'Position');
set(my_title, 'Position', title_pos + [0 extra_title_margin 0]);
set(gca,'FontSize',font_size_const,'fontWeight','bold');
set(h, 'FontSize', font_size_const, 'fontWeight', 'bold');  % color bar axis font
set(findall(gcf,'type','text'),'FontSize',font_size_const,'fontWeight','bold');
print('-depsc', '-painters', [filename_string ' PSF.eps']);
print('-dpng', [filename_string ' PSF.png']);
