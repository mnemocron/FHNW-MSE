%******************************************************************************
% \details     : FTP_CompAlg Spline Interpolation Exercises 4
% \autor       : Simon Burkhardt
% \file        : compAlg_ex4_spline_interpol_.m
% \date        : 2020.10.07
% \version     : 1.0
%******************************************************************************
%% Exercise 1 a)
clear; clc; close all

x = [0, pi/3, 2*pi/3, pi];
y = [0, sqrt(3)/2, sqrt(3)/2, 0];
h = diff(x);

h0=h(1); h1=h(2); h2=h(3);

M = [ 2*(h0+h1),    h1,        0;
         h1,     2*(h1+h2),    h2 ];

% syms c1 c2;

L = [ 3*( ( y(3)-y(2) )/(h1) - ( y(2)-y(1) )/(h0) );
      3*( ( y(4)-y(3) )/(h2) - ( y(3)-y(2) )/(h1) )];

c = linsolve(M, L);

c0 = 0;
c1 = c(1)
c2 = c(2) % is this the correct order in the solution array?
c3 = c(3)  % ????   c3 = c(3)

% Si(x) = ai   +   bi * (x - xi)   +   ci * (x - xi)^2   +   di*(x - xi)^3
% Si(x) for i = {0 ... n-1}

a0 = y(1);  % y0
a1 = y(2);  % y1
a2 = y(3);
a3 = y(4);

d0 = (c1-c0)/(3*h0)
d1 = (c2-c1)/(3*h1)
d2 = (  -c2)/(3*h2)

b0 = (a1-a0)/h0 - (2*c0+c1)/3*h0  % i = 1
b1 = (a2-a1)/h1 - (2*c1+c2)/3*h1  % i = 2
b2 = (y(4)-a2)/h2 - c2*h2 - d2*(h2^2) % - (2*c2+c3)/3*h2  % i = 3

S0 = @(x) a0 + b0*(x - x(1)) + c0*(x - x(1)).^2 + d0*(x - x(1)).^3
S1 = @(x) a1 + b1*(x - x(1)) + c1*(x - x(1)).^2 + d1*(x - x(1)).^3
S2 = @(x) a2 + b2*(x - x(1)) + c2*(x - x(1)).^2 + d2*(x - x(1)).^3

x0 = linspace(0, pi/3);
x1 = linspace(pi/3, 2*pi/3);
x2 = linspace(2*pi/3, pi);

y0 = S0(x0);
y1 = S1(x1);
y2 = S2(x2);

xi = [x0, x1, x2];
yi = [y0, y1, y2];

plot(xi, yi)
hold on
grid on
plot(x, y, 'o')

%% Exercise 1 b)
clear; clc; close all

x = [0, pi/3, 2*pi/3, pi];
y = [0, sqrt(3)/2, sqrt(3)/2, 0];
h = diff(x);
h0=h(1); h1=h(2); h2=h(3);
x0=x(1); x1=x(2); x2=x(3); x3=x(4);
y0=y(1); y1=y(2); y2=y(3); y3=y(4);
n = length(x)-1;

% b0 = y0'   y = sin(x)  ==> y' = cos(x)
ys0 = cos(x(0+1));
ys3 = cos(x(n+1));

% 1. ai = yi
a = y;
a0 = a(1);
a1 = a(2);
a2 = a(3);
a3 = a(4);

% 2. calc ci

M=[ 2*h0,   h0,       0;
     h1, 2*(h1+h2),   h2;
     0,     2*h1,   4*h1+3*h2;];

L=[3*( (a1-a0)/h0 - ys0 );
   3*( (a2-a1)/h1 - (y1-y0)/h0 );
   9*( (y3-a2)/h2) - 6*( (a2-a1)/h1 ) - 3*ys3 ];

c = linsolve(M, L);

c0 = c(1);
c1 = c(2);
c2 = c(3);

c = [c0, c1, c2];

d0 = (c1-c0)/(3*h0);
d1 = (c2-c1)/(3*h1);
d2 = (  -c2)/(3*h2);
d = [d0, d1, d2];

i=1;
b0 = (a(i+1)-a(i-1+1))/h(i-1+1) - (2*c(i-1+1)+c(i+1))/3*h(i-1+1);
i=2;
b1 = (a(i+1)-a(i-1+1))/h(i-1+1) - (2*c(i-1+1)+c(i+1))/3*h(i-1+1);
b2 = (y(n+1)-a(n-1+1))/h(n-1+1) - c(n-1+1)*h(n-1+1) - d(n-1+1)*h(n-1+1)^2;

S0 = @(x) a0 + b0*(x - x(1)) + c0*(x - x(1)).^2 + d0*(x - x(1)).^3;
S1 = @(x) a1 + b1*(x - x(1)) + c1*(x - x(1)).^2 + d1*(x - x(1)).^3;
S2 = @(x) a2 + b2*(x - x(1)) + c2*(x - x(1)).^2 + d2*(x - x(1)).^3;

x0 = linspace(0, pi/3);
x1 = linspace(pi/3, 2*pi/3);
x2 = linspace(2*pi/3, pi);

y0 = S0(x0);
y1 = S1(x1);
y2 = S2(x2);

xi = [x0, x1, x2];
yi = [y0, y1, y2];

% error - solution
ec0 = c0 - (-10*pi+18*sqrt(3))/2/pi/pi;
ec1 = c1 - (2*pi-9*sqrt(3))/2/pi/pi;
ec2 = c2 - (2*pi-9*sqrt(3))/2/pi/pi;

ed0 = d0 - ( 1/pi * (12*pi - 23*sqrt(3))/2/pi/pi )
ed1 = d1 - 0
ed2 = d2 - (27*sqrt(3)-12*pi)/2/pi/pi/pi

eb0 = b0 - 1
eb1 = b1 + (2*pi-9*sqrt(3))/6/pi
eb2 = b2 - 1/3 + 3*sqrt(3)/2/pi

plot(xi, yi)
hold on
grid on
plot(x, y, 'o')








