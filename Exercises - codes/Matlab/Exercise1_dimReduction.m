clear all; clc;
% This code corresponds to exercise 1.13 of the document
% https://github.com/PerformanceEstimation/Learning-Performance-Estimation/blob/main/Exercises/Course.pdf

% Initialize an empty PEP
P = pep();

% Set up the objective function (fix some parameter values)
paramf1.mu = 0;         % Strong convexity parameter
paramf1.L  = 1;         % Smoothness parameter
N          = 5;         % Number of iterations under consideration

f = P.DeclareFunction('SmoothStronglyConvex',paramf1);

% Set up the starting point and initial condition
x0      = P.StartingPoint();            % x0 is some starting point
[xs,fs] = f.OptimalPoint();             % xs is an optimal point, and fs=F(xs)

% Algorithm: gradient descent
gamma = 1;              % stepsize
x = x0;
for i = 1:N
    g = f.gradient(x);
    x = x - gamma * g;
end

% COMPLETE the following lines
P.InitialCondition( (x0-xs)^2 <= 1);    % Initial condition ||x0-xs||^2<= 1
P.PerformanceMetric( (x-xs)^2 );        % Performance metric ||x1-xs||^2

% (5) Solve the PEP
P.TraceHeuristic(1); % tries to find a low-dimensional worst-case instance
P.solve()

% (6) Evaluate the output
double((x-xs)^2)    % worst-case distance after N iteration (1==no progress)
double(g^2)         % gradient used in the last gradient step
