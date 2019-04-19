function bubbleSort_main
tic;
size=10;
array=[1,3,2,10,6,4,7,5,8,9];
disp('Ñ¡ÔñÅÅĞò£º');
disp(array);
%% Ñ¡ÔñÅÅĞò
for i=1:size-1
    indexMin=i;
    for j=(i+1):size
        if array(indexMin)>array(j)
            indexMin=j;
        end
    end
        if indexMin~=i
            temp=array(indexMin);
            array(indexMin)=array(i);
            array(i)=temp;
        end
            
    
end
%%  Ã°ÅİÅÅĞò
% for i=1:size
%     for j=1:size-1
%         if array(j)>array(j+1)
%             temp=array(j);
%             array(j)=array(j+1);
%             array(j+1)=temp;
%         end
%         
%     end
% end
%% ÏÔÊ¾½á¹û
disp(array);
toc;

end