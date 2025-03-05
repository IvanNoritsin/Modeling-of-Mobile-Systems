function conv_encoded_message = conv_encoder(bit_sequence)
    constraintLength = 7;
    polynomials = [171 133];

    polyMatrix = [dec2bin(oct2dec(polynomials(1)), constraintLength) - '0';
                  dec2bin(oct2dec(polynomials(2)), constraintLength) - '0'];

    shiftReg = zeros(1, constraintLength);

    conv_encoded_message = [];

    for i = 1:length(bit_sequence)
        shiftReg = [bit_sequence(i), shiftReg(1:end - 1)];

        X = mod(sum(shiftReg .* polyMatrix(1, :)), 2);
        Y = mod(sum(shiftReg .* polyMatrix(2, :)), 2);

        conv_encoded_message = [conv_encoded_message, X, Y];
    end
    
end