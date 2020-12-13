%******************************************************************************
% \details     : FTP_CompAlg Newtonian Interpolation Example w/ plot
% \autor       : Simon Burkhardt
% \file        : compAlg_newt_interpol_plot.m
% \date        : 2020.09.22
% \version     : 1.0
%******************************************************************************
%%
clear; clc; close all

% Ex. 4 <) (Schaum 8.23)
% or play with the values
x = [0,1,4,6];
y = [1,-1,1,-1];

a0 = y(1)
a1 = (y(2)-y(1))/(x(2)-x(1))

y12 = (y(3)-y(2))/(x(3)-x(2))
y012 = (y12-a1)/(x(3)-x(1))
a2 = y012;

y23 = (y(4)-y(3))/(x(4)-x(3))
y123 = (y23-y12)/(x(4)-x(2))

a3 = (y123-y012)/(x(4)-x(1))

% Definition 1.1 Newton basis polynomials
pi0 = 1;
pi1 = @(xk) (xk - x(1));
pi2 = @(xk) (xk - x(1)).*(xk - x(2));
pi3 = @(xk) (xk - x(1)).*(xk - x(2)).*(xk - x(3));

% full interpolation function
f = @(xk) ( a0.*pi0 + a1.*pi1(xk) + a2.*pi2(xk) + a3.*pi3(xk) );

% check initial values
f(x(1)) == y(1)
f(x(2)) == y(2)
f(x(3)) == y(3)
f(x(4)) == y(4)

%%
% create interpolated graph
t = linspace(x(1),x(4), 1e3);
v = f(t);

plot(x,y, 'o');
grid on;
hold on;
plot(t,v)
















