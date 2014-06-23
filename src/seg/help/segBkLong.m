function seg = segBkLong(seg0, nTh)
% Breaking long segment into smaller segments.
%
% Input
%   seg0    -  original segmentation
%   nTh     -  thershold for breaking
%   
% Output
%   seg     -  new segmentation
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 11-03-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

nMa = nTh;

s0 = seg0.s;
n = s0(end) - 1;
ns0 = diff(s0);

G0 = seg0.G;
[k, m0] = size(G0);

s = ones(1, n + 1);
G = zeros(k, n);
m = 0;
for i = 1 : m0
    gi = G0(:, i);
    ni = ns0(i);

    if ni > nMa && gi(end) == 0
        nsi = divN(ni, nMa, 'alg', 'w');
        mi = length(nsi);
        G(:, m + 1 : m + mi) = repmat(gi, 1, mi);
        s(m + 2 : m + mi + 1) = cumsum(nsi) + s0(i);
        m = m + mi;

    else
        m = m + 1;
        G(:, m) = gi;
        s(m + 1) = s0(i + 1);

    end
end
s(m + 2 : end) = [];
G(:, m + 1 : end) = [];

seg = newSeg('s', s, 'G', G);
