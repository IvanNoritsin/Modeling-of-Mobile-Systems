function OFDM_symbol = OFDM_modulator(QPSK_symbols, RS, T)

    N_qpsk = length(QPSK_symbols);
    N_rs = floor(N_qpsk / RS);
    pilot_value = 1 + 0i;
    N_rs_qpsk = N_qpsk + N_rs;

    subcarriers = (1:N_rs_qpsk);
    pilot_subcarriers = subcarriers(1:N_rs_qpsk/N_rs:N_rs_qpsk);
    data_subcarriers = setdiff(subcarriers, pilot_subcarriers);
    
    OFDM_symbol = zeros(1, N_rs_qpsk);
    OFDM_symbol(pilot_subcarriers) = pilot_value;
    OFDM_symbol(data_subcarriers) = QPSK_symbols;

    C = 1 / 4;
    N_z = floor(C * (N_rs_qpsk));
    OFDM_symbol = [zeros(1, N_z), OFDM_symbol, zeros(1, N_z)];

    OFDM_symbol = ifft(OFDM_symbol);

    CP_len = round(T * length(OFDM_symbol));
    cyclic_prefix = OFDM_symbol(end - CP_len + 1:end);
    OFDM_symbol = [cyclic_prefix, OFDM_symbol];

end