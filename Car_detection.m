clc,close all
clear all
%Load Image
Car1=imread('car1.png');
%Grayscale Image
Car2=rgb2gray(Car1);
figure
imshow(Car2)
title('\fontsize{15}Grayscale Image')
%Binery Image by gradient
BW1=edge(Car2,'prewitt');
figure
imshow(BW1)
title('\fontsize{15}Binery Image by gradient')
%Remove Continuce Line
S=size(BW1);
n1=0;
for i1=1:S(1)
    if mean(BW1(i1,:))>.1
        n1=n1+1;
        BW1(i1,:)=0;
    end
end
figure
imshow(BW1)
title('\fontsize{15}Binery Image by gradient with Remove Continuce Line')
%Find Boundary binery image
[B,L,N] = bwboundaries(BW1);
n1=0;
%Choose usefull boundary
for k=1:length(B),
    b1 = B{k};
    if length(b1)>50 & length(b1)<500 
       m1_x=min(b1(:,2));
       m1_y=min(b1(:,1));
       m2_x=max(b1(:,2));
       m2_y=max(b1(:,1));
       if (m2_x-m1_x)/(m2_y-m1_y)>.5 & (m2_x-m1_x)/(m2_y-m1_y)<3 
          n1=n1+1; 
          Position(n1,1)=m1_x;
          Position(n1,2)=m1_y;
          Position(n1,3)=m2_x;
          Position(n1,4)=m2_y;
       end
    end
end
n1=0;
for i1=1:length(Position)
    x1=Position(i1,1);
    y1=Position(i1,2);
    x2=Position(i1,3);
    y2=Position(i1,4);
    for i2=i1:length(Position)
        if i2~=i1
            X1=Position(i2,1);
            Y1=Position(i2,2);
            X2=Position(i2,3);
            Y2=Position(i2,4); 
            if ((length(intersect((x1:x2),(X1:X2)))~=0) & ((length(intersect((y1:y2),(Y1:Y2)))~=0)))
                n1=n1+1;
                HM(n1,:)=[i1 i2];
            end
        end
    end
end

%Show find cars
figure
imshow(Car1)
n1=0;
for i1=1:length(Position)
    x1=Position(i1,1);
    y1=Position(i1,2);
    x2=Position(i1,3);
    y2=Position(i1,4);
    if length(find(HM(:,2)==i1))==0
       hold on
       plot([x1 x2 x2 x1 x1],[y1 y1 y2 y2 y1],'r')
       drawnow
       n1=n1+1;
    end
end
title(['\fontsize{15}Main Image with cars detection(numbers car=',num2str(n1),')'])



