LD = [0.0 0.0 1.0];  % default--a single star

% http://www.skyandtelescope.com/observing/pretty-double-stars-for-everyone/
%LD = double_to_LD(1.0, [5.5 5.9], 90, 700, 11); % 36 And, P.A. 315
%LD = double_to_LD(9.1, [0.1 6.8], 270, 700, 11);  % Rigel, P.A. 203
%LD_gauss = double_to_LD(3.4, [0.0 10.0], 90, 700, 11);  % contrived to show off Gaussian relative to circular (use mag lims [0 5.0])
LD_gauss = double_to_LD(4.0, [0.0 8.0], 90, 700, 11);  % better attempt at above
%LD = double_to_LD(0.83, [0.0 4.0], 92, 700, 11);  % attempt to show off bowtie relative to circular (use mag lims [0 3.0]) 
