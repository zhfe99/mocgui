function I = IAdd(I0)
% Convert the frame-based indicator matrix into segment-based indicator matrix.
% Add one row with ones for the column without any labels
%
% Input
%   I0      -  original frame-class indicator matrix, k x n
%
% Output
%   I       -  new frame-class indicator matrix, (k + 1) x n
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 03-03-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

[k, n] = size(I0);

I = zeros(k + 1, n);
vis = sum(I, 1) == 0;

I(1 : k, :) = I0;
I(k + 1, vis) = 1;
