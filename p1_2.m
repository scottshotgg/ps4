%%% Naive Bayes Classifier - p1_2 %%%
% Scott Gaydos - scg104020 - 11/5/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Set the precision to 100 or else at the end you will be comparing 0 with 0
digits(100)



%%% Load the training data file and strip out the features and classes
data = load('spam_train.data');
x = data(:, 1:end-1);
y = data(:, end);



%%% Seperate the data by classes and count the amount of each class
x0 = zeros(1,length(x(1,:)));
x1 = zeros(1,length(x(1,:)));
o = 0;
z = 0;

for i=1:length(data)
	if y(i) == 0
		z = z + 1;
		x0 = [x0; x(i,:)];
	else
		o = o + 1;
		x1 = [x1; x(i,:)];
	end
end



%%% Calculate probabilities of each class
op = o / (o + z);
zp = z / (o + z);
disp(string('Class 0 probability ') + zp)
disp(string('Class 1 probability ') + op)



%%% Calculate the mean and std of each feature according to its class
% Skip the first vector because it was all 0's from the matrix constuction
mean0 = mean(x0(2:end,:));
std0 = std(x0(2:end,:));
mean1 = mean(x1(2:end,:));
std1 = std(x1(2:end,:));



% Print out the accuracy of each dataset using the defined classify function
disp('The training accuracy is ' + classify('spam_train.data', mean0, std0, mean1, std1, zp, op))
disp('The testing accuracy is ' + classify('spam_test.data', mean0, std0, mean1, std1, zp, op))




%%% Define a function that we will use to determine the accuracy of a dataset
function accuracy = classify(filename, mean0, std0, mean1, std1, zp, op) 
	%%% Load the test data file and strip out the features and classes
	testdata = load(filename);
	testx = testdata(:, 1:end-1);
	testy = testdata(:, end);



	%%% Use the mean and std from the training set to calculate the test set probabilities
	omatrix = zeros(1, length(testx(1,:)));
	zmatrix = zeros(1, length(testx(1,:)));

	for j = 1:length(testdata)
		for i = 1:length(testx(1,:))
			zarray(i) = normpdf(testx(j,i), mean0(i), std0(i));
			oarray(i) = normpdf(testx(j,i), mean1(i), std1(i));
		end
		zmatrix = [zmatrix; zarray];
		omatrix = [omatrix; oarray];
	end
	% Shave off the first vector due to matrix constuction
	zmatrix = zmatrix(2:end,:);
	omatrix = omatrix(2:end,:);


	%%% Calculate the final compounded probability for each data point
	% We can ignore the denominator of the Bayes formula because it is effectively a constant
	ofinal = zeros(1,length(testx(1,:)));
	zfinal = zeros(1,length(testx(1,:)));

	for i=1:length(omatrix)
	zfinal(i) = prod(zmatrix(i,:)) * zp;
	ofinal(i) = prod(omatrix(i,:)) * op;
	end



	%%% Classify the points by comparing their class probabilities
	fx = zeros(1, length(testdata));

	for i=1:length(testdata)
		if ofinal(i) ~= zfinal(i)
			if(ofinal(i) > zfinal(i));
				fx(i) = 1;
			% else it is already 0 from the construction statement
			end
		else % if they are equal then pick the value at random
			fx(i) = round(rand);
		end
	end



	%%% Count the amount of correctly classified points
	fxcorrect = 0;
	for i=1:length(fx)
		if fx(i) == testy(i) 
			fxcorrect = fxcorrect + 1;
		end
	end

	% return string with accuracy value in percentage form
	accuracy = string(100 * fxcorrect / length(testdata)) + string('%');
end