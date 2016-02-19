clear all;
close all;
clc;

% Example
x = sym('x',[3,1]);
p = sym('p',[7,1]);

dx = [x(1)/(x(1)+x(2)+p(1)) +     p(2)*x(3)*x(1);
      x(2)/(x(1)+x(2)+p(1)) + 1/2*p(2)*x(3)*x(2);
      1/2*x(3)/(x(3)+p(3))^2 - p(2)*x(3)*(x(1)+1/2*x(2)) + p(4)];
  
x0 = [p(5);p(6);p(7)];

%% Convert the rational system to a polynomial system
% % with input from the user
% inv_xi = [x(1)+x(2)+p(1);x(3)+p(3)];
% [z,dz,z0] = convert2PolySys(x,dx,x0,inv_xi);

% without input from the user
[z,dz,z0] = convert2PolySys(x,dx,x0);

%% Test
% This implementation of the simulation is extremely inefficient and
% only ment for testing purposes.
p_sim = [1,2,3,4,5,6,7]';
[TX,X] = ode15s(@(t,x_sim) double(subs(dx,[x;p],[x_sim;p_sim])),[0,0.25],double(subs(x0,p,p_sim)));
[TZ,Z] = ode15s(@(t,z_sim) double(subs(dz,[z;p],[z_sim;p_sim])),[0,0.25],double(subs(z0,p,p_sim)));

figure;
plot(TX,X(:,1),'r-'); hold on;
plot(TZ,Z(:,1),'ro');
plot(TX,X(:,2),'b-'); hold on;
plot(TZ,Z(:,2),'bo');
plot(TX,X(:,3),'k-'); hold on;
plot(TZ,Z(:,3),'ko');
