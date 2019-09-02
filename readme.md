# Fraunhofer Diffraction Simulator
Written by Ed Foley

## Introduction
Fraunhofer diffraction is the mode of diffraction one encounters when a diffracting object is far
from both the emitting object and the plane of observation. This configuration dominates the field
of stellar astronomy.

This repository contains a suite of MATLAB code dedicated to the simulation of Fraunhofer
diffraction. Functions include creating custom apertures, visualizing diffraction patterns, and
creating formatted contrast plots. Diffractive properties of one aperture can be compared with
properties of others within the same plot by invoking certain functions upon multiple objects.

Presently, all simulations are monochromatic.

## What you'll need
* MATLAB (verified functional on R2018a)
* MATLAB Image Processing Toolbox (recommended but optional)

The Image Processing Toolbox enables the `poly2mask` and `imrotate` functions, among others. These
are used to create masks with polygonal openings, spiders, and oriented screens within
*makeApertures.m*. If these are not required for your application, there is no need to install the
Image Processing Toolbox.

## Getting started
1. Install MATLAB.
2. Optionally, install the Image Processing Toolbox.
3. Do either of the following:
 * Clone this repository to your computer
 * Download this repository as a ZIP file and extract it to a location on your computer.
4. Open MATLAB.
5. Open *demo.m* from the location in which you placed the repository's contents.
6. Run *demo.m*. If prompted to do so, add the path to your MATLAB working directory.

The script may take a minute or so to run. Afterward, you should see aperture images created within
the *apertures* directory. Contrast plots and other figures should appear within the *plots*
directory. From here, you can modify the demo script as required by your application. Enjoy!
