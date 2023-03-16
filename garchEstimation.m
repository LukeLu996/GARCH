% This script generates GARCH(1,1) process and then evaluates
% the coefficients of conditional variance using maximum likelihood approach 
% GARCH(1,1) process: 
% y(t) = sqrt(variance(t))*Norm(t), Norm(t) ~ iid Normal(0,1)
% Conditional variance of GARCH(1,1) process:
% variance(t) = omega + alpha*y(t-1)^2 + beta*variance(t-1)

clear;
%% Generate the process
% Coefficients of conditional variance [omega,alpha,beta]
parameters = [0.0001,0.2,0.5]; 
numData = 500; % Length of timeseries
% Generate GARCH data (output is data, not variance)
[data,~] = garchSimulate(parameters,numData,1);

%% Estimate the parameters
% Evaluate the initial variance (exponential weighted moving average)
w = 0.06*0.94.^(0:numData-1);
initVariance = w*data.^2;
% Specify the starting point for optimization algorithm
initParam = [0.001,0.02,0.05];
options = optimset('Display','off');
[estimates,fval]=fmincon(@garchLikelihood,initParam,[0 1 1],1,[],[],[],[],[],options,...
    data,initVariance);

% Print the results
disp('    Parameter Estimates')
disp('----------------------------')
param = {'omega','alpha','beta'};
for i=1:length(estimates)
    fprintf('%10s %10.4f \n',param{i},estimates(i));
end

