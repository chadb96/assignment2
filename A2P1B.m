%Part 1b
close all;
clear
W =30;
L =20;
V0 =2;
matrix =zeros(L,W);
matrix(:,1) =V0;
matrix(:,W) =V0;

time =1000;
step =1;

figure(1);

for i =0:step:time
    for j =2:1:(L-1)
        for k =2:1:(W-1)
            matrix(j,k) = (matrix(j+1,k)+matrix(j-1,k)+matrix(j,k-1)+matrix(j,k+1))/4;
        end 
    end
    surf(matrix);
    grid on;
    title 'Part 1b';
    xlabel 'Length';
    ylabel 'Width';
    zlabel 'Voltage'
    pause(0.001);
end