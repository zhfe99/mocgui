% A demo file for loading and visualizing motion capture data.
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 08-30-2014
%   modify  -  Feng Zhou (zhfe99@gmail.com), 09-03-2014

clear variables;
prSet(2); % set prompt level. a larger value (eg., 3) showing more details.

%% sequence id
sub = 2; % subject id
trl = 2; % trial id

%% src
src = cmuSrc(sub, trl);

%% mocap
wsMoc = cmuMoc(src, 'svL', 2); % '2' means it will automatically save the variable 'wsMoc' to disk after the first-time call
                               % Next time 'wsMoc' will be loaded from disk to save time.

%% animate the mocap as a movie
anMocap(wsMoc);

%% show one frame (eg., the 100-th frame) of the mocap
% frame index
iF = 100;

% creating figure
fig = 2;
Ax = iniAx(fig, 1, 1, [400 400]);

% set the 3D boundary of the mocap data
shMocG(wsMoc.QC, 'ax', Ax{1});

% show the frame
shMocF(wsMoc.QC(:, :, iF), wsMoc.Conn, wsMoc.skel);

% title
title(sprintf('Frame %d', iF));
