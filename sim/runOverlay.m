function [figure_num] = runOverlay(overlay_props, psf_props, crop_scale_props, imagesc_props, overlay_io_props, primary_label, secondary_label, persist_figures, figure_num)

p = overlay_props;
f = psf_props;
c = crop_scale_props;
s = imagesc_props;
o = overlay_io_props;

% clf;
% close all;

% primary_file = [primary '.png'];
% secondary_file = [secondary '.png'];
% img_cut_name = 'Gaussian donut';
% img_rel_cut_name = 'C11 aperture';
% filename_string = [primary_short '_vs_' secondary_short];

% END USED PARAMETERS

img = imread(o.primary_input_location);
img_rel = imresize(imread(o.secondary_input_location), size(img));

% img = rgb2gray(imread('c11 simple PSF.png'));
% img_rel = rgb2gray(imread('C11.png'));

% img = imread('gaussian donut 18 simple PSF.png');
% img_rel = imread('gaussian 18 donut with spokes simple PSF.png');

[xfm, ~, ~] = getCleverPowerSpectrum(img, f);
[xfm_rel, ~, ~] = getCleverPowerSpectrum(img_rel, f);

xfm = logNormalize(xfm);
xfm_rel = logNormalize(xfm_rel);

ld_bounds = [-c.ld_lim c.ld_lim; -c.ld_lim c.ld_lim];  % TODO: Is this accurate?

% show_aperture =  true;  % true to display the aperture image in a plot window and save it in EPS and PNG format
% show_simple =    true;  % true display a grayscale power spectrum with no axis labels and save a PNG of it
% show_scaled =    true;  % true to display the formatted power spectrum with axis labels and save it in EPS and PNG format
% make_spec_file = true;  % true to create a TXT file recording some of the arguments to this function

[combined, r_axis, m1_axis, m2_axis, colors] = compare2(xfm, xfm_rel, p.primary_color, c.ld_lim, f.fft_scale, c.mag_lims);

%%%%%%%%%%%%%%% SCALED FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scaled_fig = figure(figure_num);
imagesc(ld_bounds(1,:), ld_bounds(2,:), flipud(combined));  % actually plot result; flip makes coords agree with convolution
formatImagescPlot(s, scaled_fig, c.ld_lim, 'Point spread function overlay');
% Experimental legend thingy
hold on;
h = zeros(2, 1);
h(1) = plot(NaN, NaN, 'Marker', 's', 'MarkerSize', 8, 'MarkerFaceColor', colors(1, :), 'MarkerEdgeColor', 'none', 'LineStyle', 'none');
h(2) = plot(NaN, NaN, 'Marker', 's', 'MarkerSize', 8, 'MarkerFaceColor', colors(2, :), 'MarkerEdgeColor', 'none', 'LineStyle', 'none');
l = legend(h, primary_label, secondary_label);
l.Color = 'none';
l.TextColor = [0.99 0.99 0.99];  % Pure white doesn't display.
l.EdgeColor = [0.99 0.99 0.99];  % Pure white doesn't display.
hold off;
% end experimental legend thingy
print('-depsc', '-painters', o.psf_overlay_location_eps);
print('-dpng', o.psf_overlay_location_png);
if (persist_figures)
    figure_num = figure_num + 1;
else
    close(scaled_fig);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CUT FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cut_fig = figure(figure_num);
set(cut_fig, 'Position', [0 0 s.nominal_plot_size]);
hold on;
h2 = plot(r_axis, m2_axis, 'Color', colors(2, :), 'LineStyle', ':');
h1 = plot(r_axis, m1_axis, 'Color', colors(1, :));
hold off;
legend([h1 h2], primary_label, secondary_label);
xlabel('{\itu} [{\it\lambda}/{\itD}]');
ylabel('log_1_0 contrast');
xlim([0, c.ld_lim]);
ylim(p.cut_vert_lims);
set(gca,'FontSize',s.font_size,'fontWeight','bold');
set(gca, 'XTick', 0:s.h_axis_tick_spacing:c.ld_lim);
set(gca, 'YTick', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
set(findall(gca, 'Type', 'Line'),'LineWidth',p.cut_line_thickness);
caxis([-c.mag_lims(2) -c.mag_lims(1)]);
cb = colorbar('westoutside');
colormap(cb, [linspace(0, colors(2,1), 256)' linspace(0, colors(2,2), 256)' linspace(0, colors(2,3), 256)']);
set(cb, 'TickLabels', []);
set(cb, 'AxisLocation', 'in');
set(cb, 'Limits', p.cut_vert_lims);
set(cb, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
cb2 = colorbar;
set(cb2, 'Limits', p.cut_vert_lims);
set(cb2, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
set(cb2, 'TickLabels', []);
set(cb2, 'AxisLocation', 'in');
cb2.Position(1) = cb.Position(1) - cb.Position(3);
colormap(cb2, [linspace(0, colors(1,1), 256)' linspace(0, colors(1,2), 256)' linspace(0, colors(1,3), 256)']);
my_title = title(['Horizontal PSF cut overlay']);
title_pos = get(my_title, 'Position');
set(gca,'FontSize',s.font_size,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',s.font_size,'fontWeight','bold');
set(my_title, 'Position', title_pos + [0 p.extra_title_margin_cut 0]);
print('-depsc', '-painters', o.cut_overlay_location_eps);
print('-dpng', o.cut_overlay_location_png);
if (persist_figures)
    figure_num = figure_num + 1;
else
    close(cut_fig);
end

% NOTE: It's not actually necessary to turn this one into a figure... I
% just wanted to avoid adding yet two more parameters.
combo_fig = figure(figure_num);
A = [imread(o.psf_overlay_location_png) imread(o.cut_overlay_location_png)];
%A = [imread(cut_overlay_location_png) imread(psf_overlay_location_png)];
wid = size(A, 2);
rat = 0.07;
A = cat(2, A(:, 1:round((wid-wid*rat)/2), :), A(:, round((wid+wid*rat)/2): wid, :));
imwrite(A, o.combo_location_png);
imshow(A);
if (persist_figures)
    figure_num = figure_num + 1;
else
    close(combo_fig);
end
