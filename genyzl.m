function [ yzli, ves, add_to_metr, pyt, in_delay_pipe ] = genyzl()

k = 7;
G1 = 171;
G2 = 133;

%% переводим параметры из восьмеричных чисел в двоичные
G1 = dec2bin(oct2dec(G1), k);
G1 = arrayfun(@(x) str2double(x), G1);
G2 = dec2bin(oct2dec(G2), k);
G2 = arrayfun(@(x) str2double(x), G2);

%% формируем параметры декодирования
yzli = cell(1, 2^(k-1));
for i = 0:2^(k-1)-1
    yzli{i+1} = dec2bin(i, k-1);
end

% формируем pyt
pyt = zeros(2, 2^(k-1));
for i = 1:2^(k-1)
    yzel1 = yzli{i}(2:end);
    d = 0;
    for j = 1:2^(k-1)
        yzel2 = yzli{j}(1:end-1);
        if strcmp(yzel1, yzel2)
            d = d + 1;
            pyt(d, i) = j;
        end
    end
end

% формируем веса
ves = cell(2, 2^(k-1));
for i = 1:2^(k-1)
    for p = 1:2
        nomer_pred = pyt(p, i);
        yzel_pred = yzli{nomer_pred};
        yzel_mat = [str2double(yzli{i}(1)), arrayfun(@(x) str2double(x), yzel_pred)];
        
        out_s1 = mod(sum(G1 .* yzel_mat), 2);
        out_s2 = mod(sum(G2 .* yzel_mat), 2);
        ves{p, i} = [out_s1, out_s2];
    end
end

% добавляем метрики к неправдоподобным путям
add_to_metr = [0, repmat(20, 1, 2^(k-1)-1)];

% формируем in_delay_pipe
in_delay_pipe = zeros(2, 2^(k-1));
for i = 1:2^(k-1)
    if yzli{i}(1) == '1'
        in_delay_pipe(:, i) = 1;
    end
end
end
