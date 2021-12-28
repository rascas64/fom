function [out_ber] = ber(bin1, bin2)
    temp = xor(bin1, bin2);
    
    s = sum(temp);

    out_ber = s/length(temp);
end

