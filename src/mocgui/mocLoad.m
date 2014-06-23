function mocLoad(act)
% Re-loading the motion capture data and refresh the inner variables.
%
% Input
%   act     -  action type, 1 | 0
%              1: load
%              0: clear
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-26-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 05-18-2014

% motion data
global dbe pno trl;
global src;
global skel cord conn;
global iF nF dF fst;

if act == 0
    src = [];

    skel = [];
    cord = [];
    conn = [];
    iF = 0;
    nF = 0;
    dF = 1;
    fst = 1;

elseif act == 1
    % load the mocap data from file
    src = cmuSrc(pno, trl);
    paraF = cmuPara(src);

    wsDof = cmuMoc(src, 'svL', 2);
    [skel, cord, conn] = stFld(wsDof, 'skel', 'QC', 'Conn');

    % set the inner variables
    iF = 1; 
    nF = size(cord, 3);
    dF = 1;
    fst = true;

else
    error('unknown action');
end
