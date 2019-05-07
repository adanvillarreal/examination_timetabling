function [total_conflicts] = conflict_matrix(indiv, course_ids, course_to_students_map)
%CONFLICT_MATRIX Summary of this function goes here
%   Detailed explanation goes here
total_conflicts = 0;
for i=1:length(course_ids)/45
    if (i+1) * 45 > length(course_ids)
        possible_conflicting_courses = indiv(i*45+1:end);
    else
        possible_conflicting_courses = indiv(i*45+1:(i+1)*45);
    end
    for j=1:length(possible_conflicting_courses)
        idx = possible_conflicting_courses(j);
        if (idx > 800)
            continue
        end
        course_x = course_to_students_map(course_ids{idx});
        for k=j+1:length(possible_conflicting_courses)
            idy = possible_conflicting_courses(k);
            if (idy > 800)
                continue
            end
            course_y = course_to_students_map(course_ids{idy});
            conflicting_students = length(intersect(course_x, course_y));
            total_conflicts = total_conflicts + conflicting_students;
        end
    end
end

