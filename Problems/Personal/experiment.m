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

