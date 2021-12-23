
function [state,result]=draw_rect(data,pointAll,windSize,lineSize,showOrNot)

% 函数调用：[state,result]=draw_rect(data,pointAll,windSize,showOrNot)

% 函数功能：在图像画个长方形框

% 函数输入：data为原始的大图，可为灰度图，可为彩色图

%          pointAll 框的左上角在大图中的坐标(每行代表一个坐标)，

%                   注意：在图中的坐标系为第一列为y,第二列为x(很奇怪的)

%          windSize 框的大小 windSize=[112,92] 分别表示长宽

%          showOrNot 是否要显示,默认为显示出来

% 函数输出：state -- 表示程序结果状态

%          result - 结果图像数据 

% 函数历史： v0.0 @2013-01-27 created by Aborn

 

if nargin < 5

    showOrNot = 1;

end

if nargin < 4

    lineSize = 2;                                      % 边框大小，取1，2，3

end
 

rgb = [255 0 0];                                 % 边框颜色


 

windSize(1,1)=windSize(1,1);

windSize(1,2) = windSize(1,2);

if windSize(1,1) > size(data,1) || windSize(1,2) > size(data,2)

    state = -1;                                     % 说明窗口太大，图像太小，没必要获取

    disp('the window size is larger then image...');

    return;

end

 

result = data;

if size(data,3) == 3

    for k=1:3

        for i=1:size(pointAll,1)   %画边框顺序为：上右下左的原则

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
    
    for i=1:size(pointAll,1)   %画边框顺序为：上右下左的原则

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
