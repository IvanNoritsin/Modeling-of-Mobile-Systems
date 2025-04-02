function QPSK_symbols = OFDM_demodulator(S_rx, RS, T, N_qpsk)

    CP_len = round(T * (length(S_rx) / (1 + T)));
    S_rx_no_cp = S_rx(CP_len + 1:end);
    
    S_freq = fft(S_rx_no_cp);
    
    C_val = 1/4;
    N_rs = floor(N_qpsk / RS);
    N_rs_qpsk = N_qpsk + N_rs;
    N_z = floor(C_val * N_rs_qpsk);
    
    C = S_freq(N_z + 1 : N_z + N_rs_qpsk);
    
    subcarriers = 1:N_rs_qpsk;
    pilot_subcarriers = subcarriers(1:N_rs_qpsk/N_rs:N_rs_qpsk);
    data_subcarriers = setdiff(subcarriers, pilot_subcarriers);
    
    R_rx = C(pilot_subcarriers);
    R_tx = (1 + 0i) * ones(size(R_rx));
    H = R_rx ./ R_tx;
    
    H_EQ = interp1(pilot_subcarriers, H, subcarriers, 'linear', 'extrap');
    
    C_EQ = C ./ H_EQ;
    
    figure;
    subplot(3,1,1);
    plot(subcarriers, abs(C), 'b-', 'LineWidth', 1);
    hold on;
    stem(pilot_subcarriers, abs(C(pilot_subcarriers)), 'r', 'filled', 'MarkerSize', 4);
    title('Спектр принятого OFDM-символа до эквалайзирования (C)');
    grid on;
    xlim([1 N_rs_qpsk]);
    
    subplot(3,1,2);
    plot(subcarriers, abs(H_EQ), 'b-', 'LineWidth', 1);
    hold on;
    stem(pilot_subcarriers, abs(C(pilot_subcarriers)), 'r', 'filled', 'MarkerSize', 4);
    title('Корректирующая АЧХ эквалайзера (H_{EQ})');
    grid on;
    xlim([1 N_rs_qpsk]);
    
    subplot(3,1,3);
    plot(subcarriers, abs(C_EQ), 'b-', 'LineWidth', 1);
    title('Спектр принятого OFDM-символа после эквалайзирования (C_{EQ})');
    xlabel('Индекс поднесущей');
    grid on;
    xlim([1 N_rs_qpsk]);
    
    QPSK_symbols = C_EQ(data_subcarriers);

end