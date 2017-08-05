function [processed, log_scaled, figure_num] = cropAndScale(xfm, fft_scale, crop_scale_props, show_figure, figure_num)

p = crop_scale_props;

% Take the log to roughly obtain a brightness
log_scaled = logNormalize(xfm);  % entries are nonpositive now 

% Scale and crop the PSF to obtain a result without graph format or imagesc
processed = cropByLd(log_scaled, p.ld_lim, fft_scale);
processed = boundShades(processed, p.mag_lims);

if show_figure
    figure(figure_num);
    imshow(processed);
    figure_num = figure_num + 1;
end
end
