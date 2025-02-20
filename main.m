clc; clear; close all;

text = 'Hello world';

encoded_message = sign_coder(text);
disp("Закодированное сообщение: ")
disp(encoded_message)

disp(" ")

decoded_message = sign_decoder(encoded_message);
disp("Декодированное сообщение: ")
disp(decoded_message)
