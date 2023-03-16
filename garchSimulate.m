% This function generates GARCH(1,1): GARCH process and its variance
% SYNTAX 
% [data,sigma] = garchSimulate(parameters,numData,rng)
% INPUTS
% parameters : coefficients of the process [omega,alpha,beta] (see below)
% numData    : number of data points to generate
% random     : fixing random number generator (0 - not fixing)
% OUTPUTS
% data       : GARCH(1,1) process
% sigma      : conditional variance of the process

% GARCH(1,1) process: 
% y(t) = sqrt(variance(t))*Norm(t), Norm(t) ~ iid Normal(0,1)
% Conditional variance of GARCH(1,1) process:
% variance(t) = omega + alpha*y(t-1)^2 + beta*variance(t-1)

% EXAMPLE
% parameters = [0.001,0.2,0.5];
% [data,sigma] = garchSimulate(parameters,500,1)

function [data,sigma] = garchSimulate(parameters,numData,random)
if random
    rng default; % Fix the random number generator (for reproducibility)
end
% Normally distributed numbers
eps = randn(numData,1); 

% GARCH coefficients
omega = parameters(1); 
alpha = parameters(2);
beta = parameters(3);

% Create an array for conditional variance
sigma = zeros(numData,1);
sigma(1) = omega/(1-alpha-beta); % Initial volatility (sqrt(variance)) value

% Evaluate conditional volatility 
for i=2:numData
    sigma(i) = omega + alpha*(eps(i-1))^2*sigma(i-1) + beta*sigma(i-1);
end
% Data that follows GARCH(1,1) process
data = eps.*sqrt(sigma);
