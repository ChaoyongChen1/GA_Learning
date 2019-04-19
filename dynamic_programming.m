function dynamic_programming
tic;
clear ;
%动态规划求解0/1背包问题
ItemCount=4;
TotalWeight=10;
% global Values
% global Weights
Values=[111,222,332,444];
Weights=[1,3,5,6];

max_value=GetMaxRecursive(TotalWeight,ItemCount);
disp('总最大价值为：');
disp(max_value);
toc;

function retMaxGold=GetMaxRecursive(lastWeight,index)
    %global Weights
    %global Values
    if index==1
        if lastWeight>=Weights(index)
            retMaxGold=Values(index);
        else
            retMaxGold=0;
        end
    elseif lastWeight>=Weights(index)
        doPut=GetMaxRecursive(lastWeight-Weights(index),index-1)+Values(index);
        doNotPut=GetMaxRecursive(lastWeight,index-1);
        retMaxGold=max(doPut,doNotPut);
    else
        retMaxGold=GetMaxRecursive(lastWeight,index-1);
    end
    
end

end

       