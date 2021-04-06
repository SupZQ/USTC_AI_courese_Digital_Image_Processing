function [img_2] = myMedian(img_1)

size_1 = size(img_1);
h = size_1(1);
w = size_1(2); 
img_2 = zeros(h, w);

%%边缘延拓两行两列
a = img_1(1,:);
b = img_1(h,:);
img_1 = [a;img_1;b];
c = img_1(:,1);
d = img_1(:,w);
img_1 = [c,img_1,d];

for i= 1:h
    for j = 1:w
        %获得模板区的值
        %对模板区的值进行排序
        %选取中值
        img = img_1(i:i+2, j:j+2);
        img_2(i,j) = median(img(:));
    end
end
img_2 = uint8(img_2);
end


