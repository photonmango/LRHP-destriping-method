
function [state,result]=draw_rect(data,pointAll,windSize,lineSize,showOrNot)

% �������ã�[state,result]=draw_rect(data,pointAll,windSize,showOrNot)

% �������ܣ���ͼ�񻭸������ο�

% �������룺dataΪԭʼ�Ĵ�ͼ����Ϊ�Ҷ�ͼ����Ϊ��ɫͼ

%          pointAll ������Ͻ��ڴ�ͼ�е�����(ÿ�д���һ������)��

%                   ע�⣺��ͼ�е�����ϵΪ��һ��Ϊy,�ڶ���Ϊx(����ֵ�)

%          windSize ��Ĵ�С windSize=[112,92] �ֱ��ʾ����

%          showOrNot �Ƿ�Ҫ��ʾ,Ĭ��Ϊ��ʾ����

% ���������state -- ��ʾ������״̬

%          result - ���ͼ������ 

% ������ʷ�� v0.0 @2013-01-27 created by Aborn

 

if nargin < 5

    showOrNot = 1;

end

if nargin < 4

    lineSize = 2;                                      % �߿��С��ȡ1��2��3

end
 

rgb = [255 0 0];                                 % �߿���ɫ


 

windSize(1,1)=windSize(1,1);

windSize(1,2) = windSize(1,2);

if windSize(1,1) > size(data,1) || windSize(1,2) > size(data,2)

    state = -1;                                     % ˵������̫��ͼ��̫С��û��Ҫ��ȡ

    disp('the window size is larger then image...');

    return;

end

 

result = data;

if size(data,3) == 3

    for k=1:3

        for i=1:size(pointAll,1)   %���߿�˳��Ϊ�����������ԭ��

            result(pointAll(i,1),pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);   

            result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)+windSize(i,1),k) = rgb(1,k);

            result(pointAll(i,1)+windSize(i,2),pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);  

            result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2),k) = rgb(1,k);  

            if lineSize == 2 || lineSize == 3

                result(pointAll(i,1)+1,pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);  

                result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)+windSize(i,1)-1,k) = rgb(1,k);

                result(pointAll(i,1)+windSize(i,2)-1,pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);

                result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)-1,k) = rgb(1,k);

                if lineSize == 3

                    result(pointAll(i,1)-1,pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);   

                    result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)+windSize(i,1)+1,k) = rgb(1,k);

                    result(pointAll(i,1)+windSize(i,2)+1,pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);

                    result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)+1,k) = rgb(1,k);

                end

            end

        end

    end

elseif size(data,3) == 1
    k = 1;
    
    for i=1:size(pointAll,1)   %���߿�˳��Ϊ�����������ԭ��

        result(pointAll(i,1),pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);   

        result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)+windSize(i,1),k) = rgb(1,k);

        result(pointAll(i,1)+windSize(i,2),pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);  

        result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2),k) = rgb(1,k);  

        if lineSize == 2 || lineSize == 3

            result(pointAll(i,1)+1,pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);  

            result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)+windSize(i,1)-1,k) = rgb(1,k);

            result(pointAll(i,1)+windSize(i,2)-1,pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);

            result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)-1,k) = rgb(1,k);

            if lineSize == 3

                result(pointAll(i,1)-1,pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);   

                result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)+windSize(i,1)+1,k) = rgb(1,k);

                result(pointAll(i,1)+windSize(i,2)+1,pointAll(i,2):pointAll(i,2)+windSize(i,1),k) = rgb(1,k);

                result(pointAll(i,1):pointAll(i,1)+windSize(i,2),pointAll(i,2)+1,k) = rgb(1,k);

            end

        end

    end
    
end

 
state = 1;

 
if showOrNot == 1

    figure;

    imshow(result);

end
