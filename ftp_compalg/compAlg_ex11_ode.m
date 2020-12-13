%******************************************************************************
% \details     : FTP_CompAlg Exercises 11 ODE solver
% \autor       : Simon Burkhardt
% \file        : compAlg_ex11_ode.m
% \date        : 2020.11.25
% \version     : 1.0
%******************************************************************************
%% Exercise 1 a)
clear all; close all; clc;
format long

x0 = 1;
y0 = 1;

h=0.1;

ys1 = @(x,y) x.*y.^(1/3);
ys2 = @(x,y) y.^(1/3) + 1/3.*x.^2.*y.^(-1/3);
ys3 = @(x,y) x.*y.^(-1/3) -1/9.*x.^3.*y.^-1;
ys4 = @(x,y) y.^(-1/3) -2/3.*x.^2.*y.^-1 + 1/9.*x.^4.*y.^(-5/3);

ykh = @(x, y0, h) y0 + ys1(x,y0)./(factorial(1)).*h + ys2(x,y0)./(factorial(2)).*h.^2 + ...
    ys3(x,y0)./(factorial(3)).*h.^3 + ys4(x,y0)./(factorial(4)).*h.^4;

y1 = ykh(x0, y0, h);
y2 = ykh(x0+h, y1, h);  % use the previous step y1 !!

y1 = round(y1, 10)
y2 = round(y2, 10)

% b) error
y =@(x) ((x.^2+2)./3).^(3/2);
xp = [x0, x0+h, x0+2*h];
yp = [y0, y1, y2];

% GLOBAL ERROR
error = yp - [y(xp)];
err_global = max(error);

% LOCAL ERROR
% watch out! h^(p-1) ...
yeloc = @(x, y0, h) ys1(x,y0)./(factorial(1)) + ys2(x,y0)./(factorial(2)).*h + ...
    ys3(x,y0)./(factorial(3)).*h.^2 + ys4(x,y0)./(factorial(4)).*h.^3;
err_local = (y(x0+h) - y(x0))/(h) - (yeloc(x0,y0,h))


% x = linspace(1,1.2, 1e3);
% ye = y(x);
% 
% plot(x, ye);
% hold on
% plot(xp, yp, 'o');


%%
%% Exercise 2 a)
clear all; close all; clc;
format long

phi0 = 0;
t0 = 0;
% Figure 1.2b
h = 0.5;
eps = 0.25;
c = 1;

phi1 = phi0 + c*(1-eps)^2 *h

%%
clear all; close all; clc;

phi0 = 0;
t0 = 0;
% Figure 1.3b
h = 0.5;
eps = 0.25;
c = 1;

phi1 = phi0 + c*(1-eps*cos(phi0))^2*h + 1/factorial(1)*(2*c*sin(phi0) - c*eps^2*sin(2*phi0))*c*(1-eps*cos(phi0))^2*h^2

%%






