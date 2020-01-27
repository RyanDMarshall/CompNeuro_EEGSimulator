clear;clc;close all;

Spatial_type = 'Random';

dt = 0.01;
t = (0:dt:1100)';

num_e = 800;
num_i = 200;
n = num_e + num_i;

conn_density = floor(0.40*n);
p_rewiring = 0.5;
Iapp = 0.2;

g_hat_ee = 0.5; g_hat_ei = 0.2;
g_hat_ie = 0.2; g_hat_ii = 0.2;
tau_d_e_value = 3; tau_d_i_value = 48;

% Delta:
% 0.15, 0.2, 0.2, 0.2, 3, 48, num_e = 800, num_ i = 200,
% 10% conn, p_rewiring = 0, Iapp = 0.13

% Theta:
% 0.0, 0.2, 0.2, 0.2, 3, 80, num_e = 800, num_i = 200, 
% 10% conn, p_rewiring = 0.25, Iapp = 0.135

% Alpha:
% 0.07, 0.2, 0.2, 0.2, 3, 60, num_e = 800, num_i = 200,
% 15% conn, p_rewiring = 0.0, Iapp = 0.15 

% Beta:
% 0.5, 0.2, 0.2, 0.2, 3, 48; num_e = 800, num_i = 200, 
% 40% conn, p_rewiring = 0.5, Iapp = 0.2

% Gamma:
% 0.7, 0.2, 0.2, 0.2, 3, 15; num_e = 800, num_i = 200, 
% 50% conn, p_rewiring = 0.5, Iapp = 0.5

S = SpatialMatrix(Spatial_type, n);
W = adjacency(BuildSmallWorld(S, n, conn_density, p_rewiring));

[spiketimes_i, spiketimes_e, avnfreq] = ... 
    gamma_simulator(W, 2, Iapp, num_e, num_i, g_hat_ee, g_hat_ei, ...
                    g_hat_ie, g_hat_ii, tau_d_e_value, tau_d_i_value);

[t,v,spiketimes] = field_sum_calculator(S, spiketimes_i, spiketimes_e, t, dt);

t_plot = t(11000:(5/dt):end-5);
v_plot = v(11000:(5/dt):end-5);

figure
plot(t_plot,smooth(v_plot));

%% FFT: Unsuccessful
% Y = fft(v_plot);
% f = 1000/length(Y)*(0:length(Y)-1);
% Pyy = abs(Y);
% 
% figure
% plot(f, Pyy);