% Creates a text file with PSF generation details for future reference.
%
% aperture_size_px         Dimensions of original aperture image (pixels)
%                          [height,width]
% aperture_scale           Factor by which aperture image is scaled before
%                          padding it in advance of taking the fast Fourier
%                          transform
% scaled_aperture_size_px  Size of aperture image after being rescaled (pixels)
%                          [height,width]
% fft_scale                Dimensions the scaled aperture image will be padded
%                          to as a ratio of the scaled aperture image size
%                          prior to taking the fast Fourier transform
% fft_size_px              Size of fast Fourier transform input (pixels)
%                          [height,width]
% output_location          Path at which the text file will be saved

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

end
