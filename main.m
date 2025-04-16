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

S_rx = channel_model(OFDM_symbol, 8, 25);

for i = 1:length(S_rx)
    fprintf('OFDM поднесущая (приём) %d: %.3f + %.3fi\n', i, real(S_rx(i)), imag(S_rx(i)));
end

disp(" ")

disp("-----ПРАКТИКА 7-----")

QPSK_symbols_rx = OFDM_demodulator(S_rx, 3, 1/8, length(QPSK_symbols));

for i = 1:length(QPSK_symbols_rx)
    fprintf('QPSK символ (приём) %d: %.3f + %.3fi\n', i, real(QPSK_symbols_rx(i)), imag(QPSK_symbols_rx(i)));
end

disp(" ")

disp("-----ПРАКТИКА 8-----")

bit_sequence_after_demapper8 = QPSK_demapper(QPSK_symbols_rx);
disp("Битовая последовательность после QPSK-демодулятора: ")
fprintf('%d', bit_sequence_after_demapper8);
fprintf('\n')

disp(" ")

deinterleaved_message8 = inverse_interleaving(bit_sequence_after_demapper8);
disp("Битовая последовательность после обратного перемежения: ")
fprintf('%d', deinterleaved_message8);
fprintf('\n');

disp(" ")

conv_decoded_message8 = conv_decoder_viterbi(deinterleaved_message8);
disp("Битовая последовательность после декодера Витерби: ")
fprintf('%d', conv_decoded_message8);
fprintf('\n');

disp(" ")

decoded_message8 = sign_decoder(conv_decoded_message8);
disp("Декодированное сообщение: ")
fprintf('%c', decoded_message8);
fprintf('\n');

disp(" ")

disp("-----Расчёт BER-----");

original_bits = encoded_message;
received_bits = conv_decoded_message8;

total_bits = length(original_bits);
original_bits = original_bits(1:total_bits);
received_bits = received_bits(1:total_bits);

error_bits = sum(original_bits ~= received_bits);

BER = error_bits / total_bits;

fprintf('Количество ошибочных битов: %d\n', error_bits);
fprintf('Общее количество битов: %d\n', total_bits);
fprintf('BER = %.3f (%.2f%%)\n', BER, BER * 100);

figure;
subplot(2, 2, 1);
plot(abs(fft(OFDM_symbol)), 'b-', 'LineWidth', 1);
title('Спектр переданного OFDM-символа');
xlabel('Частота');
ylabel('Амплитуда');
grid on;

subplot(2, 2, 2);
plot(abs(fft(S_rx)), 'b-', 'LineWidth', 1);
title('Спектр принятого OFDM-символа');
xlabel('Частота');
ylabel('Амплитуда');
grid on;

subplot(2, 2, 3);
plot(QPSK_symbols, '.', 'MarkerSize', 10);
title('Сигнальное созвездие QPSK-сигнала в передатчике');
xlabel('Real');
ylabel('Imag');
grid on;
hold on;
ref_points = (1/sqrt(2)) * [-1-1i, -1+1i, 1-1i, 1+1i];
plot(ref_points, 'ro', 'MarkerSize', 8, 'LineWidth', 2);

subplot(2, 2, 4);
plot(QPSK_symbols_rx, '.', 'MarkerSize', 10);
title('Сигнальное созвездие QPSK-сигнала в приёмнике');
xlabel('Real');
ylabel('Imag');
grid on;
hold on;
ref_points = (1 / sqrt(2)) * [-1-1i, -1+1i, 1-1i, 1+1i];
plot(ref_points, 'ro', 'MarkerSize', 8, 'LineWidth', 2);
