function shMocFUpd(h, QC)
% Show mocap frame (update).
%
% Input
%   h        -  handle
%   QC       -  3D or 2D coordinates of joint, d x nJ
%
% History
%   create   -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify   -  Feng Zhou (zhfe99@gmail.com), 07-12-2014

% dimension
d = size(QC, 1);

% bone
Conn = h.Conn;
nB = size(Conn, 2);
na = nan(1, nB);
if d == 3
    xB = [QC(1, Conn(1, :)); ...
          QC(1, Conn(2, :)); ...
          na];
    yB = [QC(3, Conn(1, :)); ...
          QC(3, Conn(2, :)); ...
          na];
    zB = [QC(2, Conn(1, :)); ...
          QC(2, Conn(2, :)); ...
          na];
else
    xB = [QC(1, Conn(1, :)); ...
          QC(1, Conn(2, :)); ...
          na];
    yB = [QC(2, Conn(1, :)); ...
          QC(2, Conn(2, :)); ...
          na];
end
headConn = h.headConn;
if headConn ~= 0
    xB(:, headConn) = [];
    yB(:, headConn) = [];
    if d == 3
        zB(:, headConn) = [];
    end
end
if d == 3
    set(h.hConn, 'XData', xB(:), 'YData', yB(:), 'ZData', zB(:));
else
    set(h.hConn, 'XData', xB(:), 'YData', yB(:));
end

% neck
neckJ = h.neckJ;
if neckJ ~= 0 && ~isempty(h.hNeck)
    if d == 3
        set(h.hNeck, 'XData', QC(1, neckJ), 'YData', QC(3, neckJ), 'ZData', QC(2, neckJ));
    else
        set(h.hNeck, 'XData', QC(1, neckJ), 'YData', QC(2, neckJ));
    end
end
