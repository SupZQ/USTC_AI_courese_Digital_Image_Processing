function [img_2] = myHisteq(img_1, n) 
% n表示输出图像的灰度级数量

size_1 = size(img_1);
h = size_1(1);
w = size_1(2);
img_2 = zeros(h, w);

L = 256;    %0-255��L���Ҷ�ֵ
PDF = zeros(L,1);  %NK��ͼ���ֱ��ͼ�ֲ�
for i = 1:h
    for j = 1:w
        num = img_1(i,j) + 1;
        PDF(num) = PDF(num) + 1;
    end
end
CDF = zeros(L,1); %CH��ͼ���ֱ��ͼ���ۼƷֲ�
for i = 1:L
    for j = 1:i
        CDF(i) = CDF(i) + PDF(j);
    end
end
%������ѭ��
i = 1:h;
j = 1:w;
img_2(i,j) = round( (n-1) * CDF(img_1(i,j) + 1)/(h * w));
img_2 = uint8(img_2 * (L-1) / (n-1));

end
