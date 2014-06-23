function [seg, vis] = segRmShort(seg0, nMi)
% Remove the last cluster which is not meaningful in our problem.
%
% Input
%   seg0    -  original segmentation
%
% Output
%   seg     -  new segmentation
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 01-04-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

[s, G] = stFld(seg0, 's', 'G'); l = G2L(G);
[k, m] = size(G);
ns = diff(s);

% segment need to be removed
vis = ns <= nMi;

for i = 1 : m
    if vis(i)
        G(l(i), i) = 0;
        G(end, i) = 1;
    end
end

% new segmentation
seg = seg0;
seg.G = G;

