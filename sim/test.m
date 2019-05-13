mask = imread(['../Inputs/' 'multigaussian-15' '.png']);

aperture_props = ImagescProps;
aperture_props.nominal_plot_size = [620 528];
aperture_props.h_axis_title = '{\itx}'' ({\itx}/{\itD})';
aperture_props.h_axis_tick_spacing = 0.1;
aperture_props.v_axis_title = '{\ity}'' ({\ity}/{\itD})';
aperture_props.v_axis_tick_spacing = 0.1;
aperture_props.extra_title_margin = 0.02;
aperture_props.font_size = 14;
aperture_props.color_map = gray(256);

aperture_title = 'test';
persist_aperture = true;
figure_num = 1;
save_aperture_eps = false;
save_aperture_png = false;
aperture_location_eps = '';
aperture_location_png = '';

plotAperture(mask, aperture_props, aperture_title, persist_aperture,...
    figure_num, save_aperture_eps, save_aperture_png,...
    aperture_location_eps, aperture_location_png);


