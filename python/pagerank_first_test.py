#build the list of connections
f = open('connections.txt','r')
nodes = []
for a in f.readlines():
	if len(a) > 2:
		node = [a.split('=>')[0],[]]
		for b in a.split('=>')[1].split(','):
			if b.strip() != '':
				node[1].append(b.strip())
		nodes.append(node)

#create the matrix and print
node_names = [x[0] for x in nodes]
matrix = []
print "----Matrix-----"
for a in nodes:
	l = [0]*len(nodes)
	if len(a[1]) > 0:
		for b in a[1]:
			if b in node_names:
				l[node_names.index(b)] += 1.0/(len(a[1]))
	print l
	matrix.append(l)
print "----/Matrix-----"


#create the rank values for each link
rank = [1.0/len(nodes)]*len(nodes)

#------ORIGINAL PAGERANK------
#iterate until 'convergence'
max_iter = 100
for a in range(max_iter):
	new_rank = [0]*len(nodes)
	for b in range(len(nodes)):
		#get the inlinks
		inlinks = []
		for c in range(len(nodes)):
			if matrix[c][b] != 0:
				inlinks.append(c)
		#get rank for inlink
		for c in inlinks:
			new_rank[b] += rank[c]/len(nodes[c][1])
	rank = new_rank

print "----Original Pagerank Algorithm Value-----"
print new_rank
print "----/Original Pagerank Algorithm Value----"

for a in range(len(nodes)):
	if len(nodes[a][1]) == 0:
		matrix[a] = [1.0/len(nodes)]*len(nodes)

print "----Stochasticity Matrix-----"
for a in matrix:
	print a
print "----/Stochasticity Matrix----"

random_surfer_alpha = .6
google_matrix = 















