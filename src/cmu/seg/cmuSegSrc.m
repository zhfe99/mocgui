function wsSrc = cmuSegSrc(sub, trl, varargin)
% Obtain CMU source for segmentation.
%
% Input
%   sub      -  subject id
%   trl      -  trial id
%   varargin
%     save option
%
% Output
%   wsSrc
%     prex   -  seg src name
%     src    -  mocap source
%     paraF  -  feature parameter
%     paraP  -  feature parameter
%     para   -  segmentation parameter (ACA)
%     paraH  -  segmentation parameter (HACA)
%
% History
%   create   -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify   -  Feng Zhou (zhfe99@gmail.com), 03-06-2012

% save option
prex = cellStr(sub, trl);
[svL, path] = psSv(varargin, 'fold', 'cmu/seg', ...
                             'prex', prex, ...
                             'subx', 'src');

% load
if svL == 2 && exist(path, 'file')
    prInOut('cmuSegSrc', 'old, %s', prex);
    wsSrc = matFld(path, 'wsSrc');
    return;
end
prIn('cmuSegSrc', 'new, %s', prex);

% src
src = cmuSrc(sub, trl);

% parameter for feature
parF = st('setNm', 'barbic', 'feat', 'log', 'kF', 20, 'redL', 5);

% parameter for haca
parHs = struct( ...
  'kF',   {  20,  12,  20,  12,  20,  12,  20,  12,  20,  12,  20,  12,  20,  12,  20,  12,  20,  12,  20,  12,  15,  12,  20,  12,  20,  12,  20,  12}, ...
  'k',    {  12,   4,  12,   8,  12,   7,  12,   7,  12,   7,  12,  10,  12,   6,  12,   9,  12,   4,  12,   4,  12,   4,  12,   7,  12,   6,  12,   4}, ...
  'nMi',  {   8,   4,   8,   4,   8,   4,   8,   4,   8,   4,   8,   4,   8,   4,   8,   4,   8,   4,   8,   4,   7,   3,   8,   4,   8,   4,   8,   4}, ...
  'nMa',  {  10,   6,  10,   6,  10,   6,  10,   6,  10,   6,  10,   6,  10,   6,  10,   6,  10,   6,  10,   6,   9,   4,  10,   6,  10,   6,  10,   6}, ...
  'ini',  { 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, ...
  'nIni', {   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10,   5,  10});
% #trial      1         2         3         4         5         6         7         8         9        10        11        12        13        14
parH = parHs(trl * 2 - 1 : trl * 2);
for i = 1 : length(parH)
    parH(i).lam = 0; 
    parH(i).wid = 1;
end

% parameter for aca
par = paraH2para(parH);
par.lam = 0; par.wid = 1;
% par.lc = 1; par.nIni = 1; par.nItMa = 50;

% store
wsSrc.prex = prex;
wsSrc.src = src;
wsSrc.parF = parF;
wsSrc.parAca = par;
wsSrc.parHaca = parH;

% save
if svL > 0
    save(path, 'wsSrc');
end

prOut;
