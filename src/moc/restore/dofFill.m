function [Dof, join] = dofFill(DofF, joinF)
% Restore the DOFs.
%
% Input
%   DofF    -  DOF matrix after filtering, dim (= sum(joinF.dims)) x nF
%   joinF   -  joints after filtering
%     dims  -  DOF of each joint, 1 x nJF
%     nms   -  joint name, 1 x nJF (cell)
%
% Output
%   Dof     -  DOF matrix after filtering, dim (= sum(join.dims)) x nF
%   join    -  joints after filtering
%     dims  -  DOF of each joint, 1 x nJ
%     nms   -  joint name, 1 x nJ (cell)
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 12-29-2008
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% dimension
nF = size(DofF, 2);

% joints after filtering
[filt, nmFs, dimFs] = stFld(joinF, 'filt', 'nms', 'dims');
if ~strcmp(filt, 'all_cmu')
    error('unknown filtering method: %s', filt);
end

% joints before filtering
join = joinF.join;
[nms, dims] = stFld(join, 'nms', 'dims');

% dimensions
nJF = length(dimFs);
nJ = length(dims);
s = n2s(dims);

% index of used joints
idx = zeros(1, nJF);
for i = 1 : nJF
    for j = 1 : nJ
        if strcmpi(nmFs{i}, nms{j})
            idx(i) = j;
            break;
        end
    end
end

% restore
Dof = zeros(sum(dims), nF);
for i = 1 : nJF
    p = idx(i);
    d = dims(p);

    if strcmp(nms{p}, 'root')
        d = 3;
        Dof(s(p) + 3 : s(p) + 5, :) = DofF((i - 1) * 3 + 1 : (i - 1) * 3 + d, :);
    else
        Dof(s(p) : s(p) + d - 1, :) = DofF((i - 1) * 3 + 1 : (i - 1) * 3 + d, :);
    end
end
