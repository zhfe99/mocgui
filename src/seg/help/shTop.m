function shTop(mod, varargin)
% Show data as points with different labels for different classes in 2-D figure.
%
% Input
%   mode          -  module of distributions
%   varargin
%     show option
%     lineWidth   -  line width, {1}
%
% History
%   create        -  Feng Zhou (zhfe99@gmail.com), 02-13-2009
%   modify        -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% parameter
psShow(varargin);
lineWidth = parseField(varargin, 'lineWidth', 1);

% filter the useful circles
mod1 = mod(1); me = mod1.me; var = mod1.var; unit = mod1.unit;
fk = size(me, 2); k = length(unit); vis = zeros(1, fk);
for c = 1 : k
    tmpUnit = unit{c};
    for i = 1 : length(tmpUnit)
        vis(tmpUnit(i)) = 1;
    end
end
useIdx = find(vis == 1);
showCircle(me(:, useIdx), var(:, useIdx));

% display the first level
[markers, colors] = genMarkers;
hold on;
for c = 1 : k
    X = me(:, unit{c});
    
    for i = 1 : size(X, 2) - 1
        line(X(1, i : i + 1), X(2, i : i + 1), 'Color', 'k', 'LineWidth', 1);
    end
end

% display the second level
if length(mod) > 1
    mod2 = mod(2); unit = mod2.unit; k = length(unit);
    for c = 1 : k
        XH = mod2.unitH{c};
        
        for i = 1 : size(XH, 2) - 1
            xh1 = XH(i); xh2 = XH(i + 1);
            X1 = mod1.unit{xh1}; X2 = mod1.unit{xh2};
            Y = me(:, [X1(end) X2(1)]);
            line(Y(1, :), Y(2, :), 'Color', colors{c}, 'LineWidth', lineWidth, 'LineStyle', '--');
        end
    end
end

