function [subjects] = mutate(subjects, n_subjects)
    pos_subject = 1+round(1*rand);
    pos = randperm(n_subjects,2);
    aux = subjects(pos_subject,pos(1));
    subjects(pos_subject,pos(1)) = subjects(pos_subject,pos(2));
    subjects(pos_subject,pos(2)) = aux;
end