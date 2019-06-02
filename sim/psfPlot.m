function [figure_out] = psfPlot(psf, imagesc_props, imagesc_io_props)
s = imagesc_props;
o = imagesc_io_props;

% Condition color_map into cell array so that it works inside loops.
if (~iscell(s.color_map))
    s.color_map = {s.color_map};
end

num_psfs = numel(psf);
psf_images = cell(num_psfs, 1);

% Seek the PSF that's the largest size and record its size.
max_size_px = [0 0];
for i=1:num_psfs
    psf_images{i} = psfGetImage(psf(i), s.field_limits, s.output_limits);
    max_size_px = max(max_size_px, size(psf_images{i}));
end
composite = zeros([max_size_px 3]);
for i=1:num_psfs
    map = s.color_map{i};
    num_colors = size(map, 1);
    % Resize small images to size of largest.
    psf_images{i} = imresize(psf_images{i}, max_size_px);
    % Convert psf_images to indices within color map.
    psf_images{i} = round(1 + (num_colors - 1) * max(0, min(1, psf_images{i})));
    for x=1:size(psf_images{i}, 1)
        for y=1:size(psf_images{i}, 2)
            % Add colors element-wise (3D indices are challenging in MATLAB).
            for c=1:3
                composite(x,y,c) = composite(x,y,c) + map(psf_images{i}(x,y),c);
            end
        end
    end
end

figure_out = figure;

ax = axes;
imagesc(s.field_limits(1,:), fliplr(s.field_limits(2,:)), composite);
formatImagescPlot(figure_out, s);

cb = colorbar(ax);
colormap(cb, s.color_map{1});
caxis(s.output_limits);
color_bar_pos = cb.Position;
set(cb, 'TickLabels', []);
for idx=2:numel(s.color_map)
     ax = axes;
     ax.Visible = 'off';
     ax.XTick = [];
     ax.YTick = [];
     cb = colorbar(ax);
     colormap(cb, s.color_map{idx});
     caxis(s.output_limits);
     cb.Position = color_bar_pos + [color_bar_pos(3) 0 0 0];
end
set(cb,'FontSize',s.font_size,'fontWeight','bold');
ylabel(cb, 'log_1_0 contrast');

% ax2 = axes;
% ax2.Visible = 'off';
% ax2.XTick = [];
% ax2.YTick = [];
% %linkaxes([ax1 ax2]);
% cb2 = colorbar(ax2);
% colormap(cb2, s.color_map{2});
% cb2.Position(1) = cb2.Position(1) + 1*cb2.Position(3);

% 

% 
% cb2 = 

% for i=1:numel(s.color_map)
%     ax = gca;
%     cb = colorbar(ax);
%     colormap(cb, s.color_map{i});
%     cb.Position(1) = cb.Position(1) - (i-1)*cb.Position(3);
    
    
    
    
%   cb = colorbar('eastoutside');
    %cb = colorbar;
    
    
    
    
    
    %caxis(s.output_limits);
    
    %set(cb, 'Limits', s.output_limits);
    %cb.Position(1) = cb.Position(1) - (i-1)*cb.Position(3);
    
    %drawnow;  % MATLAB bug: colorbar colors don't update without this line.
    
    %ylabel(cb, 'log_1_0 contrast');
% end

% cb = colorbar('eastoutside');
% colormap(cb, jet);
% cb.Position(1) = cb.Position(1) + 0;
% cb = colorbar('eastoutside');
% colormap(cb, parula);
% cb.Position(1) = cb.Position(1) + 0.1;

% cb2 = colorbar;
% set(cb2, 'Limits', p.cut_vert_lims);
% set(cb2, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
% set(cb2, 'TickLabels', []);
% set(cb2, 'AxisLocation', 'in');
% cb2.Position(1) = cb.Position(1) - cb.Position(3);
% colormap(cb2, [linspace(0, colors(1,1), 256)' linspace(0, colors(1,2), 256)' linspace(0, colors(1,3), 256)']);







if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
