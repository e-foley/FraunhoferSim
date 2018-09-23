close all;

% A = ones(1024);
% A = A .* formCircle(1024, 0.5);
% A = A .* (1-formCircle(1024, 3.881/11*0.5));
% A = A .* (1-formRectangle(1024, [0 0], [((1/16)/11) 1]));
% A = A .* (1-formRectangle(1024, [0 0], [1 ((1/16)/11)]));
% A = A .* formGaussian(1024, 1.0, 0.18);
% A = A .* (1-formGaussian(1024, 0.56, 0.18));
% 
% % imshow(A);
% % imwrite(A, 'Gaussian 18 donut and structure.png');
% 

% Z = ones(1024);
% Z = Z .* (1-formCircle(1024, 3.881/11*0.5));
% imshow(Z);
% imwrite(Z, 'obstruction.png');

% S = ones(1024);
% S = S .* formPolygon(1024, 0.5, 4, 90);
% imshow(S);
% imwrite(S, 'diamond.png');
% 
% B = ones(1024);
% bar_size = 1/8;  % [in]
% B = B .* formPolygon(1024, 0.5, 6, 0);
% B = B .* (1-formPolygon(1024, 0.5*(4.481/11), 6, 0));  % 4.481 is 2/sqrt(3)*3.881, so that sides are beyond radius of secondary mirror cylinder
% B = B .* (1-formRectangle(1024, [0 0], [(bar_size/11) 1]));
% B = B .* (1-imrotate(formRectangle(1024, [0 0], [(bar_size/11) 1]), 60, 'nearest', 'crop'));
% B = B .* (1-imrotate(formRectangle(1024, [0 0], [(bar_size/11) 1]), 120, 'nearest', 'crop'));
% imshow(B);
% % imwrite(B, 'hexagon_donut1.png');


B = ones(1024);
bar_size = 1/8;  % [in]
B = B .* formPolygon(1024, 0.5, 6, 0);
B = B .* (1-formPolygon(1024, 0.5*(4.481/11), 6, 0));  % 4.481 is 2/sqrt(3)*3.881, so that sides are beyond radius of secondary mirror cylinder
B = B .* (1-imrotate(formRectangle(1024, [0 0], [(bar_size/11) 1]), 30, 'nearest', 'crop'));
B = B .* (1-imrotate(formRectangle(1024, [0 0], [(bar_size/11) 1]), 90, 'nearest', 'crop'));
B = B .* (1-imrotate(formRectangle(1024, [0 0], [(bar_size/11) 1]), 150, 'nearest', 'crop'));
imshow(B);
imwrite(B, 'hexagon_donut2.png');

% 
% bowtie_bar_placement = 0.049;
% C = double(imread('bowtie.png'));
% C = C ./ max(max(C));  % because original bowtie is on [0 255]
% C = C .* (1-formRectangle(1000, [-bowtie_bar_placement 0], [bar_size/11 0.8]));
% C = C .* (1-formRectangle(1000, [bowtie_bar_placement 0], [bar_size/11 0.8]));
% imshow(C);
% imwrite(C, 'beamed bowtie.png');

% 
% % square
% B = zeros(1024);
% delta = round(256*sqrt(2));
% B([512-delta : 512+delta], [512-delta : 512 + delta]) = 1;
% imwrite(B, 'square.png');
% 
% C = formPolygon(1024, 0.5, 3, 90);
% imwrite(C, 'triangle.png');
% 
% D = formPolygon(1024, 0.5, 6, 0);
% imwrite(D, 'hexagon.png');

% F = imread('di.png');
% F = F ./ max(max(F));
% G = single(A) - single(F);
% imwrite(G, 'testing.png');
% for i=1:384
%     for j=1:384
%         G(i,j) = min(max(G(i,j), 0), 1);
%     end
% end

%H = formGaussian(1024, 1.0, 0.15);
%J = H .* A_alt;
%imwrite(J, 'C11_gaussian-15.png');

% J = [H H; zeros(0, 1024); H H];
% L = cat(3, J, J, A_alt);
% imshow(L);

