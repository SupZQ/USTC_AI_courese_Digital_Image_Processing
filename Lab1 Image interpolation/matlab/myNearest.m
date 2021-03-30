function [img_2] = nearest(img_1, n)

size_1 = size(img_1);
h_1 = size_1(1);
w_1 = size_1(2);
h_2 = floor(h_1 * n);
w_2 = floor(w_1 * n);
img_2 = zeros(h_2, w_2);


%%下面写最近邻插�?�实现代�?
if length(size_1(:)) == 3
    img_1 = rgb2gray(img_1);
end
img_1 = im2double(img_1);
for i=1:h_2
    for j=1:w_2
        m=round(i/n);
        k=round(j/n);
        if m<1
            m=1;
        end
        if k<1
            k=1;
        end
        if m>h_1
            m=h_1;
        end
        if k>w_1
            k=w_1;
        end
        img_2(i,j)=img_1(m,k);
    end
end
img_2 = im2uint8(img_2);
end



