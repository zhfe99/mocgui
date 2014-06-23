function upPoMoc(tag, id)
% Updating for clicking the popup menu of motion capture source.
%
% Input
%   tag     -  action type, 'dbe' | 'pno' | 'trl'
%   id      -  element index
%              0: updating the content of the whole menu
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-08-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 06-03-2013

global dbe pno trl;
global dbes pnos trls;
global poDbe poPno poTrl;

% popup for Database (Dbe)
if strcmpi(tag, 'dbe')
    h = poDbe;
    if id == 0
        dbes = addS(mocDataIdx);
        set(h, 'String', dbes);
        id = 1;
    end
    set(h, 'Value', id);
    dbe = dbes{id};

    if strcmp(dbe, 'mocap')
        dbe = 'moc';
    elseif strcmp(dbe, 'kitchen')
        dbe = 'kit';
    end

    upPoMoc('pno', 0);
    return;
end

% popup for Person Number (Pno)
if strcmpi(tag, 'pno')
    h = poPno;
    if id == 0
        if strcmp(dbe, 'unknown')
            pnos = {'unknown'};
        else
            pnos = addS(mocDataIdx(dbe));
        end
        set(h, 'String', pnos);
        id = 1;
    end
    set(h, 'Value', id);
    pno = pnos{id};

    upPoMoc('trl', 0);
    return;
end

% popup for Trial (Trl)
if strcmp(tag, 'trl')
    h = poTrl;
    if id == 0
        if strcmp(pno, 'unknown')        
            trls = {'unknown'};
        else
            trls = addS(mocDataIdx(dbe, pno));
        end
        set(h, 'String', trls);
        id = 1;
    end
    set(h, 'Value', id);
    trl = trls{id};
    return;
end

error('unknown type');

%%%%%%%%%%%%%%%%%%%%%
function s = addS(s0)
m0 = length(s0);
s = cell(1, m0 + 1);
s{1} = 'unknown';
for i = 1 : m0
    s{i + 1} = s0{i};
end
