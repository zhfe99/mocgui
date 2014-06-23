function Q = expq(QL)
% Calculate the exponential map of quaternion.
%
% Input
%   QL      -  logarithm map, (k x 3) x n
%
% Output
%   Q       -  quaternion matrix, (k x 4) x n
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-02-2011
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% dimension
[k, n] = size(QL);
k = round(k / 3);
Q = zeros(4 * k, n);

for i = 1 : n
    for c = 1 : k
        qL = QL((c - 1) * 3 + 1 : c * 3, i);
        
        alpha2 = norm(qL);
        if abs(alpha2) < eps
            v = zeros(3, 1);
        else
            v = qL / alpha2;
        end

        q = [v * sin(alpha2); cos(alpha2)];

        Q((c - 1) * 4 + 1 : c * 4, i) = q;
    end
end
