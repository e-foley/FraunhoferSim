function [result] = log_normalize(input)

result = log10(input ./ max(max(input)));

end