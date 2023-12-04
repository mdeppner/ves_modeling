%%Layout
%%-------L-------
%%           ---l---
%% A        M       N       B
%%  ---r1--
%%          --------r2-------
%%  --------r3-------
%%                    ---r4--

clc; clear; close all;
% Setup starting model and initial guess
Params=[200 500 300 100 1 3 2];
b_0 = [250 490 250 200 1.5 4 1];

%% Make your measurements
NumberOfMeasurements=100;
L = logspace(0.1,3,NumberOfMeasurements);
l = 0.01*L;                             
r1 = L-l;r2 = L+l; r3=L+l; r4 = L-l; % Schlumberger Geometry


%% Get the simulated data
[rho_semu] = VESForward_RD(Params, L);nobs=length(rho_semu);;
%% Add Noise
rho_semuN = rho_semu + randn(nobs,1)*3;


%% Maximum number of bootstraps possible factorial((2*factorial(n)-1))/(factorial(n)*(factorial(n-1))), 
numboots = 30
for kk=1:numboots
    ix = ceil(nobs*rand(1,nobs));
    

    %% Setup to find zeros using fmincon
    %ss = VESForward_RD_ss(Params, L,rho_semuN)

    [bminBootstrapped(kk,:),ssmin]=fmincon(@(b_0)VESForward_RD_ss(b_0,L(ix),rho_semuN(ix)),b_0,[],[],[],[],(1:length(Params))*0,(1:length(Params))*0+1e4);
    rho_semuInvertedBootstrapped(kk,:) = VESForward_RD(bminBootstrapped(kk,:), L);
    bminBootstrappedRel(kk,:) = bminBootstrapped(kk,:)/Params;
    ss(kk) = VESForward_RD_ss(bminBootstrapped(kk,:), L(ix),rho_semuN(ix))


end
figure(1)
for kk=1:numboots
    loglog(L,rho_semuInvertedBootstrapped(kk,:),'k--','LineWidth',1)
    hold on
end
loglog(L,rho_semuN,'gx')
figure(2)
for pp=1:length(Params)
    subplot(3,3,pp)
    hist(bminBootstrapped(:,pp));hold on
    xline(Params(pp),'g','LineWidth',3)
end

% hold on
% loglog(L,rho_semuN,'rx','LineWidth',3)
% loglog(L,rho_semuInverted,'g-','LineWidth',3)
% 
% bmin./Params

