%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% K-Means Alternative Clustering - p2_2 %%%
% Scott Gaydos - scg104020 - 11/6/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate the circles
circles = circs;

% Use kmeans to cluster them
clusters = kmeans(circles', 2);

cluster1 = zeros(1,2)
cluster2 = zeros(1,2)

% create the clusters 
for i=1:length(clusters)
	if clusters(i) == 1
		cluster1 = [cluster1; circles(:,i)'];
	else
		cluster2 = [cluster2; circles(:,i)'];
	end
end

% Plot the data
scatter(cluster1(2:end,1), cluster1(2:end,2), 'r'); 
hold on;  
scatter(cluster2(2:end,1), cluster2(2:end,2), 'b');

% Show the plot
figure(1)