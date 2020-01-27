function [S] = SpatialMatrix(arg, n, custom)
    
    rand('twister',5489); randn('state',0); 

    S = zeros(n,3);

    n_neurons = 8.6*10^10; %Number of neurons on average
    v_brain = 1.45*10^6; %Average brain volume in mm^3
    total_density = n_neurons/v_brain;
    vor = n/total_density; %volume of region containing n neurons
    len = vor^(1/3);
    
    if (strcmp(arg,'Even'))
        
        S=S.*((vor/n^3)^(1/3));
    elseif (strcmp(arg,'Random'))
        for i=1:n
            S(i,1) = len*rand;
            S(i,2) = len*rand;
            S(i,3) = len*rand;
        end
    elseif (strcmp(arg,'Planar_Even'))
        for i=1:n
            for j=1:n
                for k=1:n
                    S(i,j,k)=[i,j,0];
                end
            end
        end
        S=S.*((vor/n^3)^(2/3));
    elseif (strcmp(arg,'Planar_Random'))
        for i=1:n
            for j=1:n
                for k=1:n
                    S(1) = len*rand;
                    S(2) = len*rand;
                    S(3) = 0;
                end
            end
        end
    elseif (strcmp(arg,'Custom'))
        S = custom;
    else
        S = 0;
    end
end