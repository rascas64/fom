function [out_ber] = ber(bin1, bin2)

    s = 0;
    for i = 1:length(bin1)
        if bin1(i) == bin2(i)
            s = s+1;
        end
    end

    out_ber = 1-s/length(bin1);
end

