function plot_aperture(aperture, aperture_name, aperture_name_alt, figure_number, font_size, nominal_plot_size, print_mode)
extra_title_margin = 0.02;

my_figure = figure(figure_number);
imagesc([-0.5 0.5], [0.5 -0.5], aperture);
if print_mode
    color_scale = flipud(gray(256));  % min=white; max=black  (inverted)
else
    color_scale = gray(256);  % min=black; max=white  (normal)
end
colormap(color_scale);  % needed to plot black/white if lingering colormap
axis on;
axis square;
axis equal;
xlim([-0.5 0.5]);
ylim([-0.5 0.5]);
set(gca, 'XTick', -0.5:0.1:0.5);
set(gca, 'YTick', -0.5:0.1:0.5);
set(gca, 'YDir', 'normal');  % 'reverse' is default, with values increasing as one goes down the screen
set(gca, 'TickDir', 'out');  % draws tick marks outside aperture area
xlabel('x'' [x/D]');
ylabel('y'' [y/D]');
my_title = title(aperture_name);
title_pos = get(my_title, 'Position');
set(my_title, 'Position', title_pos + [0 extra_title_margin 0]);
set(gca,'FontSize',font_size,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',font_size,'fontWeight','bold');
set(my_figure, 'Position', [0 0 nominal_plot_size]);

% comment out for speed purposes
print('-depsc', '-painters', [aperture_name_alt ' shape.eps']);
print('-dpng', [aperture_name_alt ' shape.png']);

end