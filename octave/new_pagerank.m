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
    i=i+1;
  end
  while ~isempty(dline)
    [cstr,dline]=strtok(dline);
	a(i,1)=lnum;
	a(i,2)=str2num(cstr);
	a(i,3)=1;
	i=i+1;
  end
  dline = fgetl(mfile);
end

fprintf('Finished Parsing File \n');

fclose(mfile);

H = spconvert(a);

fprintf('Finished Converting Matrix \n');


%our randomness value
alpha = .9;

%the number of links
n = size(H,1)

%max iterations before cutting off convergence
max_iterations = 10;

%build our pagerank vector
fprintf('Building Elements\n');
pagerank = (1/n)*ones(1,n);
rowsumvector = ones(1,n)*H;
nonzerorows = find(rowsumvector);
zerorows = setdiff(1:n,nonzerorows); l = length(zerorows);
a = sparse(zerorows,ones(l,1),ones(l,1),n,1);
fprintf('Finished Building Elements\n');

%run the power method on our google matrix and pagerank vector
for i=1:max_iterations,
	fprintf('Finished Iteration %d\n',i);
	pagerank = alpha*pagerank*H + (alpha*(pagerank*a)*(1/n)*ones(1,n));
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