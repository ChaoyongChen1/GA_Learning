function BasicGA
tic
%% 初始参数确定
DNA_SIZE=10;
POP_SIZE=100;
CROSS_RATE=0.8;
MUTATION_RATE=0.003;
N_GENERATIONS=300;
X_BOUND=[0,5];

%% 主循环
%产生离散均匀分布的pop矩阵
pop=rand(POP_SIZE,DNA_SIZE)<0.5;
x=X_BOUND(1):(X_BOUND(2)-X_BOUND(1))/200:X_BOUND(2);

for i=1:N_GENERATIONS
    F_values=F(translateDNA(pop));
    %画图
    clf;
    plot(x,F(x));
    hold on;
    scatter(translateDNA(pop), F_values, 'red', 'filled'); 
    title(sprintf('第 %d 次迭代结果示意图', i));
    pause(0.05);
    
    fitness=get_fitness(F_values);
    pop_select=select(pop,fitness);
    pop_copy=pop_select;
    for num=1:POP_SIZE
        parent=pop_select(num,:);
        child=crossover(parent,pop_copy);
        child=mutate(child);
        popNew(num,:)=child;
    end
    pop=popNew;
end

%% F() 返回函数值
    function y=F(x)
       y=sin(10*x).*x+cos(2*x).*x;
    end
%% get_fitness() 返回一个非负的适应度值
    function y=get_fitness(F_values)
        y=F_values+1e-3-min(F_values);
    end
%% translateDNS() 编码DNA,将二进制编码为十进制数
    function trans=translateDNA(pop)
        trans1=(pop*pow2(DNA_SIZE-1:-1:0).')';
        trans=trans1/(2^DNA_SIZE-1)*X_BOUND(2);
    end
%% select() 轮盘赌法选择适应度高的DNA序列，生成新的种群
    function pop_new=select(pop,fitness)
        p=fitness/sum(fitness);
        p_add=p(1);
        for j=2:POP_SIZE
            p_add(j)=p_add(j-1)+p(j);
        end
        for j=1:POP_SIZE
            select=find(p_add>rand);
            pop_new(j,:)=pop(select(1),:);
        end  
     end
%% crossover() 交叉父母基因
    function parent=crossover(parent,pop)
        if rand<CROSS_RATE
            i_NUM=unidrnd(POP_SIZE);
            cross_point=unidrnd(DNA_SIZE);
            for j_NUM=cross_point:DNA_SIZE
                parent(j_NUM)=pop(i_NUM,j_NUM);
            end
        end
    end
 
%% mutation() 变异基因
    function child=mutate(child)
        for point=1:DNA_SIZE
            if rand<MUTATION_RATE
                if child(point)==0
                    child(point)=1;
                else
                    child(point)=0;
                end
            end
        end
    end


toc
end
