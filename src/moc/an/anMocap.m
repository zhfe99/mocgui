function anMocap(wsMoc)
% Animate motion capture sequence.
%
% Input
%   wsMoc   -  mocap data
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 09-02-2010
%   modify  -  Feng Zhou (zhfe99@gmail.com), 08-30-2014

prIn('anMocap');

% mocap
[skel, QC, Conn] = stFld(wsMoc, 'skel', 'QC', 'Conn');
nF = size(QC, 3);

% figure
fig = 1; rows = 2; cols = 1; figSiz = [90, 160] * 4;
Ax = iniAx(fig, rows, cols, figSiz, 'hs', [1 7], 'ax', 'n');

% text size
ftSiz = 20;

% each frame
prCIn('frame', nF, .1);
for iF = 1 : nF
    prC(iF);

    %% show text
    s = sprintf('%d/%d', iF, nF);
    if iF == 1
        hS = shStr(s, 'ax', Ax{1}, 'ftSiz', ftSiz);
    else
        shStrUpd(hS, s);
    end

    %% show mocap
    if iF == 1
        shMocG(QC, 'ax', Ax{2});
        haMoc = shMocF(QC(:, :, iF), Conn, skel, 'cl', 'b');
    else
        shMocFUpd(haMoc, QC(:, :, iF));
    end

    drawnow;
    pause(.1);
end
prCOut(nF);

prOut;
