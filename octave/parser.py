#This is used for generating adjacency list in old way from connection. Mainly for Visualization team's usage
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
		    	if str(currFile).startswith(filePreFix):
		    		listOfFileToProcess.append(currFile)
		    break
else:
	print "Usage: "
	print "Process segemented files: Full_Rank.py -c 'filename' \n"
	print "Process single file:      Full_Rank.py 'filename'\n"
	print "Process defualt test_adjancency.txt:  Full_Rank.py\n"


if len(listOfFileToProcess) == 0:
	listOfFileToProcess.append(connection_location)

for currFile in listOfFileToProcess:
	#open the file
	inputFile = open(currFile,'r')

	#build the adjcency list as a dict
	adj_list = {}

	#read the file into dict
	for entry in inputFile.readlines():
		if len(entry) > 2:
			OrigBlogName, ReblogName = entry.rstrip().split(',')
			if (OrigBlogName not in adj_list):
				adj_list[OrigBlogName] = []

			if (ReblogName not in adj_list):
				adj_list[ReblogName] = []

			if (ReblogName not in adj_list[OrigBlogName]):
				adj_list[OrigBlogName].append(ReblogName)
	inputFile.close()

outFile = open('connections.txt','w')

for node , outLinks in adj_list.items():
	currNodeOutput = node + '=>'
	if len(outLinks) > 0:
		currOutLinkOuput = ','.join(outLinks)
		currNodeOutput = currNodeOutput+ currOutLinkOuput +'\n'
	else:
		currNodeOutput = currNodeOutput + '\n'
	outFile.write(currNodeOutput)
	outFile.flush()