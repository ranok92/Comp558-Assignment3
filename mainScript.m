close all;
clear all;
beetle = imread('beetle.jpg');
beetle = rgb2gray(beetle);

sprl = imread('spiral.jpg');
sprl = rgb2gray(sprl);

psi = create_psi(sprl);

pause;

out = geometric_heatequation(sprl,psi,.1,40000);

pause;

out = segment_image(beetle,6000,.1);

