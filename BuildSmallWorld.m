function h = BuildSmallWorld(S,N,K,beta)
% H = BuildSmallWorld(S,N,K,beta) returns a Watts-Strogatz model graph with N
% nodes, N*K edges, mean node degree 2*K, and rewiring probability beta.
%
% beta = 0 is a ring lattice, and beta = 1 is a random graph.

s = repelem((1:N)',1,K);
t = zeros(N,K);
for i=1:N
    distances = zeros(N,1);
    for j=1:N
        if i == j
            distances(j) = 10000000;
        else
            distances(j) = EuclidDist(S(i,:),S(j,:));
        end
    end
    min_dist = zeros(K,1);
    for j=1:K
        min_idx = find(distances == min(distances));
        min_dist(j) = min_idx;
        distances(min_idx) = 10000000;
    end
    t(i,:) = min_dist;
end

% Rewire the target node of each edge with probability beta
for source=1:N
    
    for conn = 1:K
        bool_rewire = (rand(1,1) > beta);
        targets = 1:N; targets(t(source,:)) = [];
        new_target = randi([1 length(targets)],1,1);
        if bool_rewire
            t(source, conn) = targets(new_target);
        end
    end
    
%     switchEdge = rand(K, 1) < beta;
%     
%     newTargets = rand(N, 1);
%     newTargets(source) = 0;
%     newTargets(s(t==source)) = 0;
%     newTargets(t(source, ~switchEdge)) = 0;
%     
%     [~, ind] = sort(newTargets, 'descend');
%     t(source, switchEdge) = ind(1:nnz(switchEdge));
end

h = digraph(s,t);
end