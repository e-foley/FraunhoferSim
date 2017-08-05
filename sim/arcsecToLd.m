function [ LD_multiple ] = arcsecToLd(arcsec, wavelength, diameter)
separation_rad = arcsec * (1/3600) * (2*pi/360);
LD_rad = (wavelength / 1e9) / (diameter * (1/12) * (1/3.28));
LD_multiple = separation_rad / LD_rad;
end
