function [t,v,te,gna_t,gk_t,ina,ik,itotal] = RTM(pulsei)
tspan = [0 150];
v0 = [-64.9997;0.5961;0.3177];
te=[];

% % Call the ODE solver ode15s.
% options = odeset('MaxStep',1);
% [t,v] = ode15s(@hh,tspan,v0,options);

% include option to save spike times: times in te, variables in ve, event
% type in ie
options = odeset('Events',@spikes,'MaxStep',1);
[t,v,te,ve,ie] = ode15s(@hh,tspan,v0,options);

% figure(1)
% plot(t,v(:,1))

% compute conductances and currents
% gna=120;
%     gk=36;
%     gl=0.3;
%     ena=50;
%     ek=-77;
%     el=-54.4;
vm=v(:,1);
%m=v(:,2);
h=v(:,2);
n=v(:,3);
gna_t=gna*minf^3.*h;
gk_t=gk*n.^4;
ina=gna*minf^3.*h.*(vm-ena);
ik=gk*n.^4.*(vm-ek);
itotal=gna*minf^3.*h.*(vm-ena)+gk*n.^4.*(vm-ek)+gl*(vm-el);


    % Define the ODE function as nested function, 
    % using the parameter pulsei.
    function dvdt = hh(t,v)
    c=1;
    gna=100;
    gk=80;
    gl=0.1;
    ena=50;
    ek=-100;
    el=-67;
    ton=0;
    toff=1000;
    
    minf = alpham(v(1)) / (alpham(v(1)) + betam(v(1)));
    
    dvdt(1) = (-gna*(minf^3)*v(2)*(v(1)-ena)-gk*(v(3)^4)*(v(1)-ek)...
            -gl*(v(1)-el) + pulsei*heaviside(t-ton)*heaviside(toff-t))/c;
    % dvdt(2) = alpham(v(1))*(1-v(2))-betam(v(1))*v(2);
    dvdt(2) = alphah(v(1))*(1-v(2))-betah(v(1))*v(2);
    dvdt(3) = alphan(v(1))*(1-v(3))-betan(v(1))*v(3);
    dvdt=dvdt';
    
        function am=alpham(x)
            am=(0.32)*(x+54)/(1-exp(-(x+54)/4));
        end
        
        function bm=betam(x)
            bm=(0.28)*(x+27)/(exp((x+27)/5)-1);
        end
        
        function ah=alphah(x)
            ah=0.128*exp(-(x+50)/18);
        end
        
        function bh=betah(x)
            bh=4/(1+exp(-(x+27)/5));
        end
        
        function an=alphan(x)
            an=(0.032*(x+52))/(1-exp(-(x+52)/5));
        end
        
        function bn=betan(x)
            bn=0.5*exp(-(x+57)/40);
        end
    end

% Events function to output spike times
    function [value,isterminal,direction] = spikes(t,v)
        % Locate the time voltage increases through -10mV
        value = v(1)+10;     % Detect height = 0
        isterminal = 0;   % Don't stop the integration
        direction = +1;   % positive direction only
    end

end
