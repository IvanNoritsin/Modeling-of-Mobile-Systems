function bit_sequence = QPSK_demapper(QPSK_array)

    length_QPSK_array = length(QPSK_array);
    bit_sequence = zeros(1, length_QPSK_array * 2);

    for i = 1:length_QPSK_array
        QPSK_real = real(QPSK_array(i));
        QPSK_imag = imag(QPSK_array(i));
        if QPSK_real >= 0 && QPSK_imag >= 0
            bit_sequence(2 * i - 1 : 2 * i) = [0 0];
        elseif QPSK_real >= 0 && QPSK_imag < 0
            bit_sequence(2 * i - 1 : 2 * i) = [0 1];
        elseif QPSK_real < 0 && QPSK_imag >= 0
            bit_sequence(2 * i - 1 : 2 * i) = [1 0];
        elseif QPSK_real < 0 && QPSK_imag < 0
            bit_sequence(2 * i - 1 : 2 * i) = [1 1];    
        end
    end
end