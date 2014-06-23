function wsData = cmuSegData(wsSrc, varargin)
% Prepare CMU data for temporal segmentation.
%
% Input
%   wsSrc    -  CMU seg src
%   varargin
%     save option
%
% Output
%   wsData
%     sR     -  temporal reduction
%     Dof    -  Degree of Freedom, dim x nF0
%     X      -  quaternion (continuous) feature, dim x nF
%     X0     -  quaternion (continuous) feature without temporal reduction, dim x nF0
%     XD     -  1-D (discrete) feature, 1 x nF
%     XD0    -  1-D (discrete) feature without temporal reduction, 1 x nF0
%     segT   -  ground truth segmentation
%     segT0  -  ground truth segmentation without temporal reduction
%     cnames -  class names
%
% History
%   create   -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify   -  Feng Zhou (zhfe99@gmail.com), 03-06-2012

% save option
prex = wsSrc.prex;
[svL, path] = psSv(varargin, 'fold', 'cmu/seg', ...
                             'prex', prex, ...
                             'subx', 'data');

% load
if svL == 2 && exist(path, 'file')
    prInOut('cmuSegData', 'old, %s', prex);
    wsData = matFld(path, 'wsData');
    return;
end
prIn('cmuSegData', 'new, %s', prex);

% src
[src, parF] = stFld(wsSrc, 'src', 'parF');

% mocap
wsMoc = cmuMoc(src, 'svL', 2);

% feature
wsFeat = cmuMocFeat(src, wsMoc, parF, 'svL', 2);
X0 = wsFeat.XQ;

% temporal reduction
[sR, X, XD, XD0] = tempoReduce(X0, parF);

% ground truth
CMU = cmuHuman;
nm = ['S' src.nm];
segT0 = CMU.(nm).seg;
cnames = CMU.(nm).cnames;

% store
wsData.sR = sR;
wsData.X = X;
wsData.XD = XD;
wsData.X0 = X0;
wsData.XD0 = XD0;
wsData.segT0 = segT0;
wsData.segT = segNewS(segT0, sR, 'type', 'shrink');
wsData.cnames = cnames;

% save
if svL > 0
    save(path, 'wsData');
end

prOut;
