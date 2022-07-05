clear all; clc;
% This code corresponds to exercise 2.3 of the document
% https://github.com/PerformanceEstimation/Learning-Performance-Estimation/blob/main/Exercises/Course.pdf

% symbolic parameters
syms gamma L mu;
% symbolic variables
syms l1 tau; % lambda_1 and tau

% LMI:

s11 = tau-1+l1*L*mu/(L-mu);
s12 = gamma-l1*(L+mu)/2/(L-mu);
s22 =  l1/(L-mu)-gamma^2;

S = [s11 s12; s12 s22];

% find the value of tau that cancels out the determinant of S
tau_candidate=solve(simplify(det(S))==0,tau,'ReturnConditions',true);

% differentiate the expression of tau wrt l1
dtau = simplify(diff(tau_candidate.tau,l1));
l1_candidates=solve(dtau==0,l1,'ReturnConditions',true);


%first candidate expression (to be verified afterwards):
simplify(subs(tau_candidate.tau,l1,l1_candidates.l1(1)))

%second candidate expression (to be verified afterwards):
simplify(subs(tau_candidate.tau,l1,l1_candidates.l1(2)))