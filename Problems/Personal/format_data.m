% returns cell arrays with 
% student_course = [student_id, course_id]
% exam_ids = unique course_ids
function [course_to_students_map, exam_ids] = format_data()
fid = fopen('enrolements','rt');
student_ids = [];
course_ids = [];
exam_ids = [];

while true
  thisline = fgetl(fid);
  if ~ischar(thisline); break; end  %end of file
    %now check whether the string in thisline is a "word", and store it if it is.
    %then
    student_ids = [student_ids extractBetween(thisline, 1, 10)];
    course_ids = [course_ids extractBetween(thisline, 12, 19)];
end
fclose(fid);

fid = fopen('exams','rt');
while true
  thisline = fgetl(fid);
  if ~ischar(thisline); break; end  %end of file
    %now check whether the string in thisline is a "word", and store it if it is.
    %then
    exam_ids = [exam_ids extractBetween(thisline, 1, 8)];
end
fclose(fid);

students_in_course = {};
for i=1:length(exam_ids)
    students_in_course{end+1} = {};
end

course_to_students_map = containers.Map(exam_ids, students_in_course);

for i=1:length(student_ids)
    students = course_to_students_map(course_ids{i});
    students{end + 1} = student_ids{i};
    course_to_students_map(course_ids{i}) = students;
end

