function ha = shMocG(QC, varargin)
% Show the underground of a mocap sequence.
%
% Input
%   QC       -  2D or 3D coordinates of all joints, d x nJ x nF
%   varargin
%     show option
%     box0   -  predefined 2D or 3D bounding box, {[]}
%     vwAgl  -  view angle, {[15 30]}
%     gnd    -  flag of showing underground, {'y'} | 'n'
%     clGnd  -  color of underground, [0 0 0] + .5
%     ij     -  flag of using "axis ij", {'y'} | 'n'
%
% Output
%   ha       -  handler
%
% History
%   create   -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify   -  Feng Zhou (zhfe99@gmail.com), 07-14-2014

% show option
psSh(varargin);

% function option
box0 = ps(varargin, 'box0', []);
vwAgl = ps(varargin, 'vwAgl', [15 30]);
isGnd = psY(varargin, 'gnd', 'y');
clGnd = ps(varargin, 'clGnd', [0 0 0] + .8);
isIJ = psY(varargin, 'ij', 'y');

% dimension
d = size(QC, 1);

% bounding box
if isempty(box0)
    if d == 3
        box = cordBox(QC, []);
    else
        box = zeros(2, 2);
        X = QC(1, :, :); 
        Y = QC(2, :, :); 
        box(1, :) = [min(X(:)), max(X(:))];
        box(2, :) = [min(Y(:)), max(Y(:))];
    end
else
    box = box0;
end
ha.box = box;

% axis
hold on;
if d == 3 && isIJ
    axis ij;
end
grid off;
axis equal;
if d == 3
    set(gca, 'xlim', box(1, :), 'ylim', box(2, :), 'zlim', box(3, :));
    view(vwAgl);
else
    set(gca, 'xlim', box(1, :), 'ylim', box(2, :));
end

% plot the underground
if d == 3 && isGnd
    fill3([box(1, 1), box(1, 2), box(1, 2), box(1, 1)], ...
          [box(2, 1), box(2, 1), box(2, 2), box(2, 2)], ...
          [box(3, 1), box(3, 1), box(3, 1), box(3, 1)], clGnd, 'EdgeColor', 'none');
end
axis off;
