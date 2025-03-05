function decoded_message = sign_decoder(encoded_message)

    decoded_message = '';

    for i = 1:8:length(encoded_message)

        bits = encoded_message(i:i+7);

        bits_str = char(bits + '0');

        symbol = ascii_table_reverse(bits_str);

        decoded_message = [decoded_message, symbol];
    end

end
