function QPSK_array = QPSK_mapper(bit_sequence)

    if mod(length(bit_sequence), 2) ~= 0
        bit_sequence = [bit_sequence, 0];
    end

    length_QPSK_array = length(bit_sequence) / 2;
    QPSK_array = zeros(1, length_QPSK_array);

    for i = 1:length_QPSK_array
        bit_1 = bit_sequence(2 * i - 1);
        bit_2 = bit_sequence(2 * i);
        if bit_1 == 0 && bit_2 == 0
            QPSK_array(i) = 0.707 + 0.707i;
        elseif bit_1 == 0 && bit_2 == 1
            QPSK_array(i) = 0.707 - 0.707i;
        elseif bit_1 == 1 && bit_2 == 0
            QPSK_array(i) = -0.707 + 0.707i;
        elseif bit_1 == 1 && bit_2 == 1
            QPSK_array(i) = -0.707 - 0.707i;
        end
    end
end