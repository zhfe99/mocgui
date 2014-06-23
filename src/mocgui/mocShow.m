function mocShow(act)
% Show Mocap frame for specific subject
%
% Input
%   act     -  action type, 1 | 0
%              1: load
%              0: clear
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-26-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 05-18-2014

global axMoc axTxt; 
global skel cord conn;
global hMoc hTxt;
global iF nF fst;

if act == 0
    set(gcf, 'CurrentAxes', axMoc); cla;
    set(gcf, 'CurrentAxes', axTxt); cla;

    hMoc = [];
    hTxt = [];
    return;
end

txt = sprintf('%d/%d', iF, nF);
if fst
    % mocap
    set(gcf, 'CurrentAxes', axMoc); cla;
    shMocG(cord);
    hMoc = shMocF(cord(:, :, iF), conn, skel);

    % txt
    set(gcf, 'CurrentAxes', axTxt); cla;
    hTxt = animText({'Frame', txt}, 'h0', []);

    fst = false;
else
    % mocap
    shMocFUpd(hMoc, cord(:, :, iF));

    % txt
    animText({'Frame', txt}, 'h0', hTxt);
end
drawnow;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function hMoc = showMocFst(cord, cone, skel)

% head
headJ = strloc('head', skel.tree, 'name');
headConn = 0;
for i = 1 : size(cone, 1)
    if cone(i, 1) == headJ || cone(i, 2) == headJ, headConn = i; break; end
end
hMoc.headJ = headJ;
hMoc.headConn = headConn;

% neck
neckJ = strloc('upperneck', skel.tree, 'name');
if neckJ == 0, neckJ = strloc('neck', skel.tree, 'name'); end
hMoc.neckJ = neckJ;

% line's width
lineStyle = '-';
color = 'b'; %'b';
colorGround = [1 1 1] * .6; % 'b';
lineWidth = 2; neckJSize = 10;

% coordinates
% joints
iF = 1;
xJ = cord(iF, :, 1); yJ = cord(iF, :, 3); zJ = cord(iF, :, 2);

% connection
xB = [cord(iF, cone(:, 1), 1); cord(iF, cone(:, 2), 1)];
yB = [cord(iF, cone(:, 1), 3); cord(iF, cone(:, 2), 3)];
zB = [cord(iF, cone(:, 1), 2); cord(iF, cone(:, 2), 2)];
if headConn ~= 0 % delete the head joint, because it is ugly when plotting.
    xB(:, headConn) = []; yB(:, headConn) = []; zB(:, headConn) = [];
end

% axis boundary
lim = zeros(3, 2);
X = cord(:, :, 1); Y = cord(:, :, 3); Z = cord(:, :, 2);
lim(1, :) = [min(X(:)), max(X(:))];
lim(2, :) = [min(Y(:)), max(Y(:))];
lim(3, :) = [min(Z(:)), max(Z(:))];

% plot a phantom point
plot3(xJ(1), yJ(1), zJ(1), '.', 'MarkerSize', 0.1);
hold on; axis ij; grid off; axis equal;
set(gca, 'xlim', lim(1, :), 'ylim', lim(2, :), 'zlim', lim(3, :));
viewAngle = [15 30];
view(viewAngle);

% ground
fill3([lim(1, 1), lim(1, 2), lim(1, 2), lim(1, 1)], ...
      [lim(2, 1), lim(2, 1), lim(2, 2), lim(2, 2)], ...
      [lim(3, 1), lim(3, 1), lim(3, 1), lim(3, 1)], colorGround, 'EdgeColor', 'none');
axis off;

% connection of joints
nB = size(xB, 2);
hConn = cell(1, nB);
for i = 1 : nB
    hConn{i} = line(xB(:, i), yB(:, i), zB(:, i), 'Color', color, 'LineWidth', lineWidth, 'LineStyle', lineStyle);
end
hMoc.hConn = hConn;

% neck
if neckJ ~= 0
    hMoc.hNeck = plot3(cord(iF, neckJ, 1), cord(iF, neckJ, 3), cord(iF, neckJ, 2), 'o', ...
                       'MarkerFaceColor', color, 'MarkerEdgeColor', color, 'MarkerSize', neckJSize);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function showMoc(cord, cone, hMoc)

% head
headConn = hMoc.headConn;

% neck
neckJ = hMoc.neckJ;

% connection
xB = [cord(1, cone(:, 1), 1); cord(1, cone(:, 2), 1)];
yB = [cord(1, cone(:, 1), 3); cord(1, cone(:, 2), 3)];
zB = [cord(1, cone(:, 1), 2); cord(1, cone(:, 2), 2)];
if headConn ~= 0 % delete the head joint, because it is ugly when plotting.
    xB(:, headConn) = []; yB(:, headConn) = []; zB(:, headConn) = [];
end

% connection of joints
nB = size(xB, 2);
for i = 1 : nB
    set(hMoc.hConn{i}, 'XData', xB(:, i), 'YData', yB(:, i), 'ZData', zB(:, i));
end

% neck
set(hMoc.hNeck, 'XData', cord(1, neckJ, 1), 'YData', cord(1, neckJ, 3), 'ZData', cord(1, neckJ, 2));
