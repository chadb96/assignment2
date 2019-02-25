%Part 1 With G
close all;
clear

nx =20;
ny =20;
G =zeros(nx*ny,nx*ny);
totnum =nx*ny;
i=1;
j=1;
ConM =zeros(ny,nx);
%ConM is an empty conductivity matrix
for i =1:1:ny
    for j =1:1:nx
        ConM(i,j) =1;
    end
end

Mat0 =zeros(nx*ny,1);

for i =1:1:ny
    for j =1:1:nx
    n = j+(i-1)*nx;
    if i == 1
        G(n,:) =0;
        G(n,n) =1;
        Mat0(n,1) =1;
    elseif i == ny
        G(n,:) =0;
        G(n,n) =1;
        Mat0(n,1) =0;
    elseif j == 1
        G(n,n+1) =2*ConM(i+1,j)+1/(2*ConM(i,j));             
        G(n,n-1) =2*ConM(i-1,j)+1/(2*ConM(i,j));
        G(n,n+nx) =2*ConM(i,j+1)+1/(2*ConM(i,j));
        G(n,n) =-(G(n,n+1)+G(n,n-1)+G(n,n+nx));
    elseif j == nx
        G(n,n+1) =2*ConM(i+1,j)+1/(2*ConM(i,j));             
        G(n,n-1)=2*ConM(i-1,j)+1/(2*ConM(i,j));
        G(n,n-nx) =2*ConM(i,j-1)+1/(2*ConM(i,j));
        G(n,n) =-(G(n,n+1)+G(n,n-1)+G(n,n-nx));
    else
        G(n,n+1) =2*ConM(i+1,j)+1/(2*ConM(i,j));
        G(n,n-1) =2*ConM(i-1,j)+1/(2*ConM(i,j));
        G(n,n-nx) =2*ConM(i,j-1)+1/(2*ConM(i,j));
        G(n,n+nx) =2*ConM(i,j+1)+1/(2*ConM(i,j));
        G(n,n) =-(G(n,n+1)+G(n,n-1)+G(n,n-nx)+G(n,n+nx));
        end
    end
end
 Vol=G\Mat0;
 Mat1=zeros(ny,nx,1);
 for i =1:1:ny
     for j =1:1:nx
         n =j+(i-1)*nx;
         Mat1(i,j) =Vol(n);
     end
 end
 figure(1);
 surf(Mat1(:,:,1));
 title 'Part 1 with G';
 xlabel 'Width';
 ylabel 'Length';
 zlabel 'Voltage';
        