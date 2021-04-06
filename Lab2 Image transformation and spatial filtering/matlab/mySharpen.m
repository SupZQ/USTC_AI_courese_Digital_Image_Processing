function [img_2] = mySharpen(img_1) 

size_1 = size(img_1);
h = size_1(1);
w = size_1(2);
img_2 = zeros(h, w);

%%��Ե������������
a = img_1(1,:);
b = img_1(h,:);
img_1 = [a;img_1;b];
c = img_1(:,1);
d = img_1(:,w);
img_1 = double([c,img_1,d]);

%������˹����
L = [-1 -1 -1;-1 8 -1;-1 -1 -1];

for i= 1:h
    for j = 1:w
        %im = [img_1(i,j) img_1(i,j+1) img_1(i,j+2);...
        %   img_1(i+1,j) img_1(i+1,j+1) img_1(i+1,j+2);...
        %   img_1(i+2,j) img_1(i+2,j+1) img_1(i+2,j+2)];
        im = img_1(i:i+2,j:j+2);
        img_2(i,j) = round(sum(sum(L.*im)));
        img_2(i,j) = img_2(i,j) + img_1(i+1,j+1);
    end
end

img_2 = im2uint8(img_2/255);
end


