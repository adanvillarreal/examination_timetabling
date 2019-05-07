function [total_conflicts] = conflict_matrix_exm(indiv, student_exams_mat, simultaneous_n)
%CONFLICT_MATRIX Summary of this function goes here
%   Detailed explanation goes here
total_conflicts = 0;
[students_n, exams_n] = size(student_exams_mat);

for i=0:exams_n/simultaneous_n
    if (i+1)*simultaneous_n > exams_n
        possible_conflicting_courses = indiv(i*simultaneous_n+1:end);
    else
        possible_conflicting_courses = indiv(i*simultaneous_n+1:(i+1)*simultaneous_n);
    end
    possible_conflicting_courses(possible_conflicting_courses > exams_n) = [];
    stu_ex_period = student_exams_mat(:, possible_conflicting_courses);
    exams_per_student = sum(stu_ex_period, 2);
    exams_per_student(exams_per_student <= 1) = [];
    total_conflicts = total_conflicts + sum(exams_per_student);
end

