function update(act, tag, val)
% Main updating function. Update the control outlooks and manage the states.
%
% Input
%   act     -  action type, 0 | 1 | 2 | 3 | 4 | 5
%              0: initialize or click the poX menu
%              1: click the puLo button
%              2: click the puP button
%              3: adjust slider
%              4: edit the edDF editor
%   tag     -  tag of control
%   val     -  value of action
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-26-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 06-03-2013

% mocap data
global iF nF dF;

% controls
global poDbe poPno poTrl puLo;
global slPos puP edDF;

% states
global st ti;

% load data and initialize other controls
% click the poX menu (X is specific in tag)
if act == 0
    if strcmp(tag, 'none')
        % program begins
        upPoMoc('dbe', 0);

        set(poDbe, 'Enable',  'on');
        set(poPno, 'Enable',  'on');
        set(poTrl, 'Enable',  'on');
        set(puLo,  'Enable', 'off');

    else
        % click the poX menu
        upPoMoc(tag, val);

        if strcmp(tag, 'dbe')
            set(poPno, 'Enable',  'on');
            set(poTrl, 'Enable',  'on');
            set(puLo,  'Enable', 'off');
        elseif strcmp(tag, 'pno')
            set(poTrl, 'Enable',  'on');
            set(puLo,  'Enable', 'off');
        else
            set(puLo,  'Enable', 'on');
        end
    end

    mocLoad(0);
    mocShow(0);
    st = 0;

    set(slPos, 'Enable', 'off');
    set(puP,   'Enable', 'off', 'String', 'play');
    set(edDF,  'Enable', 'off', 'String', '1');

% click the puLo button
elseif act == 1

    mocLoad(0);
    mocShow(0);
    mocLoad(1);
    mocShow(1);
    st = 1;

    set(slPos, 'Enable',  'on', 'Min', 1, 'Max', nF, 'Value', 1, 'SliderStep', [dF / nF, .1]);
    set(puP,   'Enable',  'on', 'String', 'play');
    set(edDF,  'Enable',  'on');

% click the puP button (P is specific in tag)
elseif act == 2

    if st == 1
        st = 2;

        set(slPos, 'Enable', 'off');
        set(puP,   'Enable',  'on', 'String', 'pause');
        set(edDF,  'Enable', 'off');

        start(ti);

    elseif st == 2
        st = 1;

        set(slPos, 'Enable',  'on');
        set(puP,   'Enable',  'on', 'String', 'play');
        set(edDF,  'Enable',  'on');

        stop(ti);

    else
        error('unknown state');
    end

% click the slPos slider
elseif act == 3
    iF = val;
    mocShow(1);
 
% edit the edDF editor
elseif act == 4
    dF = atoi(val);
    set(slPos, 'SliderStep', [dF / nF, .1]);

else
    error('unknown state');
end
