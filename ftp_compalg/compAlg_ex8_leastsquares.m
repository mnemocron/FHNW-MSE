%******************************************************************************
% \details     : FTP_CompAlg Least Squares Approximation Exercises 8
% \autor       : Simon Burkhardt
% \file        : compAlg_ex8_leastsquares.m
% \date        : 2020.11.07
% \version     : 1.0
%******************************************************************************
%% Exercise 1 a)
clear all; close all; clc;

val = [[1,0,0]; [0,1,0]; [0,2,-1]; [1,3,1]];

x = val(:,1)';
y = val(:,2)';
z = val(:,3)';

m=1;
N=length(x)-1;

G = zeros(N+1,m+1);

G(:,1) = (x').^0;
G(:,2) = (x');
G(:,3) = (y');
% G(:,4) = (x'.*y');

% normal equations
GtG = G'*G
y=y';

a = linsolve(G'*G, G'*z')  % ATTENTION! use Z (for 3 dimensions)

p =@(x,y) a(1) + a(2).*x + a(3).*y + a(4).*x.*y;

[ptx,pty] = meshgrid(-3:.1:3, -3:.1:3);
ptz = a(1) + a(2).*ptx + a(3).*pty; % + a(4).*ptx.*pty;

surf(ptx, pty, ptz);
xlabel('x');
ylabel('y');
hold on

%%
%% Exercise 2 a)
clear all; close all; clc; format shorteng;

% Data
fileID = fopen('ex_8_pointsall.txt','r');
formatSpec = '%f';
sizeA = [3 inf];
Data = fscanf(fileID,formatSpec,sizeA);
A = transpose(Data);
x = A(:,1);
y = A(:,2);
z = A(:,3);
G = [x.^0,   x,   y,   x.^2,   2.*x.*y,   y.^2,   x.^3,   3.*x.^2.*y,   3.*x.*y.^2,   y.^3];

% Singular Value Decomposition
[U,S,V] = svd(G);
% size(U)   % (N+1) x (N+1)
% size(S)   % (N+1) x (m+1)
% size(V)   % (m+1) x (m+1)

% Instead of inverting the normal matrix Gt*G to find the a-values 
% you could use the thin singular value decomposition (only the first 
% 10 cols of U, in Matlab this is called 'econ' = economized, 
% 10 is the number of basis functions) as follows:

[U,S,V] = svd(G,'econ');
d = diag(S);
a = V*( (transpose(U)*z)./d );

% Gt = transpose(G);
% GtG = Gt*G;
% Gtz = Gt*z;
% a = GtG\Gtz;
a = linsolve(G'*G, G'*z)  % ATTENTION! use Z (for 3 dimensions)

[X,Y] = meshgrid(0:5:200,0:5:200);
Z =   a(1)         +   a(2).*X           +   a(3).*Y              +   a(4).*X.^2   +   a(5).*2.*X.*Y   +   a(6).*Y.^2 ...
    + a(7).*X.^3   +   a(8).*3.*X.^2.*Y  +   a(9).*3.*X.*Y.^2     +   a(10).*Y.^3;

% surf(X,Y,Z)
mesh(X,Y,Z)
colormap(bone)
hold on
plot3(x,y,z, '.r')  % .=points / r=red

%% b) 
% ratio of the absolutely maximum singular value and the absolutely minimum 
% singular value of the design matrix
format short
clc;

% wrong:
% GtG = G'*G;
% max(sqrt(GtG), [], 'all')
% min(sqrt(GtG), [], 'all')

% [U,S,V] = svd(G,'econ');
[U,S,V] = svd(G);
% S contains singular values
d = diag(S);
% min(S, [], 'all') = 0 and not 4.5027
maxS = max(d)
minS = min(d)

ratio = maxS/minS
% 6.9602e+07
% condition number is of order 10^14 !!!
% normal equations are ill-positioned and the solution is unstable
% rel error of solution vs. rel error of data is "diverging"

%% Exercise 3)
clc;
% Mean / Standard Deviation
mux = mean(x);
muy = mean(y);
sx  = std(x);
sy  = std(y);

% substitute
xsu = (x-mux)./sx;
ysu = (y-muy)./sy;

Gs = [xsu.^0,   xsu,   ysu,   xsu.^2,   2.*xsu.*ysu,   ysu.^2,   xsu.^3,   3.*xsu.^2.*ysu,   3.*xsu.*ysu.^2,   ysu.^3];
[U,S,V] = svd(Gs,'econ');
d = diag(S)
a = V*( (transpose(U)*z)./d );
maxS = max(d)
minS = min(d)
ratio = maxS/minS
% 10.9163
% the condition number is of order 10^2
% normalized basis guarantees numeric stability of the least squares
% solution

%%

as = linsolve(Gs'*Gs, Gs'*z);  % ATTENTION! use Z (for 3 dimensions)

[X,Y] = meshgrid(0:5:200,0:5:200);
Z =   a(1)         +   a(2).*X           +   a(3).*Y              +   a(4).*X.^2   +   a(5).*2.*X.*Y   +   a(6).*Y.^2 ...
    + a(7).*X.^3   +   a(8).*3.*X.^2.*Y  +   a(9).*3.*X.*Y.^2     +   a(10).*Y.^3;

Zs =   as(1)        +   as(2).*X          +   as(3).*Y             +   as(4).*X.^2  +   as(5).*2.*X.*Y  +   as(6).*Y.^2 ...
    + as(7).*X.^3   +   as(8).*3.*X.^2.*Y +   as(9).*3.*X.*Y.^2    +   as(10).*Y.^3;

surf(X,Y,Z)
% mesh(X,Y,Z)
hold on
% pause
surf(X,Y,Zs)
colormap(bone)
plot3(x,y,z, '.r')  % .=points / r=red





