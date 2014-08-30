% function [s, l] = L2SL(l0)
% Trace back to determine the segmentation.
%
% There are two implementations:
%   Matlab version: L2SLSlow.m
%   C++ version:    L2SL.cpp
%
% Input
%   k       -  #class
%   sOpt    -  optimum starting position, 1 x n
%   cOpt    -  optimum label, 1 x n
%
% Output
%   seg     -  segmentation
%
% History
%   create  -  Feng Zhou (zhfe99@gmail.com), 07-28-2009
%   modify  -  Feng Zhou (zhfe99@gmail.com), 08-04-2014
