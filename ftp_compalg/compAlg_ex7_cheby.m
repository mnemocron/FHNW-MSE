%******************************************************************************
% \details     : FTP_CompAlg Least Squares Approximation Exercises 7
% \autor       : Simon Burkhardt
% \file        : compAlg_ex7_cheby.m
% \date        : 2020.10.31
% \version     : 1.0
%******************************************************************************
%% Exercise 9 a)
clear all; close all; clc; format shorteng

f0 = @(x) sin(pi/2.*x + pi/2)   ./ sqrt(1-x.^2);
a0 = 1/pi*integral(f0,-1,1)

f1 = @(x) sin(pi/2.*x + pi/2) .*x ./ sqrt(1-x.^2);
a1 = 2/pi*integral(f1,-1,1)

f2 = @(x) sin(pi/2.*x + pi/2) .*(2.*x.^2 -1) ./ sqrt(1-x.^2);
a2 = 2/pi*integral(f2,-1,1)

f3 = @(x) sin(pi/2.*x + pi/2) .*(4.*x.^3 -3.*x) ./ sqrt(1-x.^2);
a3 = 2/pi*integral(f3,-1,1)

f4 = @(x) sin(pi/2.*x + pi/2) .*(8.*x.^4 -8.*x.^2 +1) ./ sqrt(1-x.^2);
a4 = 2/pi*integral(f4,-1,1)

T4 = @(x) a4 .*(8.*x.^4 -8.*x.^2 +1);
T4(-1)


%% Exercise 9 b)
clear all; close all; clc; format shorteng

f = @(x) sin( pi*(x+1)./2 );  % for w = 1
f0 =@(x) sin( pi*(x+1)./2 ) .* 1;
f1 =@(x) sin( pi*(x+1)./2 ) .* x;
f2 =@(x) sin( pi*(x+1)./2 ) .* (3/2.*x.^2 - 1/2);
f3 =@(x) sin( pi*(x+1)./2 ) .* (5/2.*x.^3 - 3/2.*x);
f4 =@(x) sin( pi*(x+1)./2 ) .* (35/8.*x.^4 - 30/8.*x.^2 - 3/8);
a0 = (2*0 +1)/2 * integral(f0,-1,1)
a1 = (2*1 +1)/2 * integral(f1,-1,1)
a2 = (2*2 +1)/2 * integral(f2,-1,1)
a3 = (2*3 +1)/2 * integral(f3,-1,1)
a4 = (2*4 +1)/2 * integral(f4,-1,1)



%% Exercise 10 c)
clear all; close all; clc; format shorteng

yf =@(x) 1 + x + x.^2./2 + x.^3./6 + x.^4./24;
T0 =@(x) x.^0;
T1 =@(x) x;
T2 =@(x) (2.*x.^2 -1);
T3 =@(x) (4.*x.^3 -3.*x);
T4 =@(x) (8.*x.^4 -8.*x.^2 +1);

a0 = 81/64;
a1 = 9/8;
a2 = 13/48;
a3 = 1/24;
a4 = 1/8/24;

P =@(x) a0*T0(x) + a1*T1(x) + a2*T2(x); % + a3*T3(x) + a4*T4(x);

x = linspace(-1,1,1e3);
% y1 = exp(x);
y1 = yf(x);
y2 = P(x);

err = y2 -y1;
plot(x,err); grid on

%%
plot(x,y1);
hold on; grid on;
plot(x,y2);

%% Exercise 10 d)

yt =@(x) 1 + x + x.^2./2;
y1 = yt(x);
y2 = P(x);

err2 = y2 -y1;
plot(x,err);
hold on; grid on;
plot(x,err2);







