function [ vb ] = conv_decoder_viterbi(input_bits)
    k = 7;
    G1 = 171;
    G2 = 133;

    length_dibits = length(input_bits) / 2; % ���������� �����, ��� �� ���������� ��� �� �����������
    vb = [];
    
    [yzli, ves, add_to_metr, pyt, in_delay_pipe] = genyzl();
    
    nves = length(ves); 
    kb = 1;
    metk = [];
    pyti = [];
    
    % ��������� ������
    dibits = cell(1, length_dibits);
    for i = 1:length_dibits
        dibits{i} = [input_bits(2 * i - 1), input_bits(2 * i)];
    end
    
    for n = 1:length_dibits % ��������������� ������������� ������
        met1 = zeros(1, nves);
        met2 = zeros(1, nves);
        
        % ������� ������� �� ������ ����
        for i = 1:nves
            met1(i) = sum(xor(dibits{n}, ves{1, i})); % ������ ������ - ������ ��������� ������� (0)
            met2(i) = sum(xor(dibits{n}, ves{2, i})); % ������ ������ - ������ ��������� ������� (1)
        end
        
        met = [met1; met2];
        metk = [metk; met];
        
        % ������� ������� �����
        sw = zeros(2, nves);
        for i = 1:2
            for j = 1:nves
                sw(i, j) = met(i, j) + add_to_metr(pyt(i, j));
            end
        end
        
        add_to_metr = min(sw);
        pyti = [pyti; pyt]; % ����������� ��� ����, ����� ��������
        
        % �������� ����, � �������� ������ �������
        for k = 1:nves
            if sw(1, k) <= sw(2, k)
                pyti(2 * n, k) = 0;
            else
                pyti(2 * n - 1, k) = 0;
            end
        end
        
        kp = n; % ���� (����� �����) �� ������� ��������� �������
        
        while kp > kb % kb - ���������� �������������� ���
            for k = 1:nves
                if sum([pyti(2 * kp - 1, :) == k, pyti(2 * kp, :) == k]) == 0
                    pyti(2 * kp - 2, k) = 0;
                    pyti(2 * kp - 3, k) = 0;
                end
            end
            kp = kp - 1;
        end
        
        % ��������� �������������� ����
        p1 = nnz(pyti(2 * kb - 1, :));
        p2 = nnz(pyti(2 * kb, :));
        
        if ((p1 == 1) && (p2 == 0)) || ((p1 == 0) && (p2 == 1))
            nb1 = find(pyti(2 * kb - 1, :));
            nb2 = find(pyti(2 * kb, :));
            
            if (p1 == 1) && (p2 == 0)
                vb = [vb, in_delay_pipe(1, nb1)];
                kb = kb + 1;
            end
            if (p1 == 0) && (p2 == 1)
                vb = [vb, in_delay_pipe(2, nb2)];
                kb = kb + 1;
            end
        end
        
        % �������� ����� �������� ���������� �������
        if (n == length_dibits)
            min_end_metr = min(sw(:));
            
            for i = 1:2
                for j = 1:nves
                    if sw(i, j) == min_end_metr
                        end_way = pyti(2 * length_dibits, j) + pyti(2 * length_dibits - 1, j);
                        vb(length_dibits) = in_delay_pipe(i, j);
                    end
                end
            end
            
            delt = length_dibits - kb + 1;
            for d = delt:-1:2
                vb(kb - 2 + d) = in_delay_pipe(1, end_way);
                end_way = pyti(2 * (kb - 2) + 2 * d, end_way) + pyti(2 * (kb - 2) + 2 * d - 1, end_way);
            end
        end
    end
end
