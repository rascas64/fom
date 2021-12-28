function [output_sign] = demod_OOK(input_sign, n)
    % Récupération de l'enveloppe du signal
    [up, lo] = envelope(input_sign, 1, "analytic");
    
    % Parcour de l'enveloppe par pas n pour reconstituer un signal binaire
    output_sign = [];
    for i=1:n:length(up)
        if up(i+1) > 0
            output_sign = [output_sign 1];
        else
            output_sign = [output_sign 0];
        end
    end
end

