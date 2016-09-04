function [must_have_mutation] = have_mutation(p_mutation)
    must_have_mutation = rand <= p_mutation;
end