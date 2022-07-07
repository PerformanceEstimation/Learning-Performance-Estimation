clear all; clc;
% This code corresponds to exercise 1 of the document
% https://github.com/PerformanceEstimation/Learning-Performance-Estimation/blob/main/Exercises/Course.pdf
%
% This code must be completed for computing the worst-case ratio 
% ||x_{k+1} - x_*||^2 / ||x_k - x_*||^2 (note: we use k=0 without loss of
% generality for readability purposes!)
%
% Complete the code below accordingly:


% Initialize an empty PEP
P = pep();

% Set up the objective function (fix some parameter values)
paramf1.mu = .1;        % Strong convexity parameter
paramf1.L  = 1;         % Smoothness parameter

f = P.DeclareFunction('SmoothStronglyConvex',paramf1);

% Set up the starting point and initial condition
x0      = P.StartingPoint();            % x0 is some starting point
[xs,fs] = f.OptimalPoint();             % xs is an optimal point, and fs=F(xs)

% Algorithm: gradient descent
gamma = 1;              % stepsize
g0 = f.gradient(x0);
x1 = x0 - gamma * g0;

% COMPLETE the following lines
P.InitialCondition( g0^2 <= 1 );    
g1 = f.gradient(x1);
P.PerformanceMetric( g1^2 );         % Performance metric ||x1-xs||^2

% (5) Solve the PEP
P.solve()

% (6) Evaluate the output
double(g1)   % worst-case distance
