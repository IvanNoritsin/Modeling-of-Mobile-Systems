function S_rx = channel_model(S_tx, N_b, SNR_dB)
    
    L = length(S_tx);
    c = 3e8;
    B = 11e6;
    f_0 = 1.7e9;
    
    D = 10 + (500-10) * rand(1, N_b);
    D = sort(D);
    T = 1 / B;
    tau = round((D - D(1)) / (c * T));
    G = c ./ (4 * pi * D * f_0);

    S_mpy = zeros(1, L + max(tau));
    for i = 1:N_b
        delayed_signal = [zeros(1, tau(i)), S_tx * G(i)];
        S_mpy(1:length(delayed_signal)) = S_mpy(1:length(delayed_signal)) + delayed_signal;
    end

    S_rx = S_mpy(1:L);

    P_signal = mean(abs(S_rx).^2);
    SNR_linear = 10 ^ (SNR_dB / 10); 
    N_0 = P_signal / (SNR_linear * B); 
    noise_power = N_0 * B;
    
    noise = sqrt(noise_power / 2) * (randn(size(S_rx)) + 1i * randn(size(S_rx)));
    S_rx = S_rx + noise;

end


