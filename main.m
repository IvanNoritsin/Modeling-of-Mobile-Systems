clc; clear; close all;

text = 'Hello world';

disp("-----ПРАКТИКА 1-----")

encoded_message = sign_coder(text);
disp("Закодированное сообщение: ")
fprintf('%d', encoded_message);
fprintf('\n');

disp(" ")

decoded_message = sign_decoder(encoded_message);
disp("Декодированное сообщение: ")
fprintf('%c', decoded_message);
fprintf('\n');

disp(" ")

disp("-----ПРАКТИКА 2-----")

conv_encoded_message = conv_encoder(encoded_message);
disp("Битовая последовательность после свёрточного кодера: ")
fprintf('%d', conv_encoded_message);
fprintf('\n');

disp(" ")

conv_decoded_message = conv_decoder_viterbi(conv_encoded_message);
disp("Битовая последовательность после декодера Витерби: ")
fprintf('%d', conv_decoded_message);
fprintf('\n');

disp(" ")

decoded_message2 = sign_decoder(conv_decoded_message);
disp("Декодированное сообщение: ")
fprintf('%c', decoded_message2);
fprintf('\n');

disp(" ")

disp("-----ПРАКТИКА 3-----")

interleaved_message = interleaving(conv_encoded_message);
disp("Битовая последовательность после перемежения: ")
fprintf('%d', interleaved_message);
fprintf('\n');

disp(" ")

deinterleaved_message = inverse_interleaving(interleaved_message);
disp("Битовая последовательность после обратного перемежения: ")
fprintf('%d', deinterleaved_message);
fprintf('\n');

disp(" ")

conv_decoded_message3 = conv_decoder_viterbi(deinterleaved_message);
disp("Битовая последовательность после декодера Витерби: ")
fprintf('%d', conv_decoded_message3);
fprintf('\n');

disp(" ")

decoded_message3 = sign_decoder(conv_decoded_message3);
disp("Декодированное сообщение: ")
fprintf('%c', decoded_message3);
fprintf('\n');

disp(" ")

disp("-----ПРАКТИКА 4-----")

QPSK_symbols = QPSK_mapper(interleaved_message);

for i = 1:length(QPSK_symbols)
    fprintf('QPSK символ %d: %.3f + %.3fi\n', i, real(QPSK_symbols(i)), imag(QPSK_symbols(i)));
end

disp(" ")

bit_sequence_after_demapper = QPSK_demapper(QPSK_symbols);
disp("Битовая последовательность после QPSK-демодулятора: ")
fprintf('%d', bit_sequence_after_demapper);
fprintf('\n')

disp(" ")

deinterleaved_message4 = inverse_interleaving(bit_sequence_after_demapper);
disp("Битовая последовательность после обратного перемежения: ")
fprintf('%d', deinterleaved_message4);
fprintf('\n');

disp(" ")

conv_decoded_message4 = conv_decoder_viterbi(deinterleaved_message4);
disp("Битовая последовательность после декодера Витерби: ")
fprintf('%d', conv_decoded_message4);
fprintf('\n');

disp(" ")

decoded_message4 = sign_decoder(conv_decoded_message4);
disp("Декодированное сообщение: ")
fprintf('%c', decoded_message4);
fprintf('\n');

disp(" ")

disp("-----ПРАКТИКА 5-----")

OFDM_symbol = OFDM_modulator(QPSK_symbols, 3, 1/8);

for i = 1:length(OFDM_symbol)
    fprintf('OFDM поднесущая %d: %.3f + %.3fi\n', i, real(OFDM_symbol(i)), imag(OFDM_symbol(i)));
end

disp(" ")

disp("-----ПРАКТИКА 6-----")

S_rx = channel_model(OFDM_symbol, 8, -70);

for i = 1:length(S_rx)
    fprintf('OFDM поднесущая (приём) %d: %.3f + %.3fi\n', i, real(S_rx(i)), imag(S_rx(i)));
end