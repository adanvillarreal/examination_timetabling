function [offset, solutions] = experiment()
    offset = {};
    solutions = {};
    for i=1:5
        offset{end+1} = i * 250;
        solutions{end+1} = runner(i*250);
    end
end

