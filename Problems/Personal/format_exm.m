% returns matrix of 1 or 0 indicating if the student in row i has exam in
% column j.
function [student_exams_mat] = format_exm(filename)
fid = fopen(filename + ".exm", 'rt');

n_exams = 0;
max_n_students = 0;
while true
  thisline = fgetl(fid);
  if ~ischar(thisline); break; end  %end of file
    %now check whether the string in thisline is a "word", and store it if it is.
    %then
    n_exams = n_exams + 1;
    raw_data_array = str2num(thisline);
    max_n_students = max(max_n_students, raw_data_array(2));
end
fclose(fid);

student_to_exams = {};
student_num = 1;
fid = fopen(filename + ".stu",'rt');
while true
  thisline = fgetl(fid);
  if ~ischar(thisline); break; end  %end of file
    %now check whether the string in thisline is a "word", and store it if it is.
    %then
    student_to_exams{end + 1} = str2num(thisline);
end
fclose(fid);

student_exams_mat = zeros(length(student_to_exams), n_exams);

for i=1:length(student_to_exams)
    for j=1:length(student_to_exams{i})
        student_exams_mat(i, student_to_exams{i}(j)) = 1;
    end
end

disp(student_exams_mat);
end

