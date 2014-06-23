function Cord = cordFilt(Cord0, skel, nmFs)
% Obtain the coordinates for the selected joints.
%
% Input
%   Cord0   -  original coordinates, 3 x kJ0 x nF
%   skel    -  skeleton
%   nmFs    -  new joint names, 1 x kJ (cell)
%
% Output
%   Cord    -  new coordinates, 3 x kJ x nF
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify  -  Feng Zhou (zhfe99@gmail.com), 12-22-2013

% dimension
[~, kJ0, nF] = size(Cord0);
kJ = length(nmFs);

% index of selected joints
idx = zeros(1, kJ);
for i = 1 : kJ
    idx(i) = strloc(nmFs{i}, skel.tree, 'name');
end

% filter
Cord = Cord0(:, idx, :);
