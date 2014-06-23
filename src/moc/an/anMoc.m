function anMoc(wsMoc, varargin)
% Animate motion capture sequence.
%
% Input
%   wsMoc   -  mocap data
%   varargin
%     save option
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 09-02-2010
%   modify  -  Feng Zhou (zhfe99@gmail.com), 01-18-2013

% save option
[svL, path] = psSv(varargin, ...
                   'type', 'avi', ...
                   'subx', 'moc');

% load
if svL == 2 && exist(path, 'file')
    prInOut('anMoc', 'old');
    return;
end
prIn('anMoc', 'new');

% mocap
[skel, cord, conn] = stFld(wsMoc, 'skel', 'cord', 'conn');
nF = size(cord, 3);

% figure
fig = 10; figSiz = [90, 160] * 4;
axs = iniAx(fig, 2, 1, figSiz, 'hs', [1 7], 'ax', 'n');

% text
ftSiz = 20;
s = sprintf('0/%d', nF);
hT = shStr(s, 'ax', axs{1}, 'ftSiz', ftSiz);

% first frame
shMocG(cord, 'ax', axs{2});
hSk = shMocF(cord(:, :, 1), conn, skel, 'cl', 'b');

% output video
hw = vdoWIn(path, 'fps', 120);

prCIn('frame', nF, .1);
for iF = 1 : nF
    prC(iF);

    % text
    s = sprintf('%d/%d', iF, nF);
    shStrUpd(hT, s);

    % mocap
    shMocFUpd(hSk, cord(:, :, iF));

    hw = vdoW(hw);
end
prCOut(nF);
vdoWOut(hw);

prOut;
