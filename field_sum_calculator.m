function [t,v,spiketimes] = field_sum_calculator(S, spiketimes_i, spiketimes_e, t, dt) 

    spiketimes = vertcat(spiketimes_e, spiketimes_i);
    spiketimes=(floor(spiketimes/dt))*dt;
    n = size(S,1);

    [t_rtm,v_rtm,~,~,~,~,~,~] = RTM(0.201);
    t_rtm = t_rtm(78:258); v_rtm = v_rtm(78:258)';

    v_spline = spline(t_rtm,v_rtm,0:dt:t_rtm(end))';
    v_spline(1:(50/dt)) = []; v_spline((40/dt):end) = []; 
    t_spline = (0:dt:t_rtm(end))';
    t_spline(1:(50/dt)) = []; t_spline((40/dt):end) = []; 
    t_spline = t_spline - t_spline(1);

    % figure
    % plot(t_spline,v_spline)
    
    t_thr = find((v_spline > 30),1);

    elec_pos = [mean(S(1)), 1.1*max(S(2)), mean(S(3))];

    radius = zeros(n,1);
    field = zeros(n,1);

    rho = 351;
    for i=1:n
        radius(i) = EuclidDist(S(i,:),elec_pos)*(10^9);
        field(i) = (rho/(4*pi*radius(i)));
    end

    v = zeros(length(t),1);

    for i=1:length(spiketimes)
        neuron = spiketimes(i,2);
        neur_field = field(neuron);
        for j = 1:length(t_spline)
            t2 = floor(spiketimes(i)/dt - t_thr + j);
            if t2 > 0
                if (t2 < (t(end)/dt))
                    v(t2) = v(t2) + neur_field*(v_spline(j)-v_spline(1));
                end
            end
        end
    end