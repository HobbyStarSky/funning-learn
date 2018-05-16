
% x = [0.5 1 2];
% y = [0 1 0];

% u = 2:0.1:3;
% 
% N1 = (3 - u).^2/2;
% N2 = (3 - u).*(u - 1)/2 + (u - 2).*(4 - u)/2;
% N3 = (u - 2).^2/2;
% 
% sx = x(1) * N1 + x(2) * N2 + x(3) * N3;
% sy = y(1) * N1 + y(2) * N2 + y(3) * N3;
% 
% plot(sx, sy, x, y)

% u = 0:0.1:1;
% 
% N1 = (1 - u).^2;
% N2 = 2 * u.*(1 - u);
% N3 = u.^2;
% 
% sx = x(1) * N1 + x(2) * N2 + x(3) * N3;
% sy = y(1) * N1 + y(2) * N2 + y(3) * N3;
% 
% plot(sx, sy, x, y)

x = [0 1 2 3 4 5 6];
y = [0 1 0 1 0 1 0];
u = [0 0 0 0 0.25 0.5 0.75 1 1 1 1];
k = 3;      % B-Spline 次数
m = length(x) - k;      % B-Spline 段数
step = 0.01;

for i = 1:m
    nodePoint = u(i : i + 2 * k);       % 提取节点
    controlPointx = x(i : i + k);       % 提取控制点x
    controlPointy = y(i : i + k);       % 提取控制点y
    
    [flag, constx, regionx] = buildCubicBSpline(nodePoint, controlPointx);
    if(flag > 0)
        [flag, consty, ~] = buildCubicBSpline(nodePoint, controlPointy);
    end

    if(flag > 0)
        t = regionx(1):step:regionx(2);
        sx = constx(1) * t.^3 + constx(2) * t.^2 + constx(3) * t + constx(4);
        sy = consty(1) * t.^3 + consty(2) * t.^2 + consty(3) * t + consty(4);
    end

    plot(sx, sy, x, y)
    hold on
end




















