function inverse_interleaved_bits = inverse_interleaving(interleaved_bits)
    rng(15);
    permuted_indices = randperm(length(interleaved_bits));
    inverse_interleaved_bits = zeros(size(interleaved_bits));
    inverse_interleaved_bits(permuted_indices) = interleaved_bits;
end