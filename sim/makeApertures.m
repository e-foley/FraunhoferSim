% Creates all images representing apertures and masked apertures and saves them
% in the "apertures" folder.

function makeApertures
output_prefix = 'apertures/';
canvas_size_px = [1024 1024];
make_tifs = true;

% CIRCULAR APERTURE
circle = formCircle(canvas_size_px, 0.5);
imwrite(circle, [output_prefix 'circle.png']);

% C11 OBSTRUCTION
% Assuming entire image represents 11", cut 3.881" circle out.
c11_obstruction = ~formCircle(canvas_size_px, 3.881/11*0.5);
imwrite(c11_obstruction, [output_prefix 'c11 obstruction.png']);

% C11 APERTURE
c11 = circle & c11_obstruction;
imwrite(c11, [output_prefix 'c11.png']);

% GAUSSIAN VARIANTS (NO OBSTRUCTION)
for i=[10 15 20 25 30 35]
    gaussian = formGaussian(canvas_size_px, 0.5, i / 100);
    imwrite(gaussian, [output_prefix 'gaussian ' num2str(i) '.png']);
end
clear i gaussian;

% GAUSSIAN DONUT, STDDEV FACTOR 0.30 (NO SUPPORT)
gaussian_30_donut = formGaussian(canvas_size_px, 0.5, 0.30);
% Gaussian secondary was numerically sized to overlap C11 secondary.
gaussian_30_donut = gaussian_30_donut & ~formGaussian(canvas_size_px, 0.32, 0.30);
imwrite(gaussian_30_donut, [output_prefix 'gaussian 30 donut.png']);

% GAUSSIAN DONUT, STDDEV FACTOR 0.35 (NO SUPPORT)
gaussian_35_donut = formGaussian(canvas_size_px, 0.5, 0.35);
% Gaussian secondary was numerically sized to overlap C11 secondary.
gaussian_35_donut = gaussian_35_donut & ~formGaussian(canvas_size_px, 0.29, 0.35);
imwrite(gaussian_35_donut, [output_prefix 'gaussian 35 donut.png']);

% BEAM
beam_rel_width = (3/16) / 11;
beam = ~formRectangle(canvas_size_px, [0 0], [beam_rel_width 1]);
imwrite(beam, [output_prefix 'bar.png']);
clear beam_rel_width

% GAUSSIAN_DONUT WITH BEAM, STDDEV FACTOR 0.30
gaussian_30_donut_with_beam = gaussian_30_donut & beam;
imwrite(gaussian_30_donut_with_beam, [output_prefix 'gaussian 30 donut with beam.png']);

% GAUSSIAN_DONUT WITH BEAM, STDDEV FACTOR 0.35
gaussian_35_donut_with_beam = gaussian_35_donut & beam;
imwrite(gaussian_35_donut_with_beam, [output_prefix 'gaussian 35 donut with beam.png']);

% TRIANGLE
triangle = formPolygon(canvas_size_px, 0.5, 3, 90);
imwrite(triangle, [output_prefix 'triangle.png']);

% SQUARE
square = formPolygon(canvas_size_px, 0.5, 4, 0);
imwrite(square, [output_prefix 'square.png']);

% HEXAGON
hexagon = formPolygon(canvas_size_px, 0.5, 6, 0);
imwrite(hexagon, [output_prefix 'hexagon.png']);

% APODIZATION, STDDEV FACTOR 0.18
apodization_18 = formApodization(canvas_size_px, 0.18);
imwrite(apodization_18, [output_prefix 'apodization 18.png']);

% C11 WITH APODIZATION, STDDEV FACTOR 0.18
circle_with_apodization_18 = circle .* apodization_18;
imwrite(circle_with_apodization_18, [output_prefix 'circle with apodization 18.png']);

% SCREEN, VERTICAL, 4 PIXELS SPACED BY 16 PIXELS
screen_vertical = formScreen(1024, 4, 16);
imwrite(screen_vertical, [output_prefix 'screen vertical 4 16.png']);

