%“Apeg´andome al C´odigo de Etica de los Estudiantes del Tecnol´ogico de Monterrey, ´
%me comprometo a que mi actuaci´on en este examen est´e regida por la honestidad
%acad´emica.”
% Adan Villarreal Chapa
% A01281312
classdef ETP < PROBLEM
% <problem> <BT>
% Individuals are represented as an array with uniqued ID's ranging from
% 1..En+offset, where En is the number of exams to be applied and the index i of
% the array indicates the hall, day, and timeslot of examination. The
% offset is used to set slots without examinations. When the value is
% greater than En, the slot is not used for examinations.
% For this representation, the structure is as follows, where N is
% determined by the number of days:
% N days 
%   3 timeslots
%       15 halls
% e.g. 30 days have 1350 (30 * 3 * 15) slots. If there are 800 exams, all
% the values greater than 800 represent no examination for the given slot.
%
% The INDIVIDUAL has a permutation encoding.
    properties
        X_in;
        Y_in;
    end
    methods
        function obj = ETP()
            obj.Global.D = 800 + 550; % We could use the offset as a variable for experimentation.
            obj.Global.M = 2;
            obj.Global.lower = zeros(1,obj.Global.D); % Lower bounds
            obj.Global.upper = ones(1,obj.Global.D)*obj.Global.D; % Upper bounds
            obj.Global.encoding = 'permutation';
        end
        
        function PopObj = CalObj(obj, PopDec)            
            PopObj = zeros(size(PopDec,1),2);
            for i = 1:obj.Global.N
                individual = PopDec(i, :);
                % Here goes the processing for objectives.
            end

        end
        
         %% Sample reference points on Pareto front
        function P = PF(obj,N)
            P(:,1) = (0:1/(N-1):1)';
            P(:,2) = 1 - P(:,1).^0.5;
        end
    end
end

