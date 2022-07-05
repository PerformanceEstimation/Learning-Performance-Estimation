clear all; clc;
% This code corresponds to exercise 2.2 of the document
% https://github.com/PerformanceEstimation/Learning-Performance-Estimation/blob/main/Exercises/Course.pdf

% parameters to be tested:
L = 1;
mu = .1;
gamma = 1/L;

% SDP:
l1 = sdpvar(1,1); % lambda_1
tau = sdpvar(1);

s11 = tau-1+l1*L*mu/(L-mu);
s12 = gamma-l1*(L+mu)/2/(L-mu);
s22 =  l1/(L-mu)-gamma^2;

S = [s11 s12; s12 s22];

constraints = (S>=0);
constraints = constraints + (l1>=0);
    

options = sdpsettings('verbose',0);
status = optimize(constraints,tau,options);

double(tau) % this is the worst-case value computed by the SDP solver
double(l1)
eig(double(S))
