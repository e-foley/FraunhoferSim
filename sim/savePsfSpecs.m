function savePsfSpecs(aperture_size_px, aperture_scale, ...
    scaled_aperture_size_px, fft_scale, fft_size_px, output_location)

fid = fopen(output_location, 'w');
fprintf(fid, ['original aperture size:  ' num2str(aperture_size_px(1)) ' px X ' num2str(aperture_size_px(2)) ' px\r\n']);
fprintf(fid, ['aperture scale:  ' num2str(aperture_scale) '\r\n']);
fprintf(fid, ['reduced aperture size:  ' num2str(scaled_aperture_size_px(1)) ' px X ' num2str(scaled_aperture_size_px(2)) ' px\r\n']);
fprintf(fid, ['FFT scale:  ' num2str(fft_scale) '\r\n']);
fprintf(fid, ['FFT size:  ' num2str(fft_size_px(1)) ' px X ' num2str(fft_size_px(2)) ' px\r\n']);
fprintf(fid, ['timestamp:  ' datestr(now)]);
fclose(fid);
