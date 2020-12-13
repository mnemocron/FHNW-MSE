%******************************************************************************
% \details     : FTP_CompAlg Exercises 13 Step Size Adaption
% \autor       : Simon Burkhardt
% \file        : compAlg_ex13_adaptive_steps.m
% \date        : 2020.12.09
%******************************************************************************
%% Exercise 1 a)
clear all; close all; clc;

% initial value problem
f =@(x,y) (1-1/4*cos(y))^2;
x=0; y=0;

s1=1; s2=1;
h=0.001;    % initial step size
ag=4; pg=4; % tolerance

nn=10; % max iterations
n=1; % counter
b = x+1000*h; % max x range

fprintf("x \t\t\t\t y \t\t\t\t h \t\t\t\t ek \t\t\t val \t\t\t hnew \t\t\t status \t k1 \t\t\t k2 \n")

while( (x <= b+h) && (n < nn) )
    % 
    k1 = f(x,y);
    k2 = f(x+h, y+h*k1);
    ek = 1/2 * h * (k2-k1);
%     err = h * ((1/2 - 1) * k1 + (1/2 - 0) * k2);
    eps = 10^-ag + 10^-pg * abs(y);  % Tolerance - calculate on each step
%     hneu = h * s1 * (abs((err/(s2 * (10^-ag + 10^-pg * abs(y))))))^(-1/p)
    hneu = h*s1*( abs( ek/(s2*eps) ) ) ^(-1/2); % new step size
    
    if( abs(ek/eps) >= 1 )
        status = "Reject";
        fprintf("%d \t %d \t %d \t %d \t %d \t %d \t %s \t %d \t %d \n", x, y, h, ek, abs(ek/eps), hneu, status, k1, k2)
    else
        status = "Proceed";
        fprintf("%d \t %d \t %d \t %d \t %d \t %d \t %s \t %d \t %d \n", x, y, h, ek, abs(ek/eps), hneu, status, k1, k2)
        x = x+h;
        y = y+h*1/2*k1 + h*1/2*k2;
    end
    
    h = hneu;
    n = n+1;
end





