% image dimensions (rows, columns)
imdims = [256 256];

% how big our FFT is relative to our image
% (The image will be padded with zeros to achieve this factor, which is
% helpful because the "fast" in "fast Fourier transform" means that the
% input image is treated as if it were infinitely repeating: padding makes
% the effects of this false assumption less prevalent at the expense of
% longer computation time and greater RAM usage.)
FFT_factor = 1;

% initialize our pattern with all zeros
mat = zeros(imdims);

% generate sinusoidal grating...
mat = 0.5 + 0.5 * form_sine_grating(imdims, 1/8, deg2rad(90), deg2rad(45));

% OR generate line...
%mat(122:134, :) = 1;

% OR generate cross...
%mat(110:146, :) = 1;
%mat(:, 124:132) = 1;

% OR multiply patterns...
%mat = mat .* (0.5 + 0.5 * form_sine_grating(1/9, deg2rad(0), deg2rad(30), imdims));

% display grating
figure(1);
imshow(mat);

% take 2D fast Fourier transform of our grating
% (This generates a matrix of complex numbers stored in 'transform'.)
transform = fft2(mat, FFT_factor*imdims(1), FFT_factor*imdims(2));

% shift result so that content at zero frequency is shown in center rather
% than top-left
transform = fftshift(transform);

% split the 2D FFT, which is a matrix of complex numbers, into magnitude
% and phase components
% (N.B. this is not the same as splitting into real and imaginary
% components.)
magnitude = abs(transform);
phase = angle(transform);

% the power spectrum is the square of the magnitude; calculate and store it
% (The '.*' operator multiplies matrices element-by-element as opposed to
% the normal '*' operator, which performs matrix multiplications.)
power_spectrum = magnitude .* magnitude;

% normalize power spectrum such that brightest element is mapped to 1.0
normal_spectrum = power_spectrum ./ max(max(power_spectrum));

% power spectrum's values stretch across many orders of magnitude; take log
% to improve dynamic range when displaying image
log_spectrum = log(normal_spectrum);

% At this point, every element in log_spectrum will have a value no greater
% than 0.0.  The brightest point will have value 0.0 and everywhere else
% will have a negative number.  If you tried to display 'log_spectrum' as
% is, you would see pitch black because MATLAB maps values 0.0 and below to
% black.  Thus, we need to shift the values of 'log_spectrum' into the
% range [0.0 1.0] so they can be displayed properly.  There are a number of
% ways you can do this in order to emphasize certain parts of a pattern.
% One possible way is shown below.
mapped_spectrum = (1/6) * log_spectrum + 1.0;  % maps -6 and below to black

% display result
figure(2);
imshow(mapped_spectrum);