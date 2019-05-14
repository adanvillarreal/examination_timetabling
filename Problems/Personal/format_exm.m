%Apegándome al Código de Ética de los Estudiantes del Tecnológico de Monterrey, ´
%me comprometo a que mi actuación en este examen esté regida por la honestidad
%académica.
% Adan Villarreal Chapa
% A01281312
% Héctor Miguel Morales González
% A01193139
% Jorge Olvera Ramirez
% A01192923

% returns matrix of 1 or 0 indicating if the student in row i has exam in
% column j from a .exm and .stu file.
function [student_exams_mat] = format_exm(filename)
fid = fopen(filename + ".exm", 'rt');

n_exams = 0;
max_n_students = 0;
% get the max number of students to use as dimension for the students-exams
% matrix.
while true
  thisline = fgetl(fid);
  if ~ischar(thisline); break; end
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
  if ~ischar(thisline); break; end
    student_to_exams{end + 1} = str2num(thisline);
end
fclose(fid);

student_exams_mat = zeros(length(student_to_exams), n_exams);

% build a matrix with 0 or 1, indicating if student i has exam j.
for i=1:length(student_to_exams)
    for j=1:length(student_to_exams{i})
        student_exams_mat(i, student_to_exams{i}(j)) = 1;
    end
end

end

