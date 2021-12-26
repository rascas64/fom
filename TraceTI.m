function TraceTI(t, y, stair, plt)
    if stair == true
        if ~isempty(t)
            stairs(t, y);
            ylim([-0.25, 1.25]); grid on;
        else
            stairs(y);
            ylim([-0.25, 1.25]); grid on;
        end 
    end
    if plt == true
        if ~isempty(t)
            plot(t, y);
        else 
            plot(y);
        end
    end
    title("Représentation temporelle du signal");
    xlabel("Temps en secondes"); ylabel("Amplitude");
end