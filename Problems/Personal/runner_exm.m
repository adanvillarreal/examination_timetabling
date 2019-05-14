%Apegándome al Código de Ética de los Estudiantes del Tecnológico de Monterrey, ´
%me comprometo a que mi actuación en este examen esté regida por la honestidad
%académica.
% Adan Villarreal Chapa
% A01281312
% Héctor Miguel Morales González
% A01193139
% Jorge Olvera Ramirez
% A01192923
function [best_solution, number_of_days, number_of_conflicts] = runner_exm(offset, simultaneous_n, filename, population_size, evaluations)
    % Runs and evaluates the MOEA. Receives a number of empty slots,
    % concurrent events, filename, population size and number of
    % evaluations and returns the best solution, number of timeslots and
    % number of conflicts. 
    
    % get the students-exams matrix for the given file.
    student_exams_mat = format_exm(filename);
    % build the parameters for PlatEMO.
    params = struct('mat', student_exams_mat, 'simultaneous_events', simultaneous_n);
    [students_n, exams_n] = size(student_exams_mat);
    % call platemo
    main('-problem', {@ETP_exm, params}, '-N', population_size, '-M', 2, '-D', exams_n + offset, '-save', 1, '-evaluation', evaluations);
    % load the result from the MOEA
    load('Data/NSGAII/NSGAII_ETP_exm_M2_D'+string(exams_n + offset) + '_1.mat');

    % Result is the 1x2 cell array with properties.
    individuals = result{1,2};
    
    % Extract the ideal solution from the individuals.
    [ideal_conflict, ideal_day] = ideal_solution(individuals);

    % Separate number of bins from correlations, as they come in one linear
    % vector with [conf1,days1,conf2,days2,...,confN,daysN]
    objectives = [individuals.obj];
    conflicts = objectives(1:2:end);
    days = objectives(2:2:end);
    
    % Choose the solution with lower conflicts. If tied, will choose the
    % one with minimum timeslots.
    best_solution_idx = choose_solution(conflicts, days, ideal_conflict, ideal_day);
    best_solution = individuals(best_solution_idx);
    number_of_days = exams_n + offset + days(best_solution_idx);
    number_of_conflicts = conflicts(best_solution_idx);
end

function [ideal_conflicts, ideal_days] = ideal_solution(individuals)
    objectives = [individuals.obj];
    % Separate objectives from correlations (both are in a 1D array)
    conflicts = objectives(1:2:end);
    days = objectives(2:2:end);
    
    % Choose the lowest values
    ideal_conflicts = min(conflicts);
    ideal_days = min(days);
end


% Returns the id of the best solution by lower conflicts and then by lower
% days
function sol_idx = choose_solution(conflicts, days, ideal_conflict, ideal_day)
    min_conflict_idxs = find(conflicts == ideal_conflict);
    days_for_min_conflict = days(min_conflict_idxs);
    [~, min_idx] = min(days_for_min_conflict); 
    sol_idx = min_conflict_idxs(min_idx);
end