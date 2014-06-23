function [seg, vis] = segDelLast(seg0)
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

[s0, G0] = stFld(seg0, 's', 'G');
[kT, m0] = size(G0);
n0 = s0(end) - 1;

% index of frames that has been keeped
vis = ones(1, n0);
for i = 1 : m0
    if G0(end, i)
        vis(s0(i) : s0(i + 1) - 1) = 0;
    end
end
vis = vis == 1;

% new segmentation
idx = find(G0(end, :));
ns = diff(s0);
ns(idx) = [];
s = n2s(ns);
G = G0(1 : end - 1, :);
G(:, idx) = [];
seg = newSeg('s', s, 'G', G);
