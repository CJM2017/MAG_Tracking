function h = circle(x,y,r,color)
% Method to plot circles
hold on

th = 0:pi/50:2*pi;

xunit = r * cos(th) + x;

yunit = r * sin(th) + y;

h = plot(xunit, yunit,color);

hold off
end