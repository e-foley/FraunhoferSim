% This doesn't actually force low numbers to zero or high numbers to one.
% That happens during a conversion to PNG.
function [bounded] = boundShades(logged, mag_lims)

bounded = (1/(mag_lims(2) - mag_lims(1))) * logged + (mag_lims(2) / (mag_lims(2) - mag_lims(1)));

end
