%Apegándome al Código de Ética de los Estudiantes del Tecnológico de Monterrey, ´
%me comprometo a que mi actuación en este examen esté regida por la honestidad
%académica.
% Adan Villarreal Chapa
% A01281312
% Héctor Miguel Morales González
% A01193139
% Jorge Olvera Ramirez
% A01192923

% Takes an individual, a matrix of students vs exams and the number of
% concurrent events and returns as output the total enrollment conflicts
% for the given individual.
function [total_conflicts] = conflict_matrix_exm(indiv, student_exams_mat, simultaneous_n)
total_conflicts = 0;
[students_n, exams_n] = size(student_exams_mat);

% get the chunk of concurrent events
for i=0:exams_n/simultaneous_n
    if (i+1)*simultaneous_n > exams_n
        possible_conflicting_courses = indiv(i*simultaneous_n+1:end);
    else
        possible_conflicting_courses = indiv(i*simultaneous_n+1:(i+1)*simultaneous_n);
    end
    % remove the empty timeslots from the possible conflicting courses.
    possible_conflicting_courses(possible_conflicting_courses > exams_n) = [];
    % get the exams for the possible conflicting courses
    stu_ex_period = student_exams_mat(:, possible_conflicting_courses);
    % reduce the matrix by adding columns. If the student has 1 or 0, it
    % means that there are no conflicts, otherwise, there are conflicts
    % because there is more than one exam during the concurrent event
    % window.
    exams_per_student = sum(stu_ex_period, 2);
    exams_per_student(exams_per_student <= 1) = [];
    total_conflicts = total_conflicts + sum(exams_per_student);
end

