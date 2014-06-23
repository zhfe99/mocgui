function [sR, X, XD, XD0] = tempoReduce(X0, par)
% Reduce sequence length.
%
% Input
%   X0      -  original sequence, dim x n0
%   par
%     alg   -  reduction algorithm, {'ave'} | 'merge' | 'max'
%     nMa   -  maximum segment length
%     kF    -  #frame cluster
%     nRep  -  #repetition of kmeans
%              only used if alg == 'merge'
%
% Output
%   sR      -  starting positions of merged areas, 1 x (m + 1)
%   X       -  reduced time series data, dim x n
%   XD      -  1-D time series after reduction, 1 x n
%   XD0     -  1-D time series before reduction, 1 x n0
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 01-04-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% dimension
[dim, n0] = size(X0);

% clustering frames
kF = stFld(par, 'kF');
if dim > 1
    G0 = kmean(X0, kF, 'nRep', 5);
    XD0 = G2L(G0);
else
    XD0 = X0;
end

% merging consecutive frames that share the same label
alg = ps(par, 'alg', 'ave');
if strcmp(alg, 'merge')
    nMa = stFld(par, 'nMa');

    % insert a useless sample at the end
    XD0(n0 + 1) = -1;

    sR = ones(1, n0 + 10);
    m = 0;
    for i = 2 : n0 + 1
        if i - sR(m + 1) >= nMa || XD0(i) ~= XD0(i - 1)
            m = m + 1;
            sR(m + 1) = i;
        end
    end
    sR(m + 2 : end) = [];
    XD0(n0 + 1) = [];

% uniformly sampling
elseif strcmp(alg, 'ave')
    nMa = stFld(par, 'redL');

    sR = 1 : nMa : n0 + 1;
    if sR(end) < n0 + 1
        sR = [sR, n0 + 1];
    end

% reduce frame by merging for the cluster with maximum number of frames
elseif strcmp(alg, 'max')
    % cluster with maximum number of frames
    ns = sum(G0, 2);
    [nMa, cMa] = max(ns);
    
    % change the label
    visMa = XD0 == cMa;
    XD0(visMa) = 1;
    XD0(~visMa) = 2;

    % insert a useless sample at the end
    XD0(n0 + 1) = -1;

    sR = ones(1, n0 + 10);
    m = 0;
    for i = 2 : n0 + 1
        if XD0(i) == 2 || i - sR(m + 1) >= nMa || XD0(i) ~= XD0(i - 1)
            m = m + 1;
            sR(m + 1) = i;
        end
    end
    sR(m + 2 : end) = [];
    XD0(n0 + 1) = [];

else
    error('unknown alg: %s', alg);
end

% fetch the part
X = sPick(X0, sR);
XD = sPick(XD0, sR);

prIn('tempoReduce', '%d -> %d', n0, size(X, 2));
prOut;
