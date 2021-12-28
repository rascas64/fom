function [output_sign] = demod_DSSS(input_sign, chips, fact)
    % Initialisation du facteur multiplicatif
    if fact == 0
        fact = 10;
    end

    % Décodage du signal
    temp = xor(input_sign, chips);

    output_sign = [];
    for e=1:fact:length(temp)
        output_sign = [output_sign, temp(e)];
    end

end

