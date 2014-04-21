import subprocess
import sys

if len(sys.argv) > 1:
	connection_location = sys.argv[1]
else:
	connection_location = "test_adjacency.txt"

adjacency_file_location = connection_location.split('.')[0] + "_integers.txt"

blogs = dict()

connections = open(connection_location,'r')
f = open(adjacency_file_location,'w')
for a in connections.readlines():
	if len(a.strip().split(',')) == 2:
		nodes = a.strip().split(',')
		if nodes[0] not in blogs:
			blogs[nodes[0]] = len(blogs)+1
		if nodes[1] not in blogs:
			blogs[nodes[1]] = len(blogs)+1
		f.write(str(blogs[nodes[0]]) + " " + str(blogs[nodes[1]]) + "\n")
f.write(str(len(blogs)+1) + " " + str(len(blogs)+1))

f.close()

names_file_location = connection_location.split('.')[0] + "_names.txt"
f = open(names_file_location,'w')
for a in sorted(blogs):
	f.write(str(a) + " " + str(blogs[a]) + "\n")
f.close()

pagerank_location = connection_location.split('.')[0] + "_pageranks.txt"
output_location = connection_location.split('.')[0] + "_output.txt"

subprocess.call(['octave','new_pagerank.m',adjacency_file_location,pagerank_location])

f1 = open(names_file_location,'r').readlines()
f2 = open(pagerank_location,'r').readlines()
f3 = open(output_location,'w')

for i in range(max([len(f1),len(f2)])):
	if i < len(f1):
		f3.write(f1[i].strip())
		if i < len(f2):
			f3.write(" " + f2[i].strip())
		f3.write("\n")
f3.close()