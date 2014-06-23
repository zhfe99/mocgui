function h = animText(strs, varargin)
% Show text in the axes.
%
% Input
%   strs     -  string list, 1 x (m x 2) (cell)
%   varargin
%     show option
%     h0     -  initial handle, {[]}
%     wei    -  weight of text, {13}
%     col    -  text color, {'red'}
%     fontN  -  font name, {'Arial'}
%     fontW  -  font weight, {'Normal'}
%
% Output
%   h        -  handle
%
% History
%   create   -  Feng Zhou (zhfe99@gmail.com), 02-05-2009
%   modify   -  Feng Zhou (zhfe99@gmail.com), 05-18-2014

% show option
psSh(varargin);
h0 = ps(varargin, 'h0', []);
wei = ps(varargin, 'wei', 10);
col = ps(varargin, 'col', 'black');
fontN = ps(varargin, 'fontN', 'Arial');
fontW = ps(varargin, 'fontW', 'Normal');

pos = [0.5 0.5];
hAli = 'center';
vAli = 'middle';
color = 'k';

% content
m = round(length(strs) / 2);
str2s = cell(1, m);
for i = 1 : m
    name = strs{(i - 1) * 2 + 1};
    value = strs{i * 2};
    surfix = select(i == m, '', ' ');   

    str2s{i} = ['{\color{' col '}' value '}' surfix];
    if ~isempty(name)
        str2s{i} = [name ': ' str2s{i}];
    end
end
str = cat(2, str2s{:});

if isempty(h0)
    h = text('Position', pos, 'Units', 'normalized', ...
        'HorizontalAlignment', hAli, 'VerticalAlignment', vAli, ...
        'String', str, 'Color', color, 'FontSize', wei, 'FontWeight', fontW, 'FontName', fontN);

else
    set(h0, 'String', str);
    h = h0;
end
