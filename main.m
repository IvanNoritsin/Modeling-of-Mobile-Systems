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