% SCREEN, SQUARE, 4 PIXELS SPACED BY 16 PIXELS
screen_square = screen_vertical & screen_vertical';
imwrite(screen_square, [output_prefix 'screen square 4 16.png']);

% APODIZING SCREEN, 4 PIXELS SPACED BY 16 PIXELS
% Dimensions of circular screen cutouts from Lovro
% (http://www.graphitegalaxy.com/index.cgi?a=diyapodmask).
apodizing_screen = circle & ...
    (screen_square | formCircle(canvas_size_px, 0.55/2));
apodizing_screen = apodizing_screen & ...
    (imrotate(screen_square, 30, 'crop') | formCircle(canvas_size_px, 0.78/2));
apodizing_screen = apodizing_screen & ...
    (imrotate(screen_square, 60, 'crop') | formCircle(canvas_size_px, 0.90/2));
imwrite(apodizing_screen, [output_prefix 'apodizing screen 4 16.png']);;

% SPIDER (FOUR-LEGGED)
rel_spider_width = (1/16) / 11;
spider = ~formRectangle(canvas_size_px, [0 0], [rel_spider_width 1]) & ...
         ~formRectangle(canvas_size_px, [0 0], [1 rel_spider_width]);
imwrite(spider, [output_prefix 'spider.png']);
clear rel_spider_width

% C11 WITH SPIDER (FOUR-LEGGED)
c11_with_spider = c11 & spider;
imwrite(c11_with_spider, [output_prefix 'c11 with spider.png']);

% C11 WITH GAUSSIAN, STDDEV FACTOR 0.30
c11_with_gaussian_30 = c11 & formGaussian(canvas_size_px, 0.5, 0.30);
imwrite(c11_with_gaussian_30, [output_prefix 'c11 with gaussian 30.png']);

% GAUSSIAN DONUT WITH ORIENTED SPIDER, STDDEV FACTOR 0.30
gaussian_30_with_oriented_spider =  gaussian_30_donut & imrotate(spider, 45, 'crop');
imwrite(gaussian_30_with_oriented_spider, ...
    [output_prefix 'gaussian 30 donut with oriented spider.png']);

% GAUSSIAN MULTI, STDDEV FACTOR 0.30
rel_horiz = 0.225;
rel_vert = 0.225;
rel_height = 0.2175;
rel_matrix = [-rel_vert -rel_horiz;
               rel_vert -rel_horiz;
              -rel_vert  rel_horiz;
               rel_vert  rel_horiz];
gaussian_30_multi = formMultigaussian(canvas_size_px, rel_matrix, rel_height, 0.30);
gaussian_30_multi = gaussian_30_multi & c11;
imwrite(gaussian_30_multi, [output_prefix 'gaussian 30 multi.png']);
clear rel_horiz rel_vert rel_height rel_matrix

% GAUSSIAN_MULTI, STDDEV FACTOR 0.35
rel_horiz = 0.225;
rel_vert = 0.225;
rel_height = 0.2125;
rel_matrix = [-rel_vert -rel_horiz;
               rel_vert -rel_horiz;
              -rel_vert  rel_horiz;
               rel_vert  rel_horiz];
gaussian_35_multi = formMultigaussian(canvas_size_px, rel_matrix, rel_height, 0.35);
gaussian_35_multi = gaussian_35_multi & c11;
imwrite(gaussian_35_multi, [output_prefix 'gaussian 35 multi.png']);
clear rel_horiz rel_vert rel_height rel_matrix

% SINE GRATINGS
for wavenumber_px=[8 16 32 64 128]
    sine_grating = formSineGrating(canvas_size_px, 1/wavenumber_px, 0, 90);
    imwrite(sine_grating, [output_prefix 'sine grating ' num2str(wavenumber_px) '.png']);
end
clear wavenumber_px sine_grating;

% Optionally copy every .png to .tif.
if make_tifs
    pattern = fullfile(output_prefix, '*.png');
    files = dir(pattern);
    for i=1:length(files)
        new_name = strrep(files(i).name, '.png', '.tif');
        imwrite(imread([output_prefix files(i).name]), [output_prefix new_name]);
    end
    clear pattern files i new_name
end
end
