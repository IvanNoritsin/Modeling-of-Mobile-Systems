function interleaved_bits = interleaving(bit_sequence)
    rng(15);
    permuted_indices = randperm(length(bit_sequence));
    interleaved_bits = bit_sequence(permuted_indices);
end