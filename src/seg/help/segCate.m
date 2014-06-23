function seg = segCate(segs)
% Concatenate segmentations.
%
% Input
%   segs    -  set of segmentation, 1 x nS (cell)
%
% Output
%   seg     -  new segmentation
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 01-20-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

nS = length(segs);
ms = zeros(1, nS);
nss = cell(1, nS);
for iS = 1 : nS
    [k, ms(iS)] = size(segs{iS}.G);
    nss{iS} = diff(segs{iS}.s);
end
m = sum(ms);

% position
ns = cat(2, nss{:});
s = n2s(ns);

% label
G = zeros(k, m);
ss = n2s(ms);
for iS = 1 : nS
    G(:, ss(iS) : ss(iS + 1) - 1) = segs{iS}.G;
end
seg = newSeg('s', s, 'G', G);
    

