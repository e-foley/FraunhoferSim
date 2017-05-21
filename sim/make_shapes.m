close all;

A = form_circle(1024, 0.5);
imwrite(A, 'full.png');
A_inner = form_circle(1024, 3.881/11*0.5);
imwrite(A_inner, 'inner.png');
A_alt = A - A_inner;
imwrite(A_alt, 'C11.png');




% 
% % square
% B = zeros(1024);
% delta = round(256*sqrt(2));
% B([512-delta : 512+delta], [512-delta : 512 + delta]) = 1;
% imwrite(B, 'square.png');
% 
% C = form_polygon(1024, 0.5, 3, 90);
% imwrite(C, 'triangle.png');
% 
% D = form_polygon(1024, 0.5, 6, 0);
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

H = form_gaussian(1024, 1.0, 0.15);
J = H .* A_alt;
imwrite(J, 'C11_gaussian-15.png');

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
% K = form_multigaussian(1024, matrix, rel_height, 0.15, false);
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
% K = form_multigaussian(1024, matrix, rel_height, 0.18, false);
% L = cat(3, K, K, A_alt);
% imshow(L);
% imwrite(K .* A_alt, 'multigaussian-18.png');




% 0.56 works for 0.18
% 0.63 worls for 0.15

% M = form_gaussian(1024, 1.0, 0.18);
%N = form_gaussian(1024, 0.35, 0.55); % 294512
%N = form_gaussian(1024, 0.35, 0.5); % 308384
%N = form_gaussian(1024, 0.36, 0.45); % 314494
%N = form_gaussian(1024, 0.37, 0.4); % 322136
%N = form_gaussian(1024, 0.39, 0.35); % 324804
% N = form_gaussian(1024, 0.41, 0.3); % 330468 <-- best thru
%N = form_gaussian(1024, 0.46, 0.25); % 323160
%N = form_gaussian(1024, 0.52, 0.20); % 318854
%N = form_gaussian(1024, 0.56, 0.18); % 312358
%N = form_gaussian(1024, 0.63, 0.15); % 303494
% P = M-N;
beam = ones(1024);
beam(512.5-10.5:512.5+10.5, :) = 0;
%P = P .* beam;
% through = sum(sum(P))
% Q = cat(3, P, P, A_alt);
% imshow(Q);
% imwrite(P, 'fun_donut A no beam.png');

% outer_gauss = form_gaussian(1024, 1.0, 0.18);
% %inner_gauss = form_gaussian(1024, 0.41, 0.3);
% inner_gauss = form_multigaussian(1024, [-10.5/1024 0; 10.5/1024, 0], 0.40, 0.3);
% R = outer_gauss - inner_gauss;
% R = R .* beam;
% imshow(cat(3, R, R, A_alt));
% imwrite(R, 'cont-bridge.png');

% curious = form_multigaussian(1024, [-50.5/1024 0; 50.5/1024, 0], 0.94, 0.25, true);
% imshow(curious);
% imwrite(curious, 'curious.png');
% 
% outer_gauss = form_multigaussian(1024, [-10.5/1024 0; 10.5/1024, 0], 0.97, 0.15, true);
% %inner_gauss = form_gaussian(1024, 0.41, 0.3);
% inner_gauss = form_multigaussian(1024, [-10.5/1024 0; 10.5/1024, 0], 0.40, 0.3, false);
% Q = outer_gauss - inner_gauss;
% Q = Q .* beam;
% %imshow(cat(3, Q, Q, A_alt));
% imwrite(Q, 'cont-bridge test two.png');

in_scale = 1;
fft_scale = 6;
mag_scale = 4;
ld_max = 90;
%show_fft_plus(G, in_scale, fft_scale, mag_scale, ld_max, 'hot', 2, 'Test mask', 'test mask');