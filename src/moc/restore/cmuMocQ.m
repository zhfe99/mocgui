function wsMocs = cmuMocQ(src, joinF, XQs)
% Restore quaternion to CMU motion capture data.
%
% Input
%   src     -  cmu src
%   joinF   -  joint
%   XQs     -  quaternion set, 1 x m (cell), dim x nF
%
% Output
%   wsMoc   -  mocap data
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-05-2011
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

prIn('cmuMocQ', '%s', src.nm);

% dimension
m = length(XQs);

% path
[~, asfpath] = cmuPath(src);

% skel
skel = asf2skel(asfpath);

wsMocs = cell(1, m);
for i = 1 : m
    % restore quaternion
    Q = expq(XQs{i});

    % restore DOF
    DofF = q2dof(Q);
    [Dof, join] = dofFill(DofF, joinF);

    % restore coordinate
    chan = dof2chan(skel, Dof, join);
    [cord, conn] = chan2cord(skel, chan);

    % store
    wsMocs{i} = st('Dof', Dof, 'join', join, 'skel', skel, 'chan', chan, 'cord', cord, 'conn', conn);
end

prOut;
