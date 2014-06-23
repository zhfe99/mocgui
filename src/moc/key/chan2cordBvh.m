function [Cord, conn] = chan2cordBvh(skel, chan)
% Parse the channels of each joint to obtain their coordinates and attached bones.
%
% Input
%   skel    -  skeleton
%   chan    -  joint channels, nC x nF
%
% Output
%   Cord    -  3-D joint coordinates, 3 x nJ x nF
%   Conn    -  the joint connection, 2 x nB
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify  -  Feng Zhou (zhfe99@gmail.com), 01-02-2014

prIn('chan2cordBvh');

% dimension
nF = size(chan, 2);
kJ = length(skel.tree);

% transform
Cord = zeros(3, kJ, nF);
for iF = 1 : nF
    Cordi = skel2xyz(skel, chan(:, iF)') * 10;
    Cord(:, :, iF) = Cordi';
end

% connection of joint
A = skelConnectionMatrix(skel);
Vis = zeros(kJ, kJ);
for i = 1 : kJ
    for j = 1 : length(skel.tree(i).children)    
        Vis(i, skel.tree(i).children(j)) = 1;
    end
end
indices = find(Vis);
nB = size(indices, 1);
conn = zeros(2, nB);
[conn(1, :), conn(2, :)] = ind2sub([kJ, kJ], indices);

prOut;
