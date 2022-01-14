function [sign_OOK, carrier, t] = OOK(bin, ts, fs, fc, Amax)
    t = 0:1/fs:ts;
    carrier = Amax * cos(fc * t);
    cp = []; mod = [];
    for n = 1:length(bin)
        if bin(n) == 0
            m = zeros(1, length(t));
        else
            m = ones(1, length(t));
        end
        cp = [cp carrier];
        mod = [mod m];
    end
    sign_OOK = cp.*mod;
end