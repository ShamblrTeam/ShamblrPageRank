H = [0,1/2,1/2,0,0,0; 0,0,0,0,0,0; 1/3,1/3,0,0,1/3,0; 0,0,0,0,1/2,1/2; 0,0,0,1/2,0,1/2; 0,0,0,1,0,0];
S = [0,1/2,1/2,0,0,0; 1/6,1/6,1/6,1/6,1/6,1/6; 1/3,1/3,0,0,1/3,0; 0,0,0,0,1/2,1/2; 0,0,0,1/2,0,1/2; 0,0,0,1,0,0];
alpha = .9;
n = 6;
e = ones(n,1);
max_iterations = 10;

G = alpha*S+(((1-alpha)/n)*(e*e'));

pagerank = (1/n)*ones(1,n);

for i=1:max_iterations,
	pagerank = pagerank*G;
end
pagerank

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
pagerank_sorted_list