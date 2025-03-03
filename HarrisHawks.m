function [best_solutuion,best_fitness]=HarrisHawks(fobj,navrs,T,lb,ub,N)
%% 变量说明
% best_solution:最优解
% best_fitness:最优适应度
% x:优化变量数量
% T:最大迭代次数
% lb:变量下界
% ub:变量上界
% fobj:优化目标函数,行向量输入
% N:种群数量
%% 主体部分

%生成种群
%xt:初始种群
xt=-lb+(ub-lb).*rand(navrs,N);

%全局最优解的位置
best_solutuion=zeros(navrs,1);
%全局最优解
best_fitness=inf;
for t=1:T
    %计算每个老鹰的适应读
    fitness_now=ReturnFitness(fobj,xt,N);
    %确定最优解
    [fitness_now_best,solution_now_location]=min(fitness_now);
    if fitness_now_best<best_fitness
        best_fitness=fitness_now_best;
        best_solutuion=xt(:,solution_now_location);
    end
        x_robbit=best_solutuion;
    %更新每个解的位置
    for j=1:N
        %确定初始能力E0,和跳跃强度J
        E0=2*rand(1)-1;
        E=2*E0*(1-t/T);
        J=2*(1-rand(1));
        %确定一个随机概率
        r=rand;
        %开始优化
        if abs(E)>=1
            q=rand;
            if q>=0.5
                x_rand=xt(:,randi([1,N],1,1));
                r1=rand;
                r2=rand;
                xt_next=x_rand-r1*abs(x_rand-2*r2*xt(:,j));
            else
                r3=rand;
                r4=rand;
                xmt=mean(xt,2);
                xt_next=x_robbit-xmt-r3*(lb+r4*(ub-lb));
            end
        else
            if r>=0.5 && abs(E)>=0.5
                x_delta=x_robbit-xt(:,j);
                xt_next=x_delta-E*abs(J*x_robbit-xt(:,j));
            elseif r>=0.5 && abs(E)<0.5
                x_delta=x_robbit-xt(:,j);
                xt_next=x_robbit-E*abs(x_delta);
            elseif r<0.5 && abs(E)>=0.5
                Y=x_robbit-E*abs(J*x_robbit-xt(:,j));
                S=rand(navrs,1);
                Z=Y+S*LF;
                if fobj(Y')>fobj(Z')
                    xt_next=Y;
                else
                    xt_next=Z;
                end
            elseif r<0.5 && abs(E)<0.5
                xmt=mean(xt,2);
                Y=x_robbit-E*abs(J*x_robbit-xmt);
                S=rand(navrs,1);
                Z=Y+S*LF;
                if fobj(Y')>fobj(Z')
                    xt_next=Y;
                else
                    xt_next=Z;
                end
            end
        end
        xt(:,j)=xt_next;
    end
end
end