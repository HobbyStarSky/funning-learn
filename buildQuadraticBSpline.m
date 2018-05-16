%=========================二次B-Spline构建=========================
% 输入参数：一段曲线的节点和控制点信息
% 输出参数：一段曲线的函数系数（高次->低次）
%
%
%=================================================================
%%

function [flag, const, region] = buildQuadraticBSpline(nodePoint, controlPoint)

    if(length(nodePoint) ~= 5 || length(controlPoint) ~= 3)
        flag = 0;       % 返回：输入参数错误
        return;
    end
        
    const = zeros(1,3);     % 初始化多项式系数矩阵

    u1 = nodePoint(2);
    u2 = nodePoint(3);
    u3 = nodePoint(4);
    u4 = nodePoint(5);
    
    K1 = u3 - u1;       % K1 = u3 - u1
    K2 = u3 - u2;       % K1 = u3 - u2
    K3 = u4 - u2;       % K1 = u4 - u2
    
%     e = 1e-10;
%     if(abs(K1) < e)
%         K1 = 1;
%     end
%     if(abs(K2) < e)
%         K2 = 1;
%     end
%     if(abs(K3) < e)
%         K3 = 1;
%     end
    
    d0 = controlPoint(1);
    d1 = controlPoint(2);
    d2 = controlPoint(3);
    
    const(1) = ((d0 - d1) / K1 + (d2 - d1) / K3) / K2;
    const(2) = ((d1 * (u1 + u3) - 2 * d0 * u3) / K1 + (d1 * (u2 + u4) - 2 * d2 * u2) / K3) / K2;
    const(3) = ((d0 * u3^2 - d1 * u1 * u3) / K1 + (d2 * u2^2 - d1 * u2 *u4) / K3) / K2;
    
    region = [u2, u3];
    
    flag = 1;       % 返回：计算完成
    
    

    