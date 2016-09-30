function population = bit_flip_mutation(population, pop_size, m_prob)
    [~, g_size] = size(population(1, :));
    probs = rand(pop_size, g_size);
    flips_id = find(probs < m_prob);
    population(flips_id) = not(population(flips_id));
end