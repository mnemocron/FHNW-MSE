%******************************************************************************
% \details     : FTP_CompAlg Least Squares Approximation Exercises 6
% \autor       : Simon Burkhardt
% \file        : compAlg_ex6_leastsquares.m
% \date        : 2020.10.21
% \version     : 1.0
%******************************************************************************
%% Exercise 1 a)
clear all; close all; clc;

val = [[1,1.04];[2,1.37];[3,1.70];[4,2.00];[5,2.26]; 
 [6,2.42];[7,2.70];[8,2.78];[9,3.00];[10,3.14]];

x = val(:,1)';
y = val(:,2)';

x = x(2:6);
y = y(2:6);

m=2;
N=length(x)-1;

G = zeros(N,m+1);

G(:,1) = (x').^0;
G(:,2) = (x').^1;
G(:,3) = (x').^2;

GtG = G'*G;
y=y';

% b)
%%%% IMPORTANT !
a = linsolve(G'*G, G'*y)  % ATTENTION! use Z (for 3 dimensions)

t = linspace(min(x)-3, max(x)+3, 1e3);
z = a(1) + a(2).*t + a(3).*t.^2;

plot(x, y, 'o');
hold on;
grid on;
plot(t, z)

% c)
x = 4;      % middle Point of 5 Data points
y = a(1) + a(2)*x + a(3)*x^2  % approx value
ys = a(2) + 2*a(3)*x          % approx derrivative

%% Exercise 4
N = 4;
k = 2;
% t = x-3;
x = val(:,1)'; x = x(2:6)';
y = val(:,2)'; y = y(2:6)';

h = abs(x(2)-x(1));
t = (x - x(1))./h;

% for i=0:k  sum (-1)^i * nchoosek(k,i) * nchoosek(k+i, i) * t(i) / N (i)

%p_k_N

k=0;
p_0_4 = @(t) t.^0;  ;(-1)^0 .* nchoosek(k,0) .* nchoosek(k+0, 0) .* 1 ./ 1;

k=1;
p_1_4 = @(t) (-1)^0 .* nchoosek(k,0) .* nchoosek(k+0, 0) .* 1 ./ 1 + ...
    (-1)^1 .* nchoosek(k,1) .* nchoosek(k+1, 1) .* t ./ (N);

k=2;
p_2_4 = @(t) (-1)^0 .* nchoosek(k,0) .* nchoosek(k+0, 0) .* 1 ./ 1 + ...
    (-1)^1 .* nchoosek(k,1) .* nchoosek(k+1, 1) .* t ./ (N) + ...
    (-1)^2 .* nchoosek(k,2) .* nchoosek(k+2, 2) .* t.*(t-1) ./ (N.*(N-1));


G=[p_0_4(t),p_1_4(t),p_2_4(t)]
a = linsolve(G'*G, G'*y)

sol =@(t) a(1).*p_0_4(t) + a(2).*p_1_4(t) + a(3).*p_2_4(t);

xx = linspace(min(t)-3, max(t)+3, 1e3);
yy = sol(xx);

plot(x, y, 'o');
hold on;
grid on;
plot(xx+x(1), yy);


%% Exercise 5 
clear all; close all; clc;

x = [-2,-1, 0, 1, 2]';
y = [0, 1, 2, 3, 1]';

g0 = @(x) x.^0;
g1 = @(x) -x./2;
g2 = @(x) (x.^2)./2 -1;

G = [g0(x), g1(x), g2(x)];


% ... todo


%% Exercise 3
clear all; close all; clc;

x = [1 2 3 4 5 6 7 8 9 10];
y = [1.04, 1.37, 1.7, 2, 2.26, 2.42, 2.7, 2.78, 3, 3.14];

yp = y;

h=1;

for t=3:8
    xi = x(t-2:t+2);
    yi = y(t-2:t+2);
    a0 = 1/35 * ( -3*y(t-2) +12*y(t-1) +17*y(t) +12*y(t+1) -3*y(t+2) );
    a1 = 1/10 * ( -2*y(t-2)    -y(t-1)             +y(t+1) +2*y(t+2) );
    a2 = 1/14 * (  2*y(t-2)  -3*y(t-1)  -2*y(t)    -y(t+1) +2*y(t+2) );
    
    yi = a0; %+ t*a1 + t^2*a2
    yp(t) = yi;
end

plot(x, y, 'o-'); hold on
plot(x, yp, 'o-');






















