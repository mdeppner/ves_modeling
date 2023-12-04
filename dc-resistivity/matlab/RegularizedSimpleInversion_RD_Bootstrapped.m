%%Layout
%%-------L-------
%%           ---l---
%% A        M       N       B
%%  ---r1--
%%          --------r2-------
%%  --------r3-------
%%                    ---r4--

clc; clear; close all;
%The Model for the Ammer Valley is approximately
% 0.5 m top soil 25 
% 3.5 m unsatuarted 210
% 6.6 m saturated 130
% Keuper 55

%Define your depth resolution (i.e. number of parameters)
dz=0.25;maxz=15;z=(0:dz:maxz);

%Use sigmoid and gauss function to make a smoothly varying four layer case
rhos= 130*exp(-(z-2).^2/0.8)+125./(1+exp(-(z-1)))-21./(0.3+exp(-(z-5)));

% % Setup starting model and initial guess. Now inverting for rho only

Params=[rhos z(1:end-1)];
b_0 = rhos*1.1*0+80;Np = length(rhos);
 
% %% Make your measurements
NumberOfMeasurements=50;
L = logspace(0.1,3,NumberOfMeasurements);
l = 0.01*L;                             
r1 = L-l;r2 = L+l; r3=L+l; r4 = L-l; % Schlumberger Geometry

if (1==1)
    load('RegularizedSimpleInversion_RD_Bootsrapped.mat')
else
    %% Get the simulated data
    [rho_semu] = VESForward_RD(Params, L);nobs=length(rho_semu);

    %% Add Noise
    rho_semuN = rho_semu + randn(nobs,1)*1.5;
    
    %%Get the smoothness constraint Matrix
    DD = diag((1:Np)*0+2)+diag((1:Np-1)*0-1,1)+diag((1:Np-1)*0-1,-1);
    DD = 1/dz^2*DD;
    DD(1,1)=-1/dz;DD(1,2)=1/dz;DD(1,3)=0;
    DD(end,end-1)=-1/dz;DD(end,end)=1/dz;DD(end,end-2)=0;
    
    rho_semuInitial = VESForward_RD([b_0 z(1:end-1)], L);
    
    LagrangeParameter = 1e-3; % From L-Curve Analysis
    
    options = optimoptions('fmincon','Display','iter','MaxFunctionEvaluations',10000,'StepTolerance',1e-10);
    
    %Normal Inversion
    [bminN,ssminN]=fmincon(@(b_0)VESForward_RD_ss_reg(b_0,z(1:end-1),L,rho_semuN,DD,LagrangeParameter),b_0,[],[],[],[],(1:Np)*0,(1:Np)*0+1e4,[],options);
    rho_semuInvertedN = VESForward_RD([bminN z(1:end-1)], L);
    
    %Bootstrapping
    numboots=20
    options = optimoptions('fmincon','Display','none','MaxFunctionEvaluations',10000);
    for kk=1:numboots
      kk
      ix = ceil(NumberOfMeasurements*rand(1,NumberOfMeasurements));
      [bmin(kk,:),ssmin(kk)]=fmincon(@(b_0)VESForward_RD_ss_reg(b_0,z(1:end-1),L(ix),rho_semuN(ix),DD,LagrangeParameter),b_0,[],[],[],[],(1:Np)*0,(1:Np)*0+1e4,[],options);
      rho_semuInverted(kk,:) = VESForward_RD([bmin(kk,:) z(1:end-1)], L);
    
      %ModelDataMisfit(kk) = norm(VESForward_RD([bmin z(1:end-1)], L)-rho_semuN)^2;
      %RegVal(kk) = norm(DD*bmin')^2; 
    
    end
    save('RegularizedSimpleInversion_RD_Bootsrapped.mat')
end
hh=figure(1)
subplot(1,2,1)
hold on;
for kk=1:numboots
    plot(bmin(kk,:),z,'Color',[0 0 0]+0.75,'LineWidth',1,'HandleVisibility','off');
end
plot(bmin(kk,:),z,'Color',[0 0 0]+0.75,'LineWidth',1);
plot(b_0*0+80,z,'k--')
plot(rhos,z,'g-','LineWidth',3)
plot(bminN,z,'b','LineWidth',3)
set(gca,'Ydir','reverse');
ylabel('Depth (m)')
xlabel('Spec. Resistivity (\Omega m)')
legend('Bootstraps','Initial Guess','Ideal','Inverted','Location','southeast')
legend box off;


subplot(1,2,2)

for kk=1:numboots
    loglog(L,rho_semuInverted(kk,:), 'Color',[0 0 0]+0.75,'LineWidth',1);hold on
end
loglog(L,rho_semuN, 'rx','MarkerSize',7);
loglog(L,rho_semu, 'g')
loglog(L,rho_semuInvertedN,'b')
xlabel('Distance (AB/2,m)')
ylabel('Apparant Resistivity (\Omega m)')
box off;

% Set figure position after plotting. A higher value for higher resolution
% only, you may use a smaller value.
set(hh,'Position',[0 0 1600 900]);
% Set PaperSize and PaperPosition according to 15 inch on both sides
set(hh,'PaperSize',[16 9],'PaperPosition',[0 0 16 9]); 
print(hh,'RegularizedSimpleInversion_RD_Bootsrapped.png','-dpng') % then print it

