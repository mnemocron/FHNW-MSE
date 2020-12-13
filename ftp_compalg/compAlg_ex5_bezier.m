%******************************************************************************
% \details     : FTP_CompAlg Cubic Bezier Exercises 5
% \autor       : Simon Burkhardt
% \file        : compAlg_ex5_bezier.m
% \date        : 2020.10.17
% \version     : 1.0
%******************************************************************************
%% Exercise 3 a)
% https://www.rapidtables.com/web/tools/svg-viewer-editor.html

% M 183.171,159.905
% c -19.081,16.712-71.022,29.131-71.022,80.636
% c 0,22.975,11.665,34.132,27.556,34.132
% c 15.372,0,43.467-21.71,43.467-38.475

Px = 183.171;
Py = 159.905;
x1 = [ Px, Px-19.081, Px-71.022, Px-71.022 ];
y1 = [ Py, Py+16.712, Py+29.131, Py+80.636 ];
Px = x1(end);
Py = y1(end);
x2 = [ Px, Px+00.000, Px+11.665, Px+27.556 ];
y2 = [ Py, Py+22.975, Py+34.132, Py+34.132 ];
Px = x2(end);
Py = y2(end);
x3 = [ Px, Px+15.372, Px+43.467, Px+43.467 ];
y3 = [ Py, Py+00.000, Py-21.71, Py-38.475 ];
x = [x1, x2, x3];
y = [y1, y2, y3];

% plot(x, y, '-o');

% 1. Spline
P00 = [x1(1);y1(1)];
P01 = [x1(2);y1(2)];
P02 = [x1(3);y1(3)];
P03 = [x1(4);y1(4)];
P10 = [x2(1);y2(1)];
P11 = [x2(2);y2(2)];
P12 = [x2(3);y2(3)];
P13 = [x2(4);y2(4)];
P20 = [x3(1);y3(1)];
P21 = [x3(2);y3(2)];
P22 = [x3(3);y3(3)];
P23 = [x3(4);y3(4)];

r0 = @(t) nchoosek(3,0)*P00.*(1-t).^3 + ...
    nchoosek(3,1)*P01.*t.*(1-t).^2 + ...
    nchoosek(3,2)*P02.*(t.^2).*(1-t).^1 + ...
    nchoosek(3,3)*P03.*t.^3;
r1 = @(t) nchoosek(3,0)*P10.*(1-t).^3 + ...
    nchoosek(3,1)*P11.*t.*(1-t).^2 + ...
    nchoosek(3,2)*P12.*(t.^2).*(1-t).^1 + ...
    nchoosek(3,3)*P13.*t.^3;
r2 = @(t) nchoosek(3,0)*P20.*(1-t).^3 + ...
    nchoosek(3,1)*P21.*t.*(1-t).^2 + ...
    nchoosek(3,2)*P22.*(t.^2).*(1-t).^1 + ...
    nchoosek(3,3)*P23.*t.^3;

t = linspace(0, 1, 1e3);
p0 = r0(t);
p1 = r1(t);
p2 = r2(t);
xs = [p0(1,1:end), p1(1,1:end), p2(1,1:end)];
ys = [p0(2,1:end), p1(2,1:end), p2(2,1:end)];
plot(xs,ys)
hold on;
plot(x, y, 'o');

%%
% b) derrivatives

% 1st common point between P03 and P10
% must be equal:
r1s_1 = 3*( P03 - P02 )
r2s_0 = 3*( P11 - P10 )

% 2nd common point between P13 and P20
r2s_1 = 3*( P13 - P12 )
r3s_0 = 3*( P21 - P20 )
















