function [Dof, R] = q2dof(Q)
% Convert quaternion to degree of freedom (DOF).
%
% Input
%   Q       -  quaternion matrix, (k x 4) x n
%
% Output
%   Dof     -  DOF matrix, (k x 3) x n
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-02-2011
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% dimension
[k, n] = size(Q);
k = round(k / 4);

% quaternion -> rotation matrix
R = zeros(3, 3, n, k);
for c = 1 : k
    for i = 1 : n
        R(:, :, i, c) = q2mat(Q((c - 1) * 4 + 1 : c * 4, i));
    end
end

% rotation matrix -> dof
Dof = zeros(k * 3, n);
for c = 1 : k
    for i = 1 : n
        rot = R(:, :, i, c);
        ang = SpinCalc('DCMtoEA321', rot, eps, 0);
        Dof((c - 1) * 3 + 1 : c * 3, i) = ang(end : -1 : 1);
    end
end

% change range [0 360] -> [-180 180]
Vis = Dof > 180;
Dof(Vis) = Dof(Vis) - 360;
