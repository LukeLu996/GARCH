rng(1); % Fix the random number generator (for reproducibility)
%% Gaussian noise
numData = 500; % Length of time series
errors = randn(numData,1); % Normally distributed numbers

% Plot Gaussian white noise
plot(errors)
axis([0 500 -5 5])

%% ARCH(1) process
% ARCH coefficients
omega = 0.1; 
alpha = 0.9;

% Create an array for conditional variance
sigma = zeros(numData,1);
sigma(1) = 0.4791;%sqrt(0.01); % Initial volatility (sqrt(variance)) value

% Evaluate conditional volatility 
for i=2:numData
    sigma(i) = sqrt( omega + alpha*(errors(i-1)*sigma(i-1))^2 );
end
% Data that follows ARCH(1) process
ARCH1 = errors.*sigma;
figure(2)
plot(ARCH1)
axis([0 500 -5 5])

%% ARCH(4) process
% Length of time series (add 4 (ARCH4) to make simulated series 
% length 500)
numData = 500+4; 
errors = randn(numData,1); % Normally distributed numbers

% ARCH coefficients
omega = 0.1; 
alpha1 = 0.36;
alpha2 = 0.27;
alpha3 = 0.18;
alpha4 = 0.09;

% Create an array for conditional variance
sigma = zeros(numData,1);
sigma(1) = sqrt(0.01); % Initial volatility (sqrt(variance)) value
sigma(2) = sigma(1);
sigma(3) = sigma(1);
sigma(4) = sigma(1);
% Evaluate conditional volatility 
for i=5:numData
    sigma(i) = sqrt( omega + alpha1*(errors(i-1)*sigma(i-1))^2+...
        alpha2*(errors(i-2)*sigma(i-2))^2+...
        alpha3*(errors(i-3)*sigma(i-3))^2+...
        alpha4*(errors(i-4)*sigma(i-4))^2);
end
% Data that follows ARCH(4) process
ARCH4 = errors(5:end).*sigma(5:end);
figure(3)
hold on, plot(ARCH4)
axis([0 500 -5 5])