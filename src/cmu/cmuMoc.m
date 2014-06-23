function wsMoc = cmuMoc(src, varargin)
% Obtain motion capture data for CMU source.
%
% Input
%   src     -  cmu src
%   varargin
%     save option
%
% Output
%   wsMoc
%     prex  -  prex
%     Dof   -  Dof Matrix, dim x nF
%     join  -  joints related to DOFs
%     skel  -  skel struct for animation
%     QC    -  joint coordinates, 3 x kJ x nF
%     Conn  -  joint connections, 2 x nC
%     nF    -  #frames
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify  -  Feng Zhou (zhfe99@gmail.com), 06-13-2014

% save option
prex = src.nm;
[svL, path] = psSv(varargin, ...
                   'prex', prex, ...
                   'subx', 'moc', ...
                   'fold', 'cmu/moc');

% load
if svL == 2 && exist(path, 'file')
    prInOut('cmuMoc', 'old, %s', prex);
    wsMoc = matFld(path, 'wsMoc');
    return;
end
prIn('cmuMoc', 'new, %s', prex);

% path
[amcpath, asfpath] = cmuPath(src);

% skel
skel = asf2skel(asfpath);

% dof
[Dof, join] = amc2dof(amcpath);

% coordinate
chan = dof2chan(skel, Dof, join);
[QC, Conn] = chan2cord(skel, chan);

% store
wsMoc.prex = prex;
wsMoc.Dof = Dof;
wsMoc.join = join;
wsMoc.skel = skel;
wsMoc.QC = QC;
wsMoc.Conn = Conn;
wsMoc.nF = size(QC, 3);

% save
if svL > 0
    save(path, 'wsMoc');
end

prOut;
