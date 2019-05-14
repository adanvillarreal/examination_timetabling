%Apegándome al Código de Ética de los Estudiantes del Tecnológico de Monterrey, ´
%me comprometo a que mi actuación en este examen esté regida por la honestidad
%académica.
% Adan Villarreal Chapa
% A01281312
% Héctor Miguel Morales González
% A01193139
% Jorge Olvera Ramirez
% A01192923
function [res] = experiment()
    problem = {};
    solutions = {};
    res = zeros(50, 5);
    count = 1;
    for i=1:9
        for j=0:5
        res(count, 1) = i * 5 / 100;
        res(count, 2) = j * 12;
        [a, b, c] = runner_exm(j*8, 8, "sp" + string(i * 5), 150, 50000);
        res(count, 3) = b;
        res(count, 4) = c;
        count = count + 1;
        end
    end
end

