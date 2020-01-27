function [timevec,traces,traces_all] = spiketraces(n,spiketimes)

% timestamps=[-1.22 0.33 0.34 0.35 0.40 3.70 7.30]; % sec
% timestamps2=timestamps+2;
% timestamps = [timestamps; timestamps2];


srate=10;      % number of time points per msec 
min_timevec=0;  % msec
max_timevec=2000;   % msec
sigma=2;       % msec standard deviation of gaussian
peak=1;  %value of the peak of the gaussian (use peak=0 for gaussian 
%       integral = 1; thus sum(trace) is equal to the number of spikes) 
 
traces = zeros(n,(max_timevec-min_timevec)*srate+1);
 
 for i = 1:n
    stimes=spiketimes(spiketimes(:,2)==i,1);
    [trace,timevec,~]=spikegauss(stimes,srate,min_timevec,max_timevec,sigma,peak);
    traces(i,:) = trace';

     figure(3) 
     hold on
     plot(timevec,traces(i,:))

 end
 figure(3); hold off;

 traces_all = mean(traces);
 figure(4)
 plot(timevec,traces_all)
 

end