function decoded_message = sign_decoder(encoded_message)

    decoded_message = '';

    for i = 1:8:length(encoded_message)

        bits = encoded_message(i:i+7);

        symbol = ascii_table_reverse(bits);

        decoded_message = [decoded_message, symbol];
    end

end