% horiz = 0.225;
% vert = 0.225;
% rel_height = 0.435;
% matrix = [-vert -horiz
%           vert -horiz
%           -vert horiz
%           vert horiz];
% K = formMultigaussian(1024, matrix, rel_height, 0.15, false);
% L = cat(3, K, K, A_alt);
% imshow(L);
% imwrite(K, 'multigaussian-15.png');
% 
% 
% horiz = 0.225;
% vert = 0.225;
% rel_height = 0.405;
% matrix = [-vert -horiz
%           vert -horiz
%           -vert horiz
%           vert horiz];
% K = formMultigaussian(1024, matrix, rel_height, 0.18, false);
% L = cat(3, K, K, A_alt);
% imshow(L);
% imwrite(K .* A_alt, 'multigaussian-18.png');




% 0.56 works for 0.18
% 0.63 worls for 0.15

% M = formGaussian(1024, 1.0, 0.18);
%N = formGaussian(1024, 0.35, 0.55); % 294512
%N = formGaussian(1024, 0.35, 0.5); % 308384
%N = formGaussian(1024, 0.36, 0.45); % 314494
%N = formGaussian(1024, 0.37, 0.4); % 322136
%N = formGaussian(1024, 0.39, 0.35); % 324804
% N = formGaussian(1024, 0.41, 0.3); % 330468 <-- best thru
%N = formGaussian(1024, 0.46, 0.25); % 323160
%N = formGaussian(1024, 0.52, 0.20); % 318854
%N = formGaussian(1024, 0.56, 0.18); % 312358
%N = formGaussian(1024, 0.63, 0.15); % 303494
% P = M-N;
%beam = ones(1024);
%beam(512.5-10.5:512.5+10.5, :) = 0;
%P = P .* beam;
% through = sum(sum(P))
% Q = cat(3, P, P, A_alt);
% imshow(Q);
% imwrite(P, 'fun_donut A no beam.png');

% outer_gauss = formGaussian(1024, 1.0, 0.18);
% %inner_gauss = formGaussian(1024, 0.41, 0.3);
% inner_gauss = formMultigaussian(1024, [-10.5/1024 0; 10.5/1024, 0], 0.40, 0.3);
% R = outer_gauss - inner_gauss;
% R = R .* beam;
% imshow(cat(3, R, R, A_alt));
% imwrite(R, 'cont-bridge.png');

% curious = formMultigaussian(1024, [-50.5/1024 0; 50.5/1024, 0], 0.94, 0.25, true);
% imshow(curious);
% imwrite(curious, 'curious.png');
% 
% outer_gauss = formMultigaussian(1024, [-10.5/1024 0; 10.5/1024, 0], 0.97, 0.15, true);
% %inner_gauss = formGaussian(1024, 0.41, 0.3);
% inner_gauss = formMultigaussian(1024, [-10.5/1024 0; 10.5/1024, 0], 0.40, 0.3, false);
% Q = outer_gauss - inner_gauss;
% Q = Q .* beam;
% %imshow(cat(3, Q, Q, A_alt));
% imwrite(Q, 'cont-bridge test two.png');

% S = formApodization(1024, 0.18) .* formCircle(1024, 0.5);
% imshow(S);
% imwrite(S, 'apodization_0-18.png');
% 
% T = 1 - formApodization(1024, 0.3);
% T = T .* formCircle(1024, 0.5);
% T = T .* (1-formCircle(1024, 3.881/11*0.5));
% imshow(T);
% imwrite(T, 'apodization_0-30_inv_c11.png');

% lines = formScreen(1024, 4, 16);
% screen = lines .* lines';
% U =      min(screen + formCircle(1024, 0.55/2), 1);
% U = U .* min(imrotate(screen, 30, 'crop') + formCircle(1024, 0.78/2), 1);
% U = U .* min(imrotate(screen, 60, 'crop') + formCircle(1024, 0.90/2), 1);
% U = U .* formCircle(1024, 0.5);
% imshow(U);
% imwrite(U, '../Inputs/apodizing_screen_4-16.png');
%imwrite(U, 'apodizing_screen_4-16.tif');

in_scale = 1;
fft_scale = 6;
mag_scale = 4;
ld_max = 90;
%show_fft_plus(G, in_scale, fft_scale, mag_scale, ld_max, 'hot', 2, 'Test mask', 'test mask');
