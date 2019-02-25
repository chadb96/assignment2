%Part 2
close all;
clear

nx =20;
ny =20;
G =sparse(nx*ny,nx*ny);
i=1;
j=1;
ConM =zeros(ny,nx);
%ConM is an empty conductivity matrix
%The following for loop is to send the conductivity values with a bottle
%neck
for i =1:1:ny
    for j =1:1:nx
        if i>=0.4*nx&&i<=0.6*nx&&j<=0.4*ny
            ConM(i,j) =.01;
        elseif i>=0.4*nx && i<=0.6*nx&&j>=0.6*ny
            ConM(i,j) =.01;
        else
            ConM(i,j) =1;
        end
    end
end
figure(1);
surf(ConM);
title 'Conductivity Regions';
xlabel 'Length';
ylabel 'Width';
zlabel 'Sigma';

Mat0 =zeros(nx*ny,1);

for i =1:1:ny
    for j =1:1:nx
    n =j+(i-1)*nx;
    niplus1 =j+(i+1-1)*nx;
    niminus1 =j+(i-1-1)*nx;
    njpplus1 =(j+1)+(i-1)*nx;
    njminus1 =(j-1)+(i-1)*nx;
    if i == 1
        G(n,:) =0;
        G(n,n) =1;
        Mat0(n,1) =1;
    elseif i == ny
        G(n,:) =0;
        G(n,n) =1;
        Mat0(n,1) =0;
    elseif j == 1
        G(n,niplus1) =2*ConM(i+1,j)+1/(2*ConM(i,j));             
        G(n,niminus1) =2*ConM(i-1,j)+1/(2*ConM(i,j));
        G(n,njpplus1) =2*ConM(i,j+1)+1/(2*ConM(i,j));
        G(n,n) =-(G(n,niplus1)+G(n,niminus1)+G(n,njpplus1));
    elseif j == nx
        G(n,niplus1) =2*ConM(i+1,j)+1/(2*ConM(i,j));             
        G(n,niminus1)=2*ConM(i-1,j)+1/(2*ConM(i,j));
        G(n,njminus1) =2*ConM(i,j-1)+1/(2*ConM(i,j));
        G(n,n) =-(G(n,niplus1)+G(n,niminus1)+G(n,njminus1));
    else
        G(n,niplus1) =2*ConM(i+1,j)+1/(2*ConM(i,j));
        G(n,niminus1) =2*ConM(i-1,j)+1/(2*ConM(i,j));
        G(n,njminus1) =2*ConM(i,j-1)+1/(2*ConM(i,j));
        G(n,njpplus1) =2*ConM(i,j+1)+1/(2*ConM(i,j));
        G(n,n) =-(G(n,niplus1)+G(n,niminus1)+G(n,njminus1)+G(n,njpplus1));
        end
    end
end
 Vol=G\Mat0;
 Mat1=zeros(ny,nx);
 for i =1:1:ny
     for j =1:1:nx
         n =j+(i-1)*nx;
         Mat1(j,i) =Vol(n);
     end
 end
figure(2);
   surf(Mat1(:,:));
   title 'Voltage Potential';
   xlabel 'Width';
   ylabel 'Length';
   zlabel 'Voltage';
   
   figure(3);
   [Ex,Ey] =gradient(Mat1);
   quiver(Ex,Ey);
   title 'Electric Field';
   xlabel 'X Direction';
   ylabel 'Y Direction';
   
   figure(4);
   Jx =ConM.*Ex;
   Jy =ConM.*Ey;
   quiver(Jx,Jy);
   title 'Current Density';
   xlabel 'J in X Direction';
   ylabel 'J in Y Direction';
        