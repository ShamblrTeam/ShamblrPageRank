import subprocess
import sys
from os import walk

listOfFileToProcess = []
filePreFix = ""
connection_location = ""

if len(sys.argv) < 2:
	connection_location = "test_adjacency.txt"
elif len(sys.argv) == 2:
	connection_location = sys.argv[1]
elif len(sys.argv) == 3:
	if(sys.argv[1] == "-c"):
		#Read in list of files in the directory
		#code borrowed from: http://stackoverflow.com/questions/3207219/how-to-list-all-files-of-a-directory-in-python
		mypath="."
		filePreFix = sys.argv[2]
		for (dirpath, dirnames, filenames) in walk(mypath):
		    for currFile in filenames:
		    	if str(currFile).startswith(filePreFix) and ("integers.txt" not in str(currFile)) and ("_names.txt" not in str(currFile))::
		    		listOfFileToProcess.append(currFile)
		    break
else:
	print "Usage: "
	print "Process segemented files: Full_Rank.py -c 'filename' \n"
	print "Process single file:      Full_Rank.py 'filename'\n"
	print "Process defualt test_adjancency.txt:  Full_Rank.py\n"


if len(listOfFileToProcess) == 0:
	listOfFileToProcess.append(connection_location)



adjacency_file_location = listOfFileToProcess[0].split('.')[0] + "_integers.txt"

blogs = dict()
f = open(adjacency_file_location,'w')
for curr_connection_location in listOfFileToProcess:
	connections = open(curr_connection_location,'r')
	
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

names_file_location = listOfFileToProcess[0].split('.')[0] + "_names.txt"
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