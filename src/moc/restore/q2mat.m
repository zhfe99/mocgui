function R = q2mat(Q)
% Convert rotation matrix to unit quaternion.
%
% Math
%   The resultant quaternion(s) will perform the equivalent vector transformation as:
%      qconj(q) * v * q = R * v
%   where R is the rotation matrix
%      v is a vector (a quaterion with a scalar element of zero)
%      q is the quaternion
%
% Input
%   Q       -  quaternion matrix, 4 x n
%
% Output
%   R       -  rotation matrix, 3 x 3 x n
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 04-02-2011
%   modify  -  Feng Zhou (zhfe99@gmail.com), 10-09-2011

% dimension 
n = size(Q, 3);

R = zeros(3, 3, n);
for i = 1 : n
    q = Q(:, i);
    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q0 = q(4);
    R(:, :, i) = [q0 ^ 2 + q1 ^ 2 - q2 ^ 2 - q3 ^ 2, 2 * (q1 * q2 - q0 * q3), 2 * (q1 * q3 + q0 * q2); ...
                  2 * (q1 * q2 + q0 * q3), q0 ^ 2 - q1 ^ 2 + q2 ^ 2 - q3 ^ 2, 2 * (q2 * q3 - q0 * q1); ...
                  2 * (q1 * q3 - q0 * q2), 2 * (q2 * q3 + q0 * q1), q0 ^ 2 - q1 ^ 2 - q2 ^ 2 + q3 ^ 2]';
end
