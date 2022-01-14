function [output_sign] = demod_OOK(input_sign, n)
    % Récupération de l'enveloppe du signal
    [up, ~] = envelope(input_sign, 1, "analytic");
    
    % Parcours de l'enveloppe par pas n pour reconstituer un signal binaire
    output_sign = [];
    A = max(input_sign);
    for i=1:n:length(up)
        if up(i+1) > A/2
            output_sign = [output_sign 1];
        else
            output_sign = [output_sign 0];
        end
    end
end

