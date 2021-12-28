function [output_sign, chips, fact] = mod_DSSS(input_sign, fact)
    % Initialisation du facteur multiplicatif
    if fact == 0
        fact = 10;

    % Génération du signal d'encodage
    n = length(input_sign);
    chips = randi([0, 1], 1, n*fact);
    
    % Changement de dimension du signal d'entrée
    temp = [];
    for i=1:length(input_sign)
        temp = [temp, ones(1, fact)*input_sign(i)];
    end

    % Encodage
    output_sign = xor(temp, chips);


end

