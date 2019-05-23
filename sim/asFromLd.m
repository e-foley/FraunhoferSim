function [as] = asFromLd(wavelength_nm, diameter_in)
    ld_rad = (wavelength_nm / 1e9) / (diameter_in * (1/12) * (1/3.28));
    as = ld_rad * 3600 * (360/(2*pi));
end
