function mocTimer
% Play motion capture when timer is trigged.
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-26-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 09-11-2009

global slPos;
global iF nF dF;
global st ti;

mocShow(1);

iF = iF + dF;
iF = min(iF, nF);
set(slPos, 'Value', iF);

if iF == nF
    st = 2;
    stop(ti);
end
