function generatePsfSpecFile(psf_props, original_size, reduced_size, fft_size, crop_scale_props, processed_size, imagesc_props_aperture, imagesc_props_psf, output_location)

p = psf_props;
c = crop_scale_props;
a = imagesc_props_aperture;
f = imagesc_props_psf;

fid = fopen(output_location, 'w');
fprintf(fid, ['original mask size:  ' num2str(original_size(1)) ' px X ' num2str(original_size(2)) ' px\r\n']);
fprintf(fid, ['initial mask scaling:  ' num2str(p.input_scale) '\r\n']);
fprintf(fid, ['reduced mask size:  ' num2str(reduced_size(1)) ' px X ' num2str(reduced_size(2)) ' px\r\n']);
fprintf(fid, ['FFT domain scale:  ' num2str(p.fft_scale) '\r\n']);
fprintf(fid, ['FFT size:  ' num2str(fft_size(1)) ' px X ' num2str(fft_size(2)) ' px\r\n']);
fprintf(fid, 'asterism contents (u, v):  ');
for i=1:size(p.ld_conv, 1)
    fprintf(fid, [num2str(p.ld_conv(i, 3)) ' @ (' num2str(p.ld_conv(i, 1)) ', ' num2str(p.ld_conv(i, 2)) ') lam/D']);
    if i < size(p.ld_conv, 1)
        fprintf(fid, '; ');
    end
end
fprintf(fid, '\r\n');
fprintf(fid, ['magnitude limits:  [' num2str(-c.mag_lims(2)) ', ' num2str(-c.mag_lims(1)), ']\r\n']);
fprintf(fid, ['lam/D limits:  [' num2str(-c.ld_lim) ', ' num2str(c.ld_lim) ']\r\n']);
fprintf(fid, ['output PSF size:  ' num2str(processed_size(1)) ' px X ' num2str(processed_size(2)) ' px\r\n']);
fprintf(fid, ['nominal plot size (aperture):  ' num2str(a.nominal_plot_size(1)) ' px X ' num2str(a.nominal_plot_size(2)) ' px\r\n']);
fprintf(fid, ['nominal plot size (PSF):  ' num2str(f.nominal_plot_size(1)) ' px X ' num2str(f.nominal_plot_size(2)) ' px\r\n']);
fprintf(fid, ['timestamp:  ' datestr(now)]);
fclose(fid);

end
