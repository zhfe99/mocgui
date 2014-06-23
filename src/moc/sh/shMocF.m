function ha = shMocF(QC, Conn, skel, varargin)
% Show one mocap frame.
%
% Input
%   QC       -  3D or 2D coordinates of joint, d x nJ
%   Conn     -  joints that bone connect, 2 x nB
%   skel     -  skeleton
%   varargin
%     show option
%     key    -  whether the current frame is a key-frame or not, {'y'} | 'n'
%     cl     -  color, {'b'}
%     lnWid  -  line width, {1.5}
%     lnMk   -  line marker, {'-'} | '--'
%     nkSiz  -  neck joint width, {8}
%     cls    -  color of connection, {[]}
%
% Output
%   ha       -  handle
%
% History
%   create   -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify   -  Feng Zhou (zhfe99@gmail.com), 06-17-2014

% show option
psSh(varargin);

% function option
isKey = psY(varargin, 'key', 'y');
cl = ps(varargin, 'cl', 'b');
lnWid = ps(varargin, 'lnWid', 1.5);
lnMk = ps(varargin, 'lnMk', '-');
nkSiz = ps(varargin, 'nkSiz', 8);
cls = ps(varargin, 'cls', []);

% dimension
d = size(QC, 1);

% keyframe
if ~isKey
    lnWid = lnWid - .5;
end

% joint connection
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

% do not show the head joint because it is ugly
if ~isempty(skel)
    headJ = strloc('head', skel.tree, 'name');
    headConn = 0;
    for i = 1 : nB
        if any(Conn(:, i) == headJ)
            headConn = i;
            break;
        end
    end
    if headConn ~= 0
        xB(:, headConn) = [];
        yB(:, headConn) = [];
        if d == 3
            zB(:, headConn) = [];
        end
    end
else
    headConn = 0;
end

% plot connection of joints as lines
hConn = [];
if lnWid > 0
    if d == 3
        hConn = plot3(xB(:), yB(:), zB(:), lnMk, 'Color', cl, 'LineWidth', lnWid);
    else
        hConn = plot(xB(:), yB(:), lnMk, 'Color', cl, 'LineWidth', lnWid);
    end
end

% plot neck as a large ball
if ~isempty(skel)
    neckJ = strloc('upperneck', skel.tree, 'name');
    if neckJ == 0
        neckJ = strloc('neck', skel.tree, 'name');
    end
end

hNeck = [];
if neckJ ~= 0 && nkSiz > 0
    if d == 3
        hNeck = plot3(QC(1, neckJ), QC(3, neckJ), QC(2, neckJ), ...
                      'o', 'MarkerFaceColor', cl, 'MarkerEdgeColor', cl, 'MarkerSize', nkSiz);
    else
        hNeck = plot(QC(1, neckJ), QC(2, neckJ), ...
                     'o', 'MarkerFaceColor', cl, 'MarkerEdgeColor', cl, 'MarkerSize', nkSiz);
    end
end

% store
ha.Conn = Conn;
ha.headConn = headConn;
ha.hConn = hConn;
ha.neckJ = neckJ;
ha.hNeck = hNeck;
