clear all; clc;
% This code corresponds to exercise 2.6 of the document
% https://github.com/PerformanceEstimation/Learning-Performance-Estimation/blob/main/Exercises/Course.pdf

% parameters to be tested:
L = 1;
mu = .1;
gamma = .9/L;

% SDP:
lamb = sdpvar(6,1);
tau = sdpvar(1);

s11 = mu*L/(L-mu) * (lamb(1)+lamb(2)+lamb(3)+lamb(4));
s12 = -L/(L-mu) * (lamb(2)+gamma*mu*(lamb(3)+lamb(4))) - mu/(L-mu)*lamb(1);
s13 = -1/(L-mu) * (L*lamb(4)+mu*lamb(3));
s22 = 1/(L-mu) * (gamma*mu*(gamma*L*(lamb(3)+lamb(4)+lamb(5)+lamb(6))-...
    2*lamb(5))-2*gamma*L*lamb(6)+lamb(1)+lamb(2)+lamb(5)+lamb(6));
s23 = 1/(L-mu) * (gamma*L*lamb(4)+lamb(5)*(gamma*L-1)+...
    gamma*mu*(lamb(3)+lamb(6))-lamb(6));
s33 = 1/(L-mu) * (lamb(3)+lamb(4)+lamb(5)+lamb(6));

S = [s11 s12 s13; s12 s22 s23; s13 s23 s33];

constraints = (S>=0);
constraints = constraints + (lamb>=0);
constraints = constraints + (tau-lamb(1)+lamb(2)-lamb(5)+lamb(6)==0);
constraints = constraints + (-lamb(3)+lamb(4)+lamb(5)-lamb(6)==1);
    

options = sdpsettings('verbose',0);
status = optimize(constraints,tau,options);

double(tau) % this is the worst-case value computed by the SDP solver
double(lamb)