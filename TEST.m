function TEST
X_BOUND=[0,5];
DNA_SIZE=10;
POP_SIZE=100;
CROSS_RATE=0.8;
MUTATION_RATE=0.003;

x=X_BOUND(1):(X_BOUND(2)-X_BOUND(1))/200:X_BOUND(2);
pop=rand(POP_SIZE,DNA_SIZE)<0.5;
% plot(x,F(x));
F_values=F(translateDNA(pop));
%disp(F_values);
fitness=get_fitness(F_values);
% disp('最大适应度值：');
% disp(max(fitness));
% index=find(fitness==max(fitness));
% disp('相应的DNA序列为：')
% disp(pop(index,:));
pop_select=select(pop,fitness);
pop_copy=pop_select;
% disp(pop_select);
parent=pop_select(1,:);
child=crossover(parent,pop_copy);
% disp(child);
child=mutate(child);
disp(child);
    
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
    function parent=crossover(parent,pop)
        if rand<CROSS_RATE
            i_NUM=round(rand*POP_SIZE);
            cross_point=round(rand*DNA_SIZE);
            for j_NUM=cross_point:DNA_SIZE
                parent(j_NUM)=pop(i_NUM,j_NUM);
            end
        end
    end
    
    function y=F(x)
        y=sin(10*x).*x+cos(2*x).*x;
    end

    function trans=translateDNA(pop)
        trans1=(pop*pow2(DNA_SIZE-1:-1:0).')';
        trans=trans1/(2^DNA_SIZE-1)*X_BOUND(2);
    end

    function y=get_fitness(F_values)
        y=F_values+1e-3-min(F_values);
    end

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

end