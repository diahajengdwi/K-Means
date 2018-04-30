% Diah Ajeng Dwi Yuniasih
% 1301154558
% IF39-12

clc; clear all;
% Load data training
trainset = dlmread('TrainsetTugas2.txt','\t','A1..B688');
% Load data testing
tesset = dlmread('TestsetTugas2.txt','\t','A1..B100');

% -	Menentukkan K sebagai jumlah cluster yang ingin dibentuk
[idx, ce] = kmeans(trainset, 4);
% Menginisasi centroid selanjutnya dengan nilai 0
sz = size(ce);
c = zeros(sz);

% Hitung Euclidean untuk Data Training
for i = 1 : 688
    % Hitung jarak setiap data ke masing-masing centroid
    for j = 1 : 4
        jarak(i,j) = hitungjarak(ce(j,1), ce(j,2), trainset(i,1), trainset(i,2));
    end
    % Mencari jarak terpendek
    jarak(i,5) = min([jarak(i,1) jarak(i,2) jarak(i,3) jarak(i,4)]);
    % Mengecek jarak terpendek terdapat dimana kemudian meng update nilai
    % centroidnya dengan menghitung rata-rata jarak centroid dengan data trainnnya
    for k = 1 : 4
        if (jarak(i,5) == jarak(i,k))
            c(k,1) = mean([c(k,1), trainset(i,1)]);
            c(k,2) = mean([c(k,2), trainset(i,2)]);
            hasil(i,1) = k;
        end
    end
end

% Hitung Euclidean untuk Data Testing
for i = 1 : 100
    for j = 1 : 4
        jaraktest(i,j) = hitungjarak(c(j,1), c(j,2), tesset(i,1), tesset(i,2));
    end
    % Mencari jarak terpendek
    jaraktest(i,5) = min([jaraktest(i,1) jaraktest(i,2) jaraktest(i,3) jaraktest(i,4)]);
    % Mengecek jarak terpendek terdapat dimana kemudian meng update nilai
    % centroidnya dengan menghitung rata-rata jarak centroid dengan data trainnnya
    for k = 1 : 4
        if (jaraktest(i,5) == jaraktest(i,k))
            c(k,1) = mean([c(k,1), tesset(i,1)]);
            c(k,2) = mean([c(k,2), tesset(i,2)]);
            hasiltest(i,1) = k;
        end
    end
end
%% 


% Plotting Data Training
figure;
plot(trainset(:,1),trainset(:,2),'.');
title 'Plot Data Training';

for i = 1 : 688
    text(trainset(i,1), trainset(i,2), num2str(hasil(i,1)));
    hold on;
end
hold off

% Plotting Data Training
figure;
plot(tesset(:,1),tesset(:,2),'.');
title 'Plot Data Testing';

for i = 1 : 100
    text(tesset(i,1), tesset(i,2), num2str(hasiltest(i,1)));
    hold on;
end
hold off