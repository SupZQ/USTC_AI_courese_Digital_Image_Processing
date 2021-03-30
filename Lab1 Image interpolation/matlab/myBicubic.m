function [img_2] = bicubic(img_1, n)

size_1 = size(img_1);
h_1 = size_1(1);
w_1 = size_1(2);
h_2 = floor(h_1 * n);
w_2 = floor(w_1 * n);
img_2 = zeros(h_2, w_2);

%%涓嬮潰鍐欑珛鏂规彃鍊煎疄鐜颁唬鐮?
if length(size_1(:)) == 3
    img_1 = rgb2gray(img_1);
end
img_1 = im2double(img_1);

for dstx = 1:h_2
    x = floor(dstx/n); u = dstx/n - x;
    %逼近函数，A = s[]
    A = [sw(u+1), sw(u), sw(u-1), sw(u-2)];
    for dsty = 1:w_2
        y = floor(dsty/n); v = dsty/n - y;
        %逼近函数，C = s[]
        C = [sw(v+1); sw(v); sw(v-1); sw(v-2)];
        %考虑到边界像素，分类讨论得到插值计算区域矩阵 B[]
        xi = max(1,x-1); xx = max(1,x); xa = min(h_1,x+1); xaa = min(h_1,x+2);
        yi = max(1,y-1); yy = max(1,y); ya = min(w_1,y+1); yaa = min(w_1,y+2);
        if xi~=x-1||yi~=y-1||xaa~=x+2||yaa~=y+2
            B = [img_1(xi,yi),img_1(xi,yy),img_1(xi,ya),img_1(xi,yaa);
                 img_1(xx,yi),img_1(xx,yy),img_1(xx,ya),img_1(xx,yaa);
                 img_1(xa,yi),img_1(xa,yy),img_1(xa,ya),img_1(xa,yaa);
                 img_1(xaa,yi),img_1(xaa,yy),img_1(xaa,ya),img_1(xaa,yaa)];
        else
             B = img_1(xi:xaa,yi:yaa);
        end

        %插值主运算 A*B*C
        img_2(dstx,dsty) = (A*B)*C;
    end
end

function A=sw(x)
w=abs(x);
if w<1 && w>=0
    A = 1-2*w^2+w^3;
else
    if w>=1 && w<2
        A = 4-8*w+5*w^2-w^3;
    else
        A=0;
    end
end
end
img_2 = im2uint8(img_2);
end
