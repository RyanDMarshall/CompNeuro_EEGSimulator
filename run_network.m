clear all 
close all

%%% LIF2D
ConnectivityMatrix;
num = n;
gsyn = 0.0;
taus = 15;
[spiketimes]=LIF2D_simple_network(n,W,gsyn,taus);

% compute mean phase coherence
[mean_mpc, mpc_cellpairs] = mpc_network(num,spiketimes);

% % construct spiketime traces with spkgauss.m
% [timevec,traces, traces_all] = spiketraces(num,spiketimes);
% 
% % compute Golomb bursting measure
% sigma = zeros(num,1);
% for i=1:num
%     sigma(i) = var(traces(i,:));
% end
% sigma_all = var(traces_all);
% B = sigma_all/mean(sigma);
% 
% % compute pairwise cross correlations with zero time lag
% [mean_crcorr, crcorr_cellpairs] = crcorr_network(n,traces);
%      