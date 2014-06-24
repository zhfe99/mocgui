function data = mocDataIdx(dbe, pno)
% Obtain all available mocap sequences with the specified constraint.
%
% Input
%   dbe     -  database, 'mocap' | 'kitchen'
%   pno     -  person number
%
% Output
%   data    -  data set, 1 x m (cell)
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-07-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 06-24-2014

if nargin > 2
    error('too many parameters');
end

% 0 parameter
if nargin == 0
    data = {'mocap', 'kitchen'};
    return;
end

% all data
CMU = mocHuman;
names = fieldnames(CMU);
n = length(names);

% parse field name
[dbes, pnos, trls] = cellss(1, n);
for i = 1 : n
    tokens = tokenise(names{i}, '_');

    dbes{i} = dbe;
    pnos{i} = tokens{1};
    trls{i} = tokens{2};
end

% fetch the pnos of the predefined type
visDbe = strcmp(dbes, dbe);

if nargin == 1
    % 1 parameter
    pnos = {pnos{find(visDbe)}};
    n = length(pnos);

    % remove the same strings
    vis = ones(1, n);
    s = pnos{1};
    for i = 2 : n
        if strcmp(s, pnos{i})
            vis(i) = 0;
        else
            s = pnos{i};
        end
    end
    data = {pnos{find(vis)}};
    n = length(data);
    
    % sort
    dig = zeros(1, n);
    for i = 1 : n
        if strcmp(data{i}(1), 'S')
            dig(i) = atoi(data{i}(2 : end));
        else
            dig(i) = atoi(data{i});
        end
    end
    [dig, idx] = sort(dig);
    data = {data{idx}};
    
else
    % 2 parameters
    visPno = strcmp(pnos, pno);
    vis = visDbe & visPno;
    
    data = {trls{find(vis)}};
end
