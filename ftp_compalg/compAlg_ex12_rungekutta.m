%******************************************************************************
% \details     : FTP_CompAlg Exercises 12 Runge Kutta ODE Solver
% \autor       : Simon Burkhardt
% \file        : compAlg_ex12_rungekutta.m
% \date        : 2020.12.05
%******************************************************************************
%% Exercise 1 a)
clear all; close all; clc;
format long

p=4;
m=1/2; n=1/2;
h=0.1;
x0 = 1; x1 = 1.1; x2 = 1.2; x = [x0,x1,x2];
y0 = 1;

f =@(x,y) x.*y.^(1/3);
ye = @(x) ((x.^2+2)./3).^(3/2);
y = ye(x);

y1 = runge_kutta(f, x0, y0, h,m,n);
y2 = runge_kutta(f, x1, y1, h,m,n);
y3 = runge_kutta(f, x2, y2, h,m,n);

y1 = round(y1, 10)
y2 = round(y2, 10)
y3 = round(y3, 10)
yr = [y0, y1, y2];

%% b) local error (slope)
% xp = linspace(min(x), max(x), 1e3);
% yp = ye(xp);
% plot(xp,yp); hold on
% plot(x, yr, 'o');
clc;
err = ye(x) - [y0, y1, y2];
max(err)

[k1 k2 k3 k4] = runge_kutta_k(f, x0, ye(x0), h,m,n);
tau1 = (ye(x0+h)-ye(x0))/(h) - ( k1 + 2*k2 + 2*k3 + k4)/6/h
[k1 k2 k3 k4] = runge_kutta_k(f, x1, ye(x1), h,m,n);
tau2 = (ye(x1+h)-ye(x1))/(h) - ( k1 + 2*k2 + 2*k3 + k4)/6/h

%% Exercise 2
%  What is the crucial advantage of the Runge-Kutta method of order 4, i.e. RK4, over the Taylor 
% method of order 4. 

% no derrivatives are required !

%% Exercise 3
clear all; close all; clc;
m=1/2; n=1/2;
eps = 0.25;
c = 1;
h = 0.5;
f = @(t,phi) c.*(1-eps.*cos(phi)).^2;
phi0 = 0;
phi1 = runge_kutta(f, 1, phi0, h,m,n);
phi2 = runge_kutta(f, 1, phi1, h,m,n);

phik = runge_kutta(f, 1, phi0, h,m,n);
disp(strcat("tk ", num2str(0,2),  ":    ", num2str(round(phik,10))));
for tk=1:(8/0.5)
    phik = runge_kutta(f, 1, phik, h,m,n);
    disp(strcat("tk ", num2str((tk*h+h),2),  ":    ", num2str(round(phik,10))));
end

[k1 k2 k3 k4] = runge_kutta_k(f, 1, phi0, h,m,n);
round([k1 k2 k3 k4]', 10)

% local error
phi1 = 0.2837468640107449; % exact value
% phi1 = runge_kutta(f, 1, phi0, h,m,n)
% (k1 + 2*k2 + 2*k3 + k4)/(6*h)  =  approximated phi1
tau = (phi1 - phi0)/(h) - (k1 + 2*k2 + 2*k3 + k4)/(6*h)




%% classical RUNGE KUTTA 
function [yk] = runge_kutta(f,x0,y0,h,m,n)
    k1 = h*f(x0,y0);
    k2 = h*f(x0+m*h, y0+m*k1);
    k3 = h*f(x0+n*h, y0+n*k2);
    k4 = h*f(x0+  h, y0+  k3);
    yk = y0 + 1/6*( k1 + 2*k2 + 2*k3 + k4);
end

function [k1 k2 k3 k4] = runge_kutta_k(f,x0,y0,h,m,n)
    k1 = h*f(x0,y0);
    k2 = h*f(x0+m*h, y0+m*k1);
    k3 = h*f(x0+n*h, y0+n*k2);
    k4 = h*f(x0+  h, y0+  k3);
end

