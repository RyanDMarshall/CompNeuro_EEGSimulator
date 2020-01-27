clear;clc;close all;

ConnectivityMatrix
[spiketimes]=LIF2D_simple_network(n,W,1,0.5);
[mean,npc,mpc_cellpairs]=mpc_network(n,spiketimes);
[timevec,traces,traces_all] = spiketraces(n,spiketimes);