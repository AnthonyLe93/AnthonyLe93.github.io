clear; % clear the workspace to prevent replicate variable names
clc; % clear the terminal
syms t X Y

xPoint1 = []; %Points for x~y + x~yTangent 
xPoint2 = [];

yPoint1 = []; %Points for x~y - x~yTangent
yPoint2 = [];

eX = 1; %Ellipsoid parameters
eY = 1;

n = 6; %Number of sinusoids around the circle
a = 3.5; %Amplitude of sinusoids

angles = linspace(0, 2*pi, 1000);  
radius = 6;                       %Set up circle parameters, can vary sampling res in linspace

x = eX*(radius + a * sin(n.*t)) .* cos(t); %Equations for circle, paramaterised to allow sinusoidal wave around circumference
y = eY*(radius + a * sin(n.*t)) .* sin(t);

xDiffd = diff(x, t); %Differentiate the original curves
yDiffd = diff(y, t);

xyDiffd = yDiffd / xDiffd; %Translate to dx/dy

x_in = size(angles); %pre-allocate variable to save x2-coor
y_in = size(angles); %pre-allocate variable to save y2-coor

for t = [0:(2*pi)/1000:2*pi] %Same as linspace(0, 2*pi, 1000)
    
   m = vpa(subs(xyDiffd)); %Calculate gradient of the tangent line
   xTangent = vpa(subs(x)); %The x co-ordinate of the tangent
   yTangent = vpa(subs(y)); %The y co-ordinate of the tangent
   
   if m == 0 %If m == 0 then perpendicular gradient involves division by zero
       grad = 0;
       xPoint1 = [xPoint1 xTangent];
       yPoint1 = [yPoint1 yTangent + 0.5]; %Simply add or subtract from y
       xPoint2 = [xPoint2 xTangent];
       yPoint2 = [yPoint2 yTangent - 0.5];
       
   else
       grad = -1/m; %For all other cases, perpendicular gradient is -1/m
       
       theta = atan(grad); %Angle of line from x axis
   
       if theta > 90
            theta = 180 - theta; %If angle is greater than 90 then the angle cannot be used for trig
       end
   
       xPoint1 = [xPoint1 xTangent + 1*cos(theta)];
       yPoint1 = [yPoint1 yTangent + 1*sin(theta)]; %Gives x and y points for 0.5 units away from tangent point along perpendicular
   
       xPoint2 = [xPoint2 xTangent - 1*cos(theta)];
       yPoint2 = [yPoint2 yTangent - 1*sin(theta)];
   end
   
   %perpendicularLine = (grad)*(X - xTangent) + yTangent;
end

xNum = eX*(radius + a * sin(n.*angles)) .* cos(angles); %Original equation without syms 
yNum = eY*(radius + a * sin(n.*angles)) .* sin(angles);
data = [xNum',yNum']; % formatting data to save (outter curve coordinates)
x2_1 = double(xPoint1)';
x2_2 = double(xPoint2)';
y2_1 = double(yPoint1)';
y2_2 = double(yPoint2)';
%% Selecting inner solutions via cross product
for i = 1 : 1000-1
A = data(i,:); 
B = data(i+1,:);
BA = A-B;
Bb1=[x2_1(i)-B(1) y2_1(i)-B(2)];
Bb2=[x2_2(i)-B(1) y2_2(i)-B(2)];
c1=BA(1)*Bb1(2)-BA(2)*Bb1(1);
c2=BA(1)*Bb2(2)-BA(2)*Bb2(1);
if c1<0
    x_in(i) = x2_1(i);
    y_in(i) = y2_1(i);
elseif c2<0
    x_in(i) = x2_2(i);
    y_in(i) = y2_2(i);
end
end

x_in(1000)=x_in(1); %tidy up and closing the inner curve
y_in(1000)=y_in(1); %tidy up and closing the inner curve

data2 = [x_in',y_in']; % formatting data to save (inner curve coordinates)
%% Plotting
hold on
axis equal
plot(xNum, yNum);
% plot(vpa(subs(perpendicularLine)))
% plot(xTangent, yTangent, 'k+', 'LineWidth', 1, 'MarkerSize', 10);
% plot(xPoint1, yPoint1, 'k+', 'LineWidth', 1, 'MarkerSize', 1); %Plot points
% plot(xPoint2, yPoint2, 'k+', 'LineWidth', 1, 'MarkerSize', 1);
%plot(x2_1, y2_1);
%plot(x2_2, y2_2);
plot(x_in,y_in); % plot the inner solutions only
%%
writematrix(data,'n6_a3.5_xy.txt','Delimiter','tab'); %type 'data_xy.txt'
writematrix(data2,'n6_a3.5_xy2.txt','Delimiter','tab'); %type 'data_xy2.txt'



