%our initial matrix
% H = [0,1/2,1/2,0,0,0; 0,0,0,0,0,0; 1/3,1/3,0,0,1/3,0; 0,0,0,0,1/2,1/2; 0,0,0,1/2,0,1/2; 0,0,0,1,0,0];

filename = 'fixed_minimized_adjacency_numbers.txt';

mfile = fopen(filename,'r');
if ( mfile == -1 )
 disp(filename);
 error('File not found\n');
end;

dline = fgetl(mfile);
if (dline == -1 )
  error('Empty file.\n')
end

i=1;
while length(dline) > 0 && dline ~= -1,
  [lstr,dline]=strtok(dline);
  lnum=str2num(lstr);
  if isempty(dline)
    % make sure matrix has correct size
    a(i,1)=lnum;
    a(i,2)=1;
    a(i,3)=0;
    i=i+1
  end
  while ~isempty(dline)
    [cstr,dline]=strtok(dline);
	a(i,1)=lnum;
	a(i,2)=str2num(cstr);
	a(i,3)=1;
	i=i+1
  end
  dline = fgetl(mfile);
end

fprintf('Finished Parsing File\n');

fclose(mfile);

H = spconvert(a);

fprintf('Finished Converting Matrix\n');


%our randomness value
alpha = .9;

%the number of links
n = size(H,1)

%max iterations before cutting off convergence
max_iterations = 10;

%build our stochastic matrix from our link matrix
fprintf('Building the Stochastic Matrix\n');
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
fprintf('Finished building the Stochastic Matrix\n');

%build the vector of ones for the google matrix
e = ones(n,1);

%build our google matrix from our stochastic matrix
fprintf('Building the Google Matrix\n');
G = alpha*S+(((1-alpha)/n)*(e*e'));
fprintf('Finish Building the Google Matrix\n');
%build our pagerank vector
pagerank = (1/n)*ones(1,n);

%run the power method on our google matrix and pagerank vector
for i=1:max_iterations,
	fprintf('Iteration %d\n',i);
	pagerank = pagerank*G;
end

%print our for each page
dlmwrite('pagerank_values.txt',pagerank);


% print a sorted list of our pages by pagerank

%pagerank_sorted_list = zeros(1,n);
%sorting_rank = pagerank;
%for i=1:n,
%	max_val = 0;
%	max_index = 0;
%	for j=1:n,
%		if max_val < sorting_rank(1,j),
%			max_val = sorting_rank(1,j);
%			max_index = j;
%		endif
%	end
%	sorting_rank(1,max_index) = 0;
%	pagerank_sorted_list(1,i) = max_index;
%end

%print out our sorted rank, the value are indexes
%pagerank_sorted_list