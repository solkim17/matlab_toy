function y2 = linear_reg2(x,y,n)

%Linear regression
%Least-squares
%
%y = mx + b
%
%Using provided x and y values, calculate m and b
%Return y2 which is x fit to y=mx + b

%Check sizes
if ~isequal(size(x),size(y))
    error('Size of x and y do not match')
end

x_sum = sum(x);
y_sum = sum(y);
xy_sum = sum(x.*y);
x_sq_sum = sum(x.^2);
n = max(size(x));

m = ((n*xy_sum)-(x_sum*y_sum))/((n*x_sq_sum)-(x_sum*x_sum));
b = ((x_sq_sum*y_sum)-(x_sum*xy_sum))/((n*x_sq_sum)-(x_sum*x_sum));

y2 = m.*x+b;