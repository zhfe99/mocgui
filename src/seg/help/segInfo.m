function [G, s, l, ns, nMaGs, pFs] = segInfo(seg)
% Convert the segment-based indicator matrix into frame-based indicator matrix.
%
% Input
%   seg     -  segmentation
%
% Output
%   G       -  indicator matrix, k x m
%   s       -  segment position, 1 x (m + 1)
%   l       -  label vector, 1 x m
%   ns      -  #frames of segment, 1 x m
%   nMaGs   -  maximum number of frames in each cluster, 1 x k
%   pFs     -  frame index, 1 x m (cell)
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 01-12-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

G = seg.G; s = seg.s; l = G2L(G);
[k, m] = size(G);

ns = diff(s);
nMaGs = zeros(1, m);
pFs = cell(1, m);
for i = 1 : m
    pFs{i} = s(i) : s(i + 1) - 1;

    c = l(i);
    nMaGs(c) = max(nMaGs(c), ns(i));
end
