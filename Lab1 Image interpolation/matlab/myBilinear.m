function [img_2] = bilinear(img_1, n)

size_1 = size(img_1);
h_1 = size_1(1);
w_1 = size_1(2);
h_2 = floor(h_1 * n);
w_2 = floor(w_1 * n);
img_2 = zeros(h_2, w_2);


%%涓嬮潰鍐欏弻绾挎?ф彃鍊煎疄鐜颁唬鐮?
if length(size_1(:)) == 3
    img_1 = rgb2gray(img_1);
end
img_1 = im2double(img_1);
for p=1:h_2
    for q=1:w_2
        x = p / n; y = q / n;
        i = floor(x); j = floor(y);%该值不会超过原图上边界
        row = max(i,1); column = max(j,1);
        if i==0 || j==0  || i==h_1 || j==w_1
            img_2(p,q) = img_1(row, column);
        else
            u = x - i;
            v = y - j;
            img_2(p,q)=img_1(i,j)*(1-u)*(1-v) + ...
                       img_1(i,j+1)*(1-u)*v + ...
                       img_1(i+1,j)*u*(1-v) +  ...
                       img_1(i+1,j+1)*u*v;
        end
        
    end
end
img_2 = im2uint8(img_2);
end

