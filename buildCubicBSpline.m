%=========================三次B-Spline构建=========================
% 输入参数：一段曲线的节点和控制点信息
% 输出参数：一段曲线的函数系数（高次->低次）
%
%=================================================================
%%
function [flag, const, region] = buildCubicBSpline(nodePoint, controlPoint)

    if(length(nodePoint) ~= 7 || length(controlPoint) ~= 4)
        flag = 0;       % 返回：输入参数错误
        return;
    end
    
    % 节点值
    u1 = nodePoint(2);
    u2 = nodePoint(3);
    u3 = nodePoint(4);
    u4 = nodePoint(5);
    u5 = nodePoint(6);
    u6 = nodePoint(7);
    
    % 中间变量1
    K1 = u4 - u1;      
    K2 = u4 - u2;      
    K3 = u4 - u3;    
    K4 = u5 - u2;
    K5 = u5 - u3;
    K6 = u6 - u3;
    
    % 中间变量2
    M1 = 1 / (K1 * K2 * K3);
    M2 = 1 / (K2 * K3 * K4);
    M3 = 1 / (K3 * K4 * K5);
    M4 = 1 / (K3 * K5 * K6);
    
    % 控制点
    d0 = controlPoint(1);
    d1 = controlPoint(2);
    d2 = controlPoint(3);
    d3 = controlPoint(4);
    
    % 系数矩阵
    coef = zeros(4, 4);
    % 系数a 
    coef(1,1) = -M1 * d0;
    coef(1,2) = (M1 + M2 + M3) * d1;
    coef(1,3) = -(M2 + M3 + M4) * d2;
    coef(1,4) = M4 * d3;
    
    % 系数b 
    coef(2,1) = 3 * u4 * M1 * d0;
    coef(2,2) = -((2 * u4 + u1) * M1 + (u2 + u4 + u5) * M2 + (u3 + 2 * u5) * M3) * d1;
    coef(2,3) = ((2 * u2 + u4) * M2 + (u2 + u3 + u5) * M3 + (2 * u3 + u6) * M4) * d2;
    coef(2,4) = -3 * u3 * M4 * d3;
    
    % 系数c 
    coef(3,1) = -3 * u4^2 * M1 * d0;
    coef(3,2) = ((u4^2 + 2 * u1 * u4) * M1 + (u2 * u4 + u2 * u5 + u4 * u5) * M2 + (u5^2 + 2 * u3 * u5) * M3) * d1;
    coef(3,3) = -((u2^2 + 2 * u2 * u4) * M2 + (u2 * u3 + u2 * u5 + u3 * u5) * M3 + (u3^2 + 2 * u3 * u6) * M4) * d2;
    coef(3,4) = 3 * u3^2 * M4 * d3;
    
    % 系数d 
    coef(4,1) = u4^3 * M1 * d0;
    coef(4,2) = -(u1 * u4^2 * M1 + u2 * u4 * u5 * M2 + u3 * u5^2 * M3) * d1;
    coef(4,3) = (u2^2 * u4 * M2 + u2 * u3 * u5 * M3 + u3^2 * u6 * M4) * d2;
    coef(4,4) = -u3^3 * M4 * d3;
    
    const = coef * ones(4, 1);
    
    region = [u3, u4];
    
    flag = 1;       % 返回：计算完成
    
    
    