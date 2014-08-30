% A demo file for animating CMU motion capture data.
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 08-30-2014
%   modify  -  Feng Zhou (zhfe99@gmail.com), 08-30-2014

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

%% animate
anMocap(wsMoc);
