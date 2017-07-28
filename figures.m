% Figure 4
data = csvread('data/figure4.csv');
x=reshape(data(:,1),sqrt(size(data,1)),'');
y=reshape(data(:,2),sqrt(size(data,1)),'');
z=reshape(data(:,3),sqrt(size(data,1)),'');
figure;
mesh (x, y, z);
title('Figure 4');
xlabel ('x (m)');
ylabel ('y (m)');
zlabel ('E_z (V/m)');

% Figure 5a
data = csvread('data/figure5a.csv');
x=reshape(data(:,1),sqrt(size(data,1)),'');
y=reshape(data(:,2),sqrt(size(data,1)),'');
z=reshape(data(:,3),sqrt(size(data,1)),'');
figure;
mesh (x, y, z);
title('Figure 5a');
xlabel ('n_x (m)');
ylabel ('n_t (m)');
zlabel ('SMVPs');
zlim([0 5000]);

% Figure 5a
data = csvread('data/figure5b.csv');
x=reshape(data(:,1),sqrt(size(data,1)),'');
y=reshape(data(:,2),sqrt(size(data,1)),'');
z=reshape(data(:,5),sqrt(size(data,1)),'');
figure;
mesh (x, y, z);
title('Figure 5b');
xlabel ('n_x (m)');
ylabel ('n_t (m)');
zlabel ('SMVPs');
zlim([0 5000]);

% Figure 6
data = csvread('data/figure6.csv',2);
figure;
plot(data(:,1),data(:,2),data(:,1),data(:,3));
title('Figure 6');
legend('Ratio of computational costs')
xlabel ('k');
ylabel ('R');

% Figure 7
data = csvread('data/figure7.csv',2);
figure;
semilogy(data(:,1),data(:,4),data(:,1),data(:,2));
title('Figure 7');
legend('Leapfrog (\Delta t_{CFL})','ParaExp (\Delta t_{CFL})')
xlabel ('time (s)');
ylabel ('Energy (J)');

% Figure 8
data = csvread('data/figure8.csv',2);
figure;
semilogy(data(:,1),data(:,2),data(:,1),data(:,3),data(:,1),data(:,4),data(:,1),data(:,5));
title('Figure 8');
legend('Leapfrog (reference)','Leapfrog (\Delta t_{CFL})','ParaExp (\Delta t_{CFL})','ParaExp (\Delta t_{CFL}/5)')
xlabel ('frequency (Hz)');
ylabel ('E (V/m)');

% Figure 9
data = csvread('data/figure9.csv',2);
figure;
plot(data(:,1),data(:,2),data(:,1),data(:,3),data(:,1),data(:,4));
title('Figure 9');
legend('Leapfrog (reference)','Leapfrog (\Delta t_{CFL})','ParaExp (\Delta t_{CFL}/5)')
xlabel ('time (s)');
ylabel ('E (V/m)');

% Figure 11
figure;
barh(categorical({'ParaExp','Leapfrog'}),[21654,34864]);
title('Figure 11');
xlim([0 40000]);

