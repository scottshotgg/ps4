% construct similarity matrix

a = [1,2,3,4,5,6,7,8,9,10]

disp(similarity(a))


function result = math(xi, xj, sigmabutnotreally)
	result = exp(-(1/2(sigmabutnotreally)^2) * abs(xi - xj)^2)
end


% Function that calculates the similarity between two values
function out = similarity(A)
	for i=1:length(A(:,1))
		for j=i:length(A(1,:))
			disp(i + string(', ') + j)
		end
	end
end
