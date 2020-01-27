%-----------------------------------
% density of synaptic connections: 
p_ee=sum(sum(W_ee))/(size(W_ee,1)*size(W_ee,2));
p_ei=sum(sum(W_ei))/(size(W_ei,1)*size(W_ei,2));
p_ie=sum(sum(W_ie))/(size(W_ie,1)*size(W_ie,2));
p_ii=sum(sum(W_ii))/(size(W_ii,1)*size(W_ii,2));
%-----------------------------------



%-----------------------------------
% rise and decay time constants associated with synapses:
tau_r_e=0.1*ones(num_e,1); tau_d_e=tau_d_e_value*ones(num_e,1); 
tau_r_i=0.3*ones(num_i,1); tau_d_i=tau_d_i_value*ones(num_i,1); 
%-----------------------------------



%-----------------------------------
% synaptic reversal potentials: 
v_rev_e=0; v_rev_i=-80;  
%-----------------------------------



%-----------------------------------
% time simulated (in ms):
t_final=1100;  
%-----------------------------------



%-----------------------------------
% time step used in the midpoint method:
dt=0.02; 
%-----------------------------------



%-----------------------------------
% strength of synaptic connections: 
%g_hat_ie=1.5; g_hat_ei=0.5; g_hat_ii=0.5; g_hat_ee=0;
%-----------------------------------



%-----------------------------------
% external drive to the E-cells:

% deterministic drive:
% homogeneous
%I_e=@(t) 2.5*ones(num_e,1);
%I_e=@(t) 1.25*ones(num_e,1);
% heterogeneous with linear spread
%I_e=@(t) 2.5*ones(num_e,1)+[1:num_e]'/num_e*2.0;
% random heterogeneous
 e_random = 3.0;
 I_e=@(t) 2.5*ones(num_e,1)+e_random*randn(num_e,1);

% maximum conductance, decay time, and frequency of Poisson train of excitatory input pulses:
g_stoch_e=0.0; f_stoch_e=10; tau_d_stoch_e=3; 
%-----------------------------------



%-----------------------------------
% external drive to the I-cells:

% deterministic drive:
I_i=@(t) zeros(num_i,1);
% random heterogeneous
% i_random = 5.0;
% I_i=@(t) i_random*randn(num_i,1);

% maximum conductance, decay time, and frequency of Poisson train of excitatory input pulses:
g_stoch_i=0; f_stoch_i=0; tau_d_stoch_i=3; 
%-----------------------------------
