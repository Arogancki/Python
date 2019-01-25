function [x,val] = michal(x,options)

val = 21.5 + x(1)*sin(4*pi*x(1)) + x(2)*sin(20*pi*x(2));
