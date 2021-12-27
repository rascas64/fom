function [output_sign, chips] = mod_DSSS(input_sign, fact)
    if fact == 0
        fact = 10;
    n = length(input_sign);
    chips = randi([0, 1], 1, n*fact);
    
    temp = [];
    for i=1:length(input_sign)
        temp = [temp, ones(1, fact)*input_sign(i)];
    end

    output_sign = xor(temp, chips);


end

