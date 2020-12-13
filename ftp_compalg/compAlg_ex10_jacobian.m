%******************************************************************************
% \details     : FTP_CompAlg Exercises 10 Jacobian Matrix
% \autor       : Simon Burkhardt
% \file        : compAlg_ex10_jacobian.m
% \date        : 2020.11.18
% \version     : 1.0
%******************************************************************************
%% Exercise 2 b)
clear all; close all; clc;

% not quite with sign of angle
% xE = @(r1,r2,r3,q1,q2,q3) (r2.*cos(q2) + r3.*cos(q3./2)).*cos(q1);
% yE = @(r1,r2,r3,q1,q2,q3) (r2.*cos(q2) + r3.*cos(q3./2)).*sin(q1);
% zE = @(r1,r2,r3,q1,q2,q3) r1 + r2.*sin(q2) + r3.*sin(q3./2);

xE = @(r1,r2,r3,q1,q2,q3) (r2.*cos(q2) + r3.*cos(q2-q3)).*cos(q1);
yE = @(r1,r2,r3,q1,q2,q3) (r2.*cos(q2) + r3.*cos(q2-q3)).*sin(q1);
zE = @(r1,r2,r3,q1,q2,q3) r1 + r2.*sin(q2) + r3.*sin(q2-q3);

%%
clear all; close all; clc;

syms r1 r2 r3 q1 q2 q3 x y z

glx = (r2*cos(q2) + r3*cos(q2-q3))*cos(q1);
gly = (r2*cos(q2) + r3*cos(q2-q3))*sin(q1);
glz = r1 + r2*sin(q2) + r3*sin(q2-q3);

dxdq1 = diff(glx, q1, 1);
dxdq2 = diff(glx, q2, 1);
dxdq3 = diff(glx, q3, 1);

dydq1 = diff(gly, q1, 1);
dydq2 = diff(gly, q2, 1);
dydq3 = diff(gly, q3, 1);

dzdq1 = diff(glz, q1, 1);
dzdq2 = diff(glz, q2, 1);
dzdq3 = diff(glz, q3, 1);

Jt = [ dxdq1, dxdq2, dxdq3;
       dydq1, dydq2, dydq3;
       dzdq1, dzdq2, dzdq3];

% Determinant
detJt = simplify(det(Jt));
pretty(detJt)

% Determinant ^2
pretty(simplify(detJt^2))

%%
clear all; close all; clc;

syms r1 r2 r3 q1 q2 q3 x y z

detJt = -r2*r3*(r2*cos(q2) + r3*cos(q2-q3))*sin(q3);

glx = x == (r2*cos(q2) + r3*cos(q2-q3))*cos(q1);
gly = y == (r2*cos(q2) + r3*cos(q2-q3))*sin(q1);
glz = z == r1 + r2*sin(q2) + r3*sin(q2-q3);

simplify(glx^2 + gly^2 + glz^2 - 2*r1*glz)

%%
clear all; clc;

r1 = rand();
r2 = rand();
r3 = rand();
q1 = rand();
q2 = rand();
q3 = rand();

% both solutions are equivalent !
-r2*r3*(- r3*sin(q2)*cos(q3)^2 + r3*cos(q2)*sin(q3)*cos(q3) + r3*sin(q2) + r2*cos(q2)*sin(q3))
-r2*r3*(r2*cos(q2) + r3*cos(q2-q3))*sin(q3)

%% Toy
clear all; clc; close all;

x =@(r1, r2, r3, q1, q2, q3) (r2.*cos(q2) + r3.*cos(q2-q3)).*cos(q1);
y =@(r1, r2, r3, q1, q2, q3) (r2.*cos(q2) + r3.*cos(q2-q3)).*sin(q1);
z =@(r1, r2, r3, q1, q2, q3) r1 + r2.*sin(q2) + r3.*sin(q2-q3);

r1 = 3;
r2 = 1;
r3 = 1;
q1 = linspace(0, 0, 1e3);
q2 = linspace(0, pi/2, 1e3);
q3 = linspace(0, pi/2, 1e3);

xi = x(r1, r2, r3, q1, q2, q3);
yi = y(r1, r2, r3, q1, q2, q3);
zi = z(r1, r2, r3, q1, q2, q3);

plot3(xi, yi, zi);
grid on;
xlabel("x")
ylabel("y")
axis equal

%% Determinant
clear all; clc; close all;

fx =@(r1, r2, r3, q1, q2, q3) (r2.*cos(q2) + r3.*cos(q2-q3)).*cos(q1);
fy =@(r1, r2, r3, q1, q2, q3) (r2.*cos(q2) + r3.*cos(q2-q3)).*sin(q1);
fz =@(r1, r2, r3, q1, q2, q3) r1 + r2.*sin(q2) + r3.*sin(q2-q3);
% detJt =@(r1, r2, r3, x, y, z) sqrt( r2.^2 .* r3.^2 .* ( x.^2+y.^2 ) .* ( 1- (x.^2+y.^2+z.^2+r1-r2-r3-2.*r1.*z)./(2.*r2.*r3)) );
detJt =@(r1, r2, r3, q1, q2, q3) -r2.*r3.*(r2.*cos(q2) + r3.*cos(q2-q3)).*sin(q3);

r1 = 3;
r2 = 1;
r3 = 1;

N = 5e4;
q1 = 2*pi*rand(1, N);
q2 = pi/2*rand(1, N);
q3 = pi/2*rand(1, N);

x = fx(r1, r2, r3, q1, q2, q3);
y = fy(r1, r2, r3, q1, q2, q3);
z = fz(r1, r2, r3, q1, q2, q3);

d = abs(detJt(r1, r2, r3, q1, q2, q3));

h = scatter3(x,y,z,3,d)
colormap jet
colorbar
axis equal
alpha = 0.1;
set(h, 'MarkerEdgeAlpha', alpha, 'MarkerFaceAlpha', alpha)
xlabel("x")
ylabel("y")
zlabel("z")












