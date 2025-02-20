function encoded_message = sign_coder(text_message)

    encoded_message = [];

    for i = 1:length(text_message)
        
        bits = ascii_table(text_message(i));
        
        encoded_message = [encoded_message, bits];
    end

end