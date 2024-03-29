function myscript(k, sigma)
	% construct similarity matrix
	digits(10)

	if circles == 1
		a = circs;
		[C1, C2] = SpectralClusterModel(a, k, sigma);
 		scatter(C1(1,:), C1(2,:), 'r'); hold on;  scatter(C2(1,:), C2(2,:), 'b'); 
 		figure(1);
	else
		a = imread('bw.jpg');
		[C1, C2] = SpectralClusterModel(reshape(a, 1, []), k, sigma);
		size(C1)
		size(C2)
	end


	function result = findSimilarity(xi, xj, sigma)
		distance = sum(abs(xi-xj))^2;
		result = exp(-(1/2)*(sigma^2) * (distance));
	end


	% Function that calculates the similarity between two values
	function out = constructSimilarityMatrix(A, sigma)
		out = [length(A), length(A)];

		size(A)
		out = pdist2(A', A');


		input('enter to continue')
		%out = squareform(pdist(A'))

	end


	% Function that constructs the diagonal matrix given A
	function D = constructDiagMatrix(A)
		%A = A'
	    D = [zeros(size(A))];
	    for i=1:length(A(:,1))
	        D(i,i) = sum(A(i,:));
	    end     
	end



	% Function that runs the basic Spectral Clustering algorithm
	function [C1, C2] = SpectralClusterModel(matrix, k, sigma)
	    A = constructSimilarityMatrix(matrix, sigma);
	    D = constructDiagMatrix(A);
		L = D - A;
		%L = D^(-.5)*L*D^(-.5)
		[eigvec, eigval] = eig(L)
		eigveck = eigvec(:, 1:k)
				
		S = kmeans(eigveck, k);

	    k1 = zeros(size(matrix(:,1)));
	    k2 = zeros(size(matrix(:,1)));
	    
	    for i=1:length(S)
	       if S(i) == 2
	           k2 = [k2 matrix(:,i)];
	       else
	           k1 = [k1 matrix(:,i)];
	       end
	    end
		C1 = k1(:, 2:end);
	    C2 = k2(:, 2:end);
	    %clusters = [k1; k2]
	end
end