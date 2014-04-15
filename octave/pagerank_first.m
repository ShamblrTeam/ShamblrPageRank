%our initial matrix
H = [0,1/2,1/2,0,0,0; 0,0,0,0,0,0; 1/3,1/3,0,0,1/3,0; 0,0,0,0,1/2,1/2; 0,0,0,1/2,0,1/2; 0,0,0,1,0,0];

%our randomness value
alpha = .9;

%the number of links
n = size(H,1)

%max iterations before cutting off convergence
max_iterations = 10;

%build our stochastic matrix from our link matrix
S = zeros(size(H));
for i=1:size(H,1),
	%if there are no links on site, give the random value
	%to all links
	if (sum(H(i,:)) == 0)
		for j=1:size(H,2),
			S(i,j) = 1/n;
		end
	%else just put the row from H
	else
		for j=1:size(H,2),
			S(i,j) = H(i,j);
		end
	endif
end

%build the vector of ones for the google matrix
e = ones(n,1);

%build our google matrix from our stochastic matrix
G = alpha*S+(((1-alpha)/n)*(e*e'));

%build our pagerank vector
pagerank = (1/n)*ones(1,n);

%run the power method on our google matrix and pagerank vector
for i=1:max_iterations,
	pagerank = pagerank*G;
end

%print our for each page
pagerank


% print a sorted list of our pages by pagerank
pagerank_sorted_list = zeros(1,n);
sorting_rank = pagerank;
for i=1:n,
	max_val = 0;
	max_index = 0;
	for j=1:n,
		if max_val < sorting_rank(1,j),
			max_val = sorting_rank(1,j);
			max_index = j;
		endif
	end
	sorting_rank(1,max_index) = 0;
	pagerank_sorted_list(1,i) = max_index;
end

%print out our sorted rank, the value are indexes
pagerank_sorted_list