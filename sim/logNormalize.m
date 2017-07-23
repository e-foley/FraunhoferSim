function [result] = logNormalize(input)

result = log10(input ./ max(max(input)));

end