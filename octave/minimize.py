f = open("adjacency_numbers.txt",'r')
g = open("minimized_adjacency_numbers.txt",'w')

for a in f.readlines():
	if len(a.strip().split(' ')) > 1:
		g.write(a)
g.close()

