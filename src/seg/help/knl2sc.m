function scs = knl2sc(K, wid, varargin)
% Construct the breaking kernel from a kernel matrix.
%
% Reference
%   Y. Liu, F. Zhou, W. Liu, F. De la Torre and Y. Liu, "Unsupervised Summarization of Rushes Videos", in ACM MM, 2010
%
% Input
%   K       -  kernel matrix, n x n
%              if K == [], then a KG has been specified in the global environment
%   wid     -  window size
%
% Output
%   scs     -  separating cost, 1 x n
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 01-04-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% kernel
global KG;
isKG = isempty(K);

% #frames
if isKG
    n = size(KG, 1);
else
    n = size(K, 1);
end

scs = zeros(1, n);
for i = 1 : n
    head = max(1, i - wid);
    tail = min(n, i + wid - 1);

    if isKG
        scs(i) = sum(sum(KG(head : i - 1, i : tail)));
    else
        scs(i) = sum(sum(K(head : i - 1, i : tail)));
    end
end
