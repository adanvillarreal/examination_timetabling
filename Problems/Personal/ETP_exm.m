%Apegándome al Código de Ética de los Estudiantes del Tecnológico de Monterrey,
%me comprometo a que mi actuación en este examen esté regida por la honestidad
%académica.
% Adan Villarreal Chapa
% A01281312
% Héctor Miguel Morales González
% A01193139
% Jorge Olvera Ramirez
% A01192923
classdef ETP_exm < PROBLEM
% <problem> <BT>
% Individuals are represented as an array with uniqued ID's ranging from
% 1..En+offset, where En is the number of exams to be applied and the index i of
% the array indicates timeslot of examination. The
% offset is used to set slots without examinations. When the value is
% greater than En, the slot is not used for examinations.
% The INDIVIDUAL has a permutation encoding.
    properties
        X_in;
        Y_in;
    end
    methods
        function obj = ETP_exm()
            obj.Global.M = 2;
            obj.Global.lower = zeros(1,obj.Global.D); % Lower bounds
            obj.Global.upper = ones(1,obj.Global.D)*obj.Global.D; % Upper bounds
            obj.Global.encoding = 'permutation';
        end
        
        function PopObj = CalObj(obj, PopDec)  
            glob = obj.Global.parameter.ETP_exm{1,1};
            % matrix of students vs exams
            student_exams_mat = glob.mat;
            [students_n, exams_n] = size(student_exams_mat);
            % number of events ocurring concurrently
            simultaneous_n = glob.simultaneous_events;
            slots = obj.Global.D;
            iterations = obj.Global.N;
            PopObj = zeros(size(PopDec,1),2);
            parfor(i = 1:iterations, 4)
                indiv = PopDec(i, :);
                total_conflicts = conflict_matrix_exm(indiv, student_exams_mat, simultaneous_n);
                % calculate the number of empty slots from the end of the
                % INDIVIDUAL.
                for j = 0:slots-1
                    if(indiv(slots-j) <= exams_n)
                        break
                    end
                end
                PopObj(i, :) = [total_conflicts, -1 * j];
            end
        end
        
         %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (0:1/(N-1):1)';
            P(:,2) = 1 - P(:,1).^0.5;
        end
    end
end

