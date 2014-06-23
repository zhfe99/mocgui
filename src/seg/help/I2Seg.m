function seg = I2Seg(I)
% Convert the frame-class indicator matrix into segment-class indicator matrix.
%
% Input
%   I       -  frame-class indicator matrix, k x n
%
% Output
%   seg     -  temporal segmentation
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 01-12-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

[k, n] = size(I);
l0 = G2L(I);
[s, l] = L2SL(l0);
G = L2G(l, k);
% if k == 1
%     k = 2;
%     I = [I; 1 - I];
% end
% 
% G = zeros(k, n);
% s = ones(1, n + 1);
% 
% m = 0;
% for i = 1 : n
%     c = find(I(:, i), 1);
%     if m == 0 || c ~= c0
%         m = m + 1;
%         G(c, m) = 1;
%         s(m) = i;
%         c0 = c;
%     end
% end
% s(m + 1) = n + 1;
% s(m + 2 : end) = [];
% G(:, m + 1 : end) = [];
seg.s = s;
seg.G = G;
% seg = newSeg('s', s, 'G', G);
