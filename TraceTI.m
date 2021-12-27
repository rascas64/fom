function TraceTI(t, y, stair, plt, titre)
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
    title(titre);
    xlabel("Temps en secondes"); ylabel("Amplitude");
end