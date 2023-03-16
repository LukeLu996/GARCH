% This function evaluates the value of the likelihood function
% used in coefficients estimation for the conditional variance of
% GARCH(1,1) process
%
% SYNTAX
% y = garchLikelihood(x,data,initVariance)
% INPUTS
% x           : parameter values (order: omega,alpha,beta)
% data        : GARCH(1,1) process data
% initVariace : initial variance for GARCH(1,1) process
% OUTPUT
% y           : value of the likelihood function
%
% GARCH(1,1) process: 
% y(t) = sqrt(variance(t))*Norm(t), Norm(t) ~ iid Normal(0,1)
% Conditional variance of GARCH(1,1) process:
% variance(t) = omega + alpha*y(t-1)^2 + beta*variance(t-1)

function y = garchLikelihood(x,data,initVariance) 

omega = x(1);
alpha = x(2);
beta = x(3);

numData = size(data(:,1),1);
sigma = zeros(numData,1);
sigma(1) = initVariance;
likelihood = 0;
for i=2:numData
    sigma(i) = omega + alpha*data(i-1)^2 + beta*sigma(i-1);
    likelihood = likelihood + (-0.5*log(2*pi)-0.5*log(sigma(i)) - 0.5*data(i)^2/sigma(i));
end
y = -likelihood;
