% Forward 1D DC Resistivity
% Reference: Ekinci Y L and Demirci A. 2008. J. of Appl. Sciences 8 (22): 4070-4078
% Modified: M. Heriyanto and W. Srigutomo. 2016. Journal of Physics: Conference Series 877 (2017) 012066.
% URL: https://github.com/mheriyanto/MH1DDC

%% Notes RD: 
%%  -- Understanding the coefficients is tedious, but lit suggests this works for Schlumberger Array
%%  -- I don't quite get why only AB/2 matters, but it appears that this is a solution where L>>l (Telford p. 541)

function [rho_semu_ss] = VESForward_RD_ss(Params, VectorABHalf, Data)
    % Params is first resistivities, then thickness of layers.
    % Params must be uneven. 
    % Data is Data vor VecgtorABHalf
  
    ParameterLength = length(Params);
    if rem(ParameterLength, 2) == 1         
         r = Params(1:(ParameterLength+1)/2)';       %resistivities
         t = Params((ParameterLength+1)/2+1:end)';   %depths
         s = VectorABHalf';


                %AB-Half Electrode Position           
                ls = length(s);
                u = zeros(ls,1);
                rho_semu = zeros(ls,1);
                display(strcat('size rho_semu:',num2str(size(rho_semu))))
                for ii = 1:ls
                    q = 13;
                    f = 10;
                    m = 4.438;
                    x = 0;
                    e = exp(log(10)/(2*m));
                    h = 2*q-2;
                    u(ii) = s(ii)*exp(-f*log(10)/m-x);                 % 1/lamda
                    l = length(r);
                    n = 1;
                    
                    li = n+h;
                    a = zeros(li);
                    for i = 1:li
                        w = l;                                      % w = i (n-1 th layer)
                        T = r(l);                                   % T = T(lamda)
                        while(w>1)
                            w = w-1;
                            aa = tanh(t(w)/u(ii));              % t(w) = depth
                            T = (T+r(w)*aa)/(1+T*aa/r(w));      % r = resistivity, T = T(lamda) 
                        end
                        a(i) = T;
                        u(ii) = u(ii)*e;
                    end
                
                    i = 1;
                    rho_a = 105*a(i)-262*a(i+2)+416*a(i+4)-746*a(i+6)+1605*a(i+8);
                    rho_a = rho_a-4390*a(i+10)+13396*a(i+12)-27841*a(i+14);
                    rho_a = rho_a+16448*a(i+16)+8183*a(i+18)+2525*a(i+20);
                    rho_a = (rho_a+336*a(i+22)+225*a(i+24))/10000;
                    rho_semu(ii) = rho_a;
                    
                    % add noise
                    % rho_semu(ii) = rho_a + 0.15*rho_a*rand();
                end
    else
        display('Params must be odd (first resistivities, then layer thicknesses.')
        rho_semu =0;
    end
    rho_semu_ss = sum((rho_semu-Data).^2)
end   



