function [] = run_diff(p)

clf;
close all;

primary_file = [p.primary '.png'];
secondary_file = [p.secondary '.png'];
% img_cut_name = 'Gaussian donut';
% img_rel_cut_name = 'C11 aperture';
filename_string = [p.primary '_vs_' p.secondary];

% END USED PARAMETERS

img = imread(primary_file);
img_rel = imresize(imread(secondary_file), size(img));

% img = rgb2gray(imread('c11 simple PSF.png'));
% img_rel = rgb2gray(imread('C11.png'));

% img = imread('gaussian donut 18 simple PSF.png');
% img_rel = imread('gaussian 18 donut with spokes simple PSF.png');

[xfm, ~, ~] = get_clever_power_spectrum(img, p.in_scale, p.fft_scale, [0 0 1]);
[xfm_rel, ~, ~] = get_clever_power_spectrum(img_rel, p.in_scale, p.fft_scale, [0 0 1]);

xfm = log_normalize(xfm);
xfm_rel = log_normalize(xfm_rel);

ld_bounds = [-p.ld_lim p.ld_lim; -p.ld_lim p.ld_lim];

% show_aperture =  true;  % true to display the aperture image in a plot window and save it in EPS and PNG format
% show_simple =    true;  % true display a grayscale power spectrum with no axis labels and save a PNG of it
% show_scaled =    true;  % true to display the formatted power spectrum with axis labels and save it in EPS and PNG format
% make_spec_file = true;  % true to create a TXT file recording some of the arguments to this function

[combined, r_axis, m1_axis, m2_axis, colors] = compare2(xfm, xfm_rel, p.primary_color, p.ld_lim, p.fft_scale, p.mag_lims);

%%%%%%%%%%%%%%% SCALED FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOSTLY COPIED FROM OTHER FILE
scaled_fig = figure(p.figure_num);
set(scaled_fig, 'Position', [0 0 p.nominal_plot_size]);
imagesc(ld_bounds(1,:), ld_bounds(2,:), flipud(combined));  % actually plot result; flip makes coords agree with convolution

%experimental legend thingy
hold on;
h = zeros(2, 1);
h(1) = plot(NaN, NaN, 'Marker', 's', 'MarkerSize', 8, 'MarkerFaceColor', colors(1, :), 'MarkerEdgeColor', 'none', 'LineStyle', 'none');
h(2) = plot(NaN, NaN, 'Marker', 's', 'MarkerSize', 8, 'MarkerFaceColor', colors(2, :), 'MarkerEdgeColor', 'none', 'LineStyle', 'none');
l = legend(h, p.img_cut_name, p.img_rel_cut_name);
l.Color = 'none';
l.TextColor = [0.99 0.99 0.99];
l.EdgeColor = [0.99 0.99 0.99];
hold off;
% end experimental legend thingy

%colormap(figure_num + 2, color_map);
%caxis([-mag_lims(2), -mag_lims(1)]);  % bound color axis
%h = colorbar;
% bar.label.String = 'Base ten magnitude relative to max';
%ylabel(h, 'log_1_0 contrast');
axis on;
% these seem redundant, but performance consistent only with them all
axis square;
axis equal;
xlim([-p.ld_lim, p.ld_lim]);
ylim([-p.ld_lim, p.ld_lim]);
set(gca, 'XTick', -p.ld_lim:p.ld_u_axis_tick_spacing:p.ld_lim);
set(gca, 'YTick', -p.ld_lim:p.ld_v_axis_tick_spacing:p.ld_lim);
set(gca, 'YDir', 'normal');
set(gca, 'TickDir', 'out');  % draw ticks outside of PSF area
xlabel('u [\lambda/D]');
ylabel('v [\lambda/D]');
my_title = title(['Point spread function overlay']);
title_pos = get(my_title, 'Position');
set(my_title, 'Position', title_pos + [0 p.extra_title_margin_psf 0]);
set(gca,'FontSize',p.font_size_const,'fontWeight','bold');
% set(h, 'FontSize', font_size_const, 'fontWeight', 'bold');  % color bar axis font
set(findall(gcf,'type','text'),'FontSize',p.font_size_const,'fontWeight','bold');
print('-depsc', '-painters', [filename_string '_psf_comp.eps']);
print('-dpng', [filename_string '_psf_comp.png']);

% delete scaled_fig  % just so we don't accidentally refer to it

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CUT FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cut_fig = figure(p.figure_num + 1);
set(cut_fig, 'Position', [0 0 p.nominal_plot_size]);
hold on;
h2 = plot(r_axis, m2_axis, 'Color', colors(2, :), 'LineStyle', ':');
h1 = plot(r_axis, m1_axis, 'Color', colors(1, :));
hold off;
legend([h1 h2], p.img_cut_name, p.img_rel_cut_name);
xlabel('u [\lambda/D]');
ylabel('log_1_0 contrast');
xlim([0, p.ld_lim]);
ylim(p.cut_vert_lims);
set(gca,'FontSize',p.font_size_const,'fontWeight','bold');
set(gca, 'XTick', 0:p.ld_u_axis_tick_spacing:p.ld_lim);
set(gca, 'YTick', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
set(findall(gca, 'Type', 'Line'),'LineWidth',p.cut_line_thickness);
caxis([-p.mag_lims(2) -p.mag_lims(1)]);
cb = colorbar('westoutside');
colormap(cb, [linspace(0, colors(2,1), 256)' linspace(0, colors(2,2), 256)' linspace(0, colors(2,3), 256)']);
set(cb, 'TickLabels', []);
set(cb, 'AxisLocation', 'in');
%set(cb, 'LimitsMode', 'manual');
set(cb, 'Limits', p.cut_vert_lims);
set(cb, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
%cb.Label.String = 'aoeuaeo';
cb2 = colorbar;
set(cb2, 'Limits', p.cut_vert_lims);
set(cb2, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
set(cb2, 'TickLabels', []);
set(cb2, 'AxisLocation', 'in');
cb2.Position(1) = cb.Position(1) - cb.Position(3);
colormap(cb2, [linspace(0, colors(1,1), 256)' linspace(0, colors(1,2), 256)' linspace(0, colors(1,3), 256)']);
my_title = title(['Horizontal PSF cut overlay']);
title_pos = get(my_title, 'Position');
set(gca,'FontSize',p.font_size_const,'fontWeight','bold');
% set(h, 'FontSize', font_size_const, 'fontWeight', 'bold');  % color bar axis font
set(findall(gcf,'type','text'),'FontSize',p.font_size_const,'fontWeight','bold');
set(my_title, 'Position', title_pos + [0 p.extra_title_margin_cut 0]);
print('-depsc', '-painters', [filename_string '_cut_comp.eps']);
print('-dpng', [filename_string '_cut_comp.png']);


figure(p.figure_num+2);
A = [imread([filename_string '_psf_comp.png']) imread([filename_string '_cut_comp.png'])];
%A = [imread([filename_string '_cut_comp.png']) imread([filename_string '_psf_comp.png'])];
wid = size(A, 2);
rat = 0.07;
A = cat(2, A(:, 1:round((wid-wid*rat)/2), :), A(:, round((wid+wid*rat)/2): wid, :));
imwrite(A, [filename_string '_side_by_side.png']);
imshow(A);