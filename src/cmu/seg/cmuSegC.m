function [wsIn, wsSeg, wsSegm] = mocSegC(wsSrc, wsData, nRep)
% Compare the segmentation method on motion capture data.
%
% Input
%   wsSrc   -  mocap source
%   wsData  -  mocap data
%   nRep    -  number of repeatition
%
% Output
%   wsIn
%   wsSeg   -  work space
%   wsSegm  -  work space
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 02-13-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% feature
[DOF, joint] = dofFilter(wsData.DOF, wsData.joint, featPara);
Q = dof2feat(DOF, joint, featPara);

% allocate the results
tmps = cell(1, nRep);
wsIn.Xs = tmps; wsIn.DXs = tmps; wsIn.Qs = tmps; wsIn.stRs = tmps;
wsIn.segStds = tmps; wsIn.annot = wsData.annot;
wsSeg.segs  = tmps; wsSeg.segHs  = tmps; wsSeg.segSs  = tmps;
wsSegm.segs = tmps; wsSegm.segHs = tmps; wsSegm.segSs = tmps;
wsSegm.seg0s = tmps;

for i = 1 : nRep
    disp(['iRepeat ' num2str(i)]);
    
    % temporal reduction
    [X, stR, DX] = tempoReduce(Q, para);
    Q2 = stPick(Q, stR);
    wsIn.Xs{i} = X; wsIn.DXs{i} = DX; wsIn.Qs{i} = Q2; wsIn.stRs{i} = stR;

    % frame similiarity
    fS = conSim(conDist(X, X));
    fSm = conSim(conDist(Q2, Q2, 'type', 'e'), 'type', 'g');

    % 0. ground truth
    segStd = reduceSeg(wsData.segStd, stR);
    wsIn.segStds{i} = segStd;
    
    % 2. haca
    wsSeg.segHs{i} = tempoSeg(fS, paraH, 'segStd', segStd);
    wsSegm.segHs{i} = tempoSeg(fSm, paraH, 'segStd', segStd);
    
    % 1. aca
    wsSeg.segs{i} = tempoSeg(fS, para, 'segStd', segStd);
    wsSegm.segs{i} = tempoSeg(fSm, para, 'segStd', segStd);

    % 3. spatio
    wsSeg.segSs{i} = spatioSeg(fS, para, 'segStd', segStd);
    wsSegm.segSs{i} = spatioSeg(fSm, para, 'segStd', segStd);
end
